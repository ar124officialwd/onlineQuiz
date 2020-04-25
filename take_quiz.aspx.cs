using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35
{
  public partial class take_quiz : System.Web.UI.Page
  {
    public take_quiz()
    {
      
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      try
      {
        var teacherEmail = Request.QueryString["teacherEmail"];
        int quizId = -1;

        try
        {
          quizId = int.Parse(Request.QueryString["quizId"]);
        } catch(Exception)
        {
          throw new NoRecordException();
        }

        if (String.IsNullOrEmpty(teacherEmail) || quizId < 0)
        {
          throw new NoRecordException();
        }

        var db = new DatabaseEntities();
        // var quiz = db.getQuiz(teacherEmail, quizId);
      } catch(NoRecordException)
      {
        //
      }
    }
  }
}