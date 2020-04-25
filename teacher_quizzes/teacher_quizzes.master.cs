using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace onlineQuiz_bsef17m35.teacher_quizes
{
  public partial class teacher_quizes : System.Web.UI.MasterPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public void ValidateSession()
    {
      /* validate outer level of session */
      Master.ValidateSession();

      try
      {
        if (String.IsNullOrEmpty((String)Session["userType"]) ||
          (String)Session["userType"] != "teacher")
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