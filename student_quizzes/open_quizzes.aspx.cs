using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35.student_quizzes
{
  public partial class open_quizzes : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      /* validate session */
      Master.ValidateSession();

      DatabaseEntities db = new DatabaseEntities();
      var openQuizzes = db.getOpenQuizzes(Int32.Parse((String)Session["userId"])).ToArray();

      foreach (var openQuiz in openQuizzes)
      {
        if (string.IsNullOrEmpty(openQuiz.description))
        {
          openQuiz.description = "No Description";
        }
      }

      openQuizzesRepeater.DataSource = openQuizzes;
      openQuizzesRepeater.DataBind();
    }

    protected void OpenQuiz(object sender, EventArgs e)
    {
      var teacherId = Int32.Parse(((Button)sender).CommandName);
      var quizId = Int32.Parse(((Button)sender).CommandArgument);

      Response.Redirect("/student_quizzes/take_quiz.aspx?teacherId=" + teacherId
        + "&quizId=" + quizId);
    }
  }
}