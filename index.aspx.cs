using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
  public partial class home : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

      try
      {
        if (String.IsNullOrEmpty((String)Session["userId"]) ||
          String.IsNullOrEmpty((String)Session["firstName"]) ||
          String.IsNullOrEmpty((String)Session["userType"]) ||
          String.IsNullOrEmpty((String)Session["profilePicture"]))
        {
          String userId = Request.Cookies["login"]["userId"];
          String userFirstName = Request.Cookies["login"]["firstName"];
          String userType = Request.Cookies["login"]["userType"];
          String profilePicture = Request.Cookies["login"]["profilePicture"];

          try
          {
            if (string.IsNullOrEmpty(userId) ||
                string.IsNullOrEmpty(userFirstName) ||
                string.IsNullOrEmpty(userType) ||
                string.IsNullOrEmpty(profilePicture))
            {
              throw new Exception();
            }
            Int32.Parse(userId);
          }
          catch (Exception)
          {
            throw new Exception();
          }

          Session["userId"] = userId;
          Session["firstName"] = userFirstName;
          Session["userType"] = userType;
          Session["profilePicture"] = profilePicture;
          Session.Timeout = 60;
        }

        if ((String)Session["userType"] == "teacher")
        {
          Response.Redirect("/teacher_quizzes/all_quizzes.aspx");
        }
        else
        {
          Response.Redirect("/student_quizzes/open_quizzes.aspx");
        }
      }
      catch (Exception error)
      {
        if (error is System.Threading.ThreadAbortException)
        {
          return; // safely ignore this exception
        }

        if (!(error is Exception) && !(error is System.NullReferenceException))
        {
          throw error;
        }
      }
    }
  }
}