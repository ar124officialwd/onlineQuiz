using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace onlineQuiz_bsef17m35
{
  public partial class dashboard : System.Web.UI.MasterPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      firstName.InnerText = (String)Session["firstName"];
      profilePicture.Src = (String)Session["profilePicture"];
    }

    protected void DashboardLogout_ServerClick(object sender, EventArgs e)
    {
      Logout();
    }

    public void ValidateSession()
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

          if (string.IsNullOrEmpty(userId) ||
              string.IsNullOrEmpty(userFirstName) ||
              string.IsNullOrEmpty(userType) ||
              string.IsNullOrEmpty(profilePicture))
          {
            throw new Exception();
          }

          Int32.Parse(userId);
          Session.Abandon();
          Session["userId"] = userId.ToString();
          Session["firstName"] = userFirstName;
          Session["userType"] = userType;
          Session["profilePicture"] = profilePicture;
          Session.Timeout = 720;
        }
      }
      catch (Exception exception)
      {
        Session.Abandon();
        if (Request.Cookies["login"] != null) {
          Request.Cookies["login"].Expires = DateTime.Now.AddDays(-1);
        }

        Response.Redirect("/login.aspx");
      }
    }

    public void NavigationLinkClicked(object sender, EventArgs e)
    {
      var Sender = (Button)sender;

        switch (Sender.CommandName)
        {
          case "openQuizBoard":
            var userType = (String)Session["userType"];
            if (userType == "teacher")
            {
              Response.Redirect("/teacher_quizzes/all_quizzes.aspx");
            } else
            {
              Response.Redirect("/student_quizzes/open_quizzes.aspx");
            }

            break;

          case "openProfile":
            Response.Redirect("/profile/profile.aspx");
            break;

          default:
            break;
        }
    }

    public void Logout()
    {
      Session.Abandon();
      Response.Cookies["login"].Expires = DateTime.Now.AddDays(-1);
      Response.Redirect("/index.aspx");
    }
  }
}