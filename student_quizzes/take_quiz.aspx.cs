using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.IO;

namespace onlineQuiz_bsef17m35.student_quizzes
{
  public partial class take_quiz : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      try {
        if (string.IsNullOrEmpty(Request.QueryString["quizId"]) ||
          string.IsNullOrWhiteSpace(Request.QueryString["teacherId"])) {
          throw new Exception();
        }

        var quizId = Int32.Parse(Request.QueryString["quizId"]);
        var teacherId = Int32.Parse(Request.QueryString["teacherId"]);

        var db = new DatabaseEntities();
        var quiz = db.Quiz.Where(q => q.id == quizId && q.teacherId == teacherId).Single();

        quizTitle.InnerText = quiz.title;
        quizDescription.InnerText = quiz.description;
        totalMarks.InnerText = quiz.totalMarks.ToString();
        totalQuestions.InnerText = quiz.Question.Count().ToString();
        var localQuiz = LocalQuiz.ToLocalQuiz(quiz);

        /* remove correct answer hints from options */
        foreach (var q in localQuiz.questions)
        {
          if (q.type == "Multiple Choice" || q.type == "Checkboxes")
          {
            foreach (var o in q.options)
            {
              o.valid = false;
            }
          }
        }

        quizJSON.Value = JsonConvert.SerializeObject(localQuiz);

        if (string.IsNullOrEmpty(quizDescription.InnerText))
        {
          quizDescription.InnerText = "This quiz has no description!";
        }

        /* register client scripts */
        Type scriptType = this.GetType();
        String scriptName = "script";
        String scriptUrl = "./take_quiz.js";
        String scriptText = File.ReadAllText(Server.MapPath(scriptUrl));
        ClientScriptManager scriptManager = Page.ClientScript;
        if (!scriptManager.IsClientScriptBlockRegistered(scriptType, scriptName))
        {
          scriptManager.RegisterClientScriptBlock(scriptType, scriptName, scriptText, true);
        }
      } catch (Exception err)
      {
        takeQuizError.InnerText = "Unable to load quiz! Some unknown error occured.";
        takeQuizError.Visible = true;
        takeQuizView.Visible = false;
      }
    }

    protected void realSubmitButton_ServerClick(object sender, EventArgs e)
    {
      takeQuizError.Visible = false;

      try {
        var quizContents = quizJSON.Value;
        var quiz = JsonConvert.DeserializeObject<LocalQuiz>(quizContents);
        var db = new DatabaseEntities();
        var submission = new Submission();
        submission.teacherId = quiz.teacherId;
        submission.quizId = quiz.id;
        submission.studentId = Int32.Parse(Session["userId"].ToString());
        submission.content = quizContents;
        db.Submission.Add(submission);
        db.SaveChanges();
        Response.Redirect("/student_quizzes/my_submissions.aspx?Message=sumbitted");
      } catch (Exception err)
      {
        if (!(err is System.Threading.ThreadAbortException)) {
          takeQuizError.Visible = true;
          takeQuizError.InnerText = "Something went wrong! Unable to submit your quiz!";
        }
      }
    }
  }
}