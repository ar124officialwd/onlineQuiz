using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace onlineQuiz_bsef17m35.student_quizzes
{
  public partial class student_quizzes : System.Web.UI.MasterPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public void ValidateSession()
    {
      try
      {
        /* validate outer level of session
          * There all session variables are validated except that
            userType is really 'student'
        */
        Master.ValidateSession();

        if (String.IsNullOrEmpty((String)Session["userType"]) ||
          (String)Session["userType"] != "student")
        {
          throw new SessionException();
        }
      }
      catch (SessionException)
      {
        Master.Logout();
      }
    }

  }
}