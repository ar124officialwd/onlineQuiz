using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace onlineQuiz_bsef17m35
{
  public partial class login : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        loginErrors.Visible = false;
        return;
      }

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
          } catch (Exception)
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
        } else
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

    protected void loginButton_ServerClick(object sender, EventArgs e)
    {
      var _email = email.Value;
      var _password = password.Value;

      DatabaseEntities db = new DatabaseEntities();
      EndUser user = null;

      try
      {
        try {
          user = db.EndUser.First(eu => eu.email == _email && eu.password == _password);
        } catch
        {
          throw new SessionException();
        }

        /* set up session */
        Session.Add("id", user.id.ToString());
        Session.Add("firstName", user.firstName);
        Session.Add("userType", user.type);
        Session.Add("profilePicture", user.profilePicturePath);
        Session.Timeout = 60;

        /* set up cookies for current login */
        Response.Cookies["login"]["userId"] = user.id.ToString();
        Response.Cookies["login"]["firstName"] = user.firstName;
        Response.Cookies["login"]["userType"] = user.type;
        Response.Cookies["login"]["profilePicture"] = user.profilePicturePath;
        Response.Cookies["login"].Expires = DateTime.Now.AddDays(30);

        if (user.type == "teacher") {
          Response.Redirect("/teacher_quizzes/all_quizzes.aspx");
        } else
        {
          Response.Redirect("/student_quizzes/open_quizzes.aspx");
        }
      } catch (Exception exception)
      {
        if (exception is System.Threading.ThreadAbortException)
        {
          return; // safely ignore this exception
        }

        var message = "";

        if (exception is SessionException)
        {
          message = "Invalid email or password, please try again!<br>";
          message += "Don't have an account? Please ";
          message += "<a href='/signup.aspx'>Sign Up</a>!";
        } else
        {
          message = "Something went wrong!";
        }

        loginErrors.InnerHtml = message;
        loginErrors.Visible = true;
      }
    }


    protected void password_ServerValidate(object source, ServerValidateEventArgs e)
    {
      if (e.Value.Length < 8 || e.Value.Length > 16)
      {
        e.IsValid = false;
        passwordCV.Visible = true;
      }
      else
      {
        e.IsValid = true;
      }
    }
  }
}