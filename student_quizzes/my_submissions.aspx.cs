using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace onlineQuiz_bsef17m35.student_quizzes
{
  public partial class my_submissions : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      var studentId = Int32.Parse((string)Session["userId"]);
      var database = new DatabaseEntities();
      var submissions = database.getMySubmissions(studentId).ToArray();
      quizRepeater.DataSource = submissions;
      quizRepeater.DataBind();

      foreach (RepeaterItem item in quizRepeater.Items)
      {
        var submission = submissions[item.ItemIndex];
        var content = JsonConvert.DeserializeObject<LocalQuiz>(submission.content);

        if (content.questions.Length <= 0)
        {
          item.Visible = false;
          return;
        }

        var questions = (Repeater)item.FindControl("questionRepeater");
        if (questions != null)
        {
          questions.DataSource = content.questions;
          questions.DataBind();

          foreach (RepeaterItem item1 in questions.Items)
          {
            var question = content.questions[item1.ItemIndex];
            if (question.type == "Checkboxes")
            {
              var answers = (Repeater)item1.FindControl("answers");
              if (answers != null)
              {
                answers.DataSource = content.questions[item.ItemIndex].answers;
                answers.DataBind();
              }
            }
          }
        }
      }
    }
  }
}