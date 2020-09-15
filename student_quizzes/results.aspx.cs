using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35.student_quizzes
{
  public partial class results : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      var studentId = Int32.Parse(Session["userId"].ToString());
      var database = new DatabaseEntities();
      var results = database.getResults(studentId);
      resultRepeater.DataSource = results;
      resultRepeater.DataBind();

      foreach (RepeaterItem item in resultRepeater.Items)
      {
        var status = (Label)item.FindControl("status");
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

    protected void resultActions(object sender, EventArgs e)
    {

    }
  }
}