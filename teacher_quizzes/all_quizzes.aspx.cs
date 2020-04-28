using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace onlineQuiz_bsef17m35.teacher_quizes
{
  public partial class all_quizzes : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      /* validate login first */
      Master.ValidateSession();

      DatabaseEntities db = new DatabaseEntities();
      var teacherId = (String)Session["userId"];
      var allQuizzes = db.getAllQuizzes(Int32.Parse(teacherId)).ToArray();
      AllQuizzesRepeater.DataSource = allQuizzes;
      AllQuizzesRepeater.DataBind();
    }

    protected void ViewQuiz_Click(object sender, EventArgs e)
    {
      var quizId = Int32.Parse(((LinkButton)sender).CommandArgument);
      var teacherId = Int32.Parse(Session["userId"].ToString());

      Response.Redirect("/teacher_quizzes/view_quiz.aspx?teacherId=" + teacherId +
        "&quizId=" + quizId);
    }
  }
}
