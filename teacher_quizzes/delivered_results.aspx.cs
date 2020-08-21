using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35.teacher_quizzes
{
  public partial class delivered_results : System.Web.UI.Page
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
      var quizzes = database.Quiz.Where(q => q.teacherId == teacherId).ToArray();
      quizRepeater.DataSource = quizzes;
      quizRepeater.DataBind();

      foreach (RepeaterItem item in quizRepeater.Items)
      {
        var quiz = quizzes[item.ItemIndex];
        var results = database.getDeliveredResults(teacherId, quiz.id).ToArray();

        if (results.Length <= 0)
        {
          item.Visible = false;
          continue;
        }

        var resultRepeater = (Repeater)item.FindControl("resultRepeater");
        if (resultRepeater != null)
        {
          resultRepeater.DataSource = results;
          resultRepeater.DataBind();

          foreach (RepeaterItem result in resultRepeater.Items)
          {
            var status = (Label)result.FindControl("status");
            if (status != null)
            {
              if (status.Text == "Passed")
              {
                status.CssClass += " text-success";
              } else
              {
                status.CssClass += " text-danger";
              }
            }
          }
        }
      }
    }
  }
}