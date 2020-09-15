using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35.teacher_quizzes
{
  public partial class submissions : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      Master.ValidateSession();

      var teacherId = Int32.Parse(Session["userId"].ToString());
      var database = new DatabaseEntities();
      var quizzes = database.getAllQuizzes(teacherId).Where(q => q.submissionCount > 0).ToArray();
      quizRepeater.DataSource = quizzes;
      quizRepeater.DataBind();

      foreach (RepeaterItem item in quizRepeater.Items)
      {
        var submissionRepeater = (Repeater)item.FindControl("submissionRepeater");

        if (submissionRepeater != null)
        {
          var submissions = database.getSubmissions(teacherId, quizzes[item.ItemIndex].id).ToArray();

          if (submissions.Count() <= 0)
          {
            item.Visible = false;
            continue;
          }

          submissionRepeater.DataSource = submissions;
          submissionRepeater.DataBind();
        }
      }
    }

    protected void evaluate_Click(object sender, EventArgs e)
    {
      var quizId = ((Button)sender).CommandName;
      var studentId = ((Button)sender).CommandArgument;
      Response.Redirect("evaluate_quiz.aspx?quizId=" + quizId +
        "&studentId=" + studentId);
    }
  }
}