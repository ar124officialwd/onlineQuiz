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

      foreach (RepeaterItem item in AllQuizzesRepeater.Items)
      {
        if (allQuizzes[item.ItemIndex].submissionCount > 0)
        {
          var editButton = (LinkButton)item.FindControl("editButton");
          if (editButton != null)
          {
            editButton.Enabled = false;
            editButton.ToolTip = "This item cannot be edited!";
          }

          var deleteButton = (LinkButton)item.FindControl("deleteButton");
          if (deleteButton != null)
          {
            deleteButton.Enabled = false;
            deleteButton.ToolTip = "This item cannot be deleted!";
          }
        }
      }
    }

    protected void ViewQuiz_Click(object sender, EventArgs e)
    {
      var quizId = Int32.Parse(((Button)sender).CommandArgument);
      var userId = (string)Session["userId"];

      if (string.IsNullOrEmpty(userId))
      {
        Response.Redirect("/index.aspx");
      }

      var teacherId = Int32.Parse(userId);

      Response.Redirect("/teacher_quizzes/view_quiz.aspx?teacherId=" + teacherId +
        "&quizId=" + quizId);
    }

    protected void CommandHandler(object source, RepeaterCommandEventArgs e)
    {
      if (e.CommandName == "Edit")
      {
        Response.Redirect("/teacher_quizzes/new_quiz.aspx?quizId=" + e.CommandArgument.ToString());
      }

      if (e.CommandName == "Delete")
      {
        try
        {
          var database = new DatabaseEntities();
          var quizId = Int32.Parse(e.CommandArgument.ToString());
          var teacherId = Int32.Parse(Session["userId"].ToString());

          var quiz = database.Quiz.Where(q => q.teacherId == teacherId &&
            q.id == quizId).Single();

          var localQuiz = LocalQuiz.ToLocalQuiz(quiz);
          localQuiz.DeleteQuiz(database);

          e.Item.Visible = false;
        }
        catch
        {
          // 
        }
      }
    }
  }
}
