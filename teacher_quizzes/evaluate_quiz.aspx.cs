using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace onlineQuiz_bsef17m35.teacher_quizzes
{
  public partial class evaluate_quiz : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      Master.ValidateSession();

      var teacherId = Int32.Parse(Session["userId"].ToString());
      var quizId = -1;
      var studentId = -1;

      try
      {
        quizId = Int32.Parse(Request.QueryString["quizId"]);
        studentId = Int32.Parse(Request.QueryString["studentId"]);
        var database = new DatabaseEntities();

        var dbSubmission = database.getSubmission(teacherId, quizId, studentId).Single();
        var submissionJSON = dbSubmission.content;
        var submission = JsonConvert.DeserializeObject<LocalQuiz>(submissionJSON);

        quizTitle.InnerText = submission.title;
        studentName.InnerText = dbSubmission.studentName;
        studentEmail.InnerText = dbSubmission.studentEmail;

        ViewState["questions"] = JsonConvert.SerializeObject(submission.questions);
        ViewState["totalMarks"] = submission.totalMarks;
        ViewState["passingMarks"] = submission.passingMarks;
        ViewState["quizId"] = submission.id;
        ViewState["teacherId"] = submission.teacherId;
        ViewState["studentId"] = studentId;

        questionRepeater.DataSource = submission.questions;
        questionRepeater.DataBind();

        foreach (RepeaterItem item in questionRepeater.Items)
        {
          var q = submission.questions[item.ItemIndex];
          var gradeControl = (TextBox)item.FindControl("questionGrades");

          if (q.type == "Multiple Choice")
          {
            var correctOption = database.QuestionOption.Where(qo =>
              qo.questionId == q.id && qo.teacherId == teacherId &&
              qo.quizId == quizId && qo.valid == true).Single();
            var grade = (correctOption.value == q.answer) ? q.marks : 0;

            if (gradeControl != null)
            {
              gradeControl.Text = grade.ToString();
              gradeControl.Enabled = false;
            }

            continue;
          }

          if (q.type == "Checkboxes")
          {
            /* show answers */
            var answers = (Repeater)item.FindControl("answers");
            if (answers != null)
            {
              answers.DataSource = q.answers;
              answers.DataBind();
            }

            /* set grade */
            var correct = true;
            var correctOptions = database.QuestionOption.Where(qo =>
              qo.questionId == q.id && qo.teacherId == teacherId &&
              qo.quizId == quizId && qo.valid == true).ToList();

            if (correctOptions.Count() != q.answers.Count())
            {
              correct = false;
            } else
            {
              foreach (var o in correctOptions)
              {
                if (!q.answers.ToList().Contains(o.value))
                {
                  correct = false;
                  break;
                }
              }
            }

            int grade = correct ? q.marks : 0;
            if (gradeControl != null)
            {
              gradeControl.Text = grade.ToString();
              gradeControl.Enabled = false;
            }
          }
        }
      }
      catch (Exception err)
      {
        Response.Redirect("/teacher_quizzes/all_quizzes.aspx");
      }
    }

    protected void issueResult_ServerClick(object sender, EventArgs e)
    {
      evaluate();
      var _obtainedMarks = Int32.Parse(marksObtained.InnerText);
      var _status = status.InnerText;
      var database = new DatabaseEntities();

      try
      {
        var result = new Result();
        result.quizId = Int32.Parse(ViewState["quizId"].ToString());
        result.teacherId = Int32.Parse(ViewState["teacherId"].ToString());
        result.studentId = Int32.Parse(ViewState["studentId"].ToString());
        result.obtainedMarks = _obtainedMarks;
        result.status = _status;
        result.questions = ViewState["questions"].ToString();

        database.Result.Add(result);
        database.SaveChanges();

        resultIssued.Visible = true;
        mainView.Visible = false;
      } catch(Exception _err)
      {
        issueResultError.InnerText = "Something went wrong! Unabled to issue result";
        issueResultError.Visible = true;
      }
    }

    protected void reviewResult_ServerClick(object sender, EventArgs e)
    {
      evaluate();
      resultPreview.Visible = true;
      evaluationView.Visible = false;
    }

    protected void reEvaluateResult_ServerClick(object sender, EventArgs e)
    {
      resultPreview.Visible = false;
      evaluationView.Visible = true;
    }

    protected void evaluate()
    {
      var _obtainedMarks = 0;
      var _totalMarks = Int32.Parse(ViewState["totalMarks"].ToString());
      var _passingMarks = Int32.Parse(ViewState["passingMarks"].ToString());

      foreach(RepeaterItem item in questionRepeater.Items)
      {
        var grade = (TextBox)item.FindControl("questionGrades");
        if (grade != null)
        {
          _obtainedMarks += Int32.Parse(grade.Text);
        }

        var questions = JsonConvert
          .DeserializeObject<LocalQuestion[]>(ViewState["questions"].ToString());
        questions[item.ItemIndex].obtainedMarks = Int32.Parse(grade.Text);
        ViewState["questions"] = JsonConvert.SerializeObject(questions);
      }

      totalMarks.InnerText = _totalMarks.ToString();
      passingMarks.InnerText = _passingMarks.ToString();
      marksObtained.InnerText = _obtainedMarks.ToString();

      if (_obtainedMarks >= _passingMarks)
      {
        status.InnerText = "Passed";
        status.Attributes["class"] = "text-success";
      } else
      {
        status.InnerText = "Failed";
        status.Attributes["class"] = "text-danger";
      }
    }
  }
}