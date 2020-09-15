using System;
using System.Linq;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.IO;

namespace onlineQuiz_bsef17m35
{
  public partial class signUp : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      if (string.IsNullOrEmpty(Request.QueryString["userId"]))
      {
        /* if session/cookies exist - Redirect */
        try
        {
          if (String.IsNullOrEmpty((String)Session["userId"]) ||
            String.IsNullOrEmpty((String)Session["firstName"]) ||
            String.IsNullOrEmpty((String)Session["userType"]))
          {
            String userId = Request.Cookies["login"]["userId"];
            String userFirstName = Request.Cookies["login"]["firstName"];
            String userType = Request.Cookies["login"]["userType"];

            try
            {
              Int32.Parse(userId);
            }
            catch
            {
              throw new Exception();
            }

            Session.Abandon();
            Session["userId"] = userId;
            Session["firstName"] = userFirstName;
            Session["userType"] = userType;
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
          if (!(error is Exception) || !(error is System.NullReferenceException))
          {
            throw error;
          }
        }
      }

      /* load countries from database */
      DatabaseEntities db = new DatabaseEntities();
      var countries = db.getCountries();
      country.DataSource = countries;
      country.DataTextField = "name";
      country.DataValueField = "code";
      country.DataBind();

      /* change user type based on Query String */
      if (string.IsNullOrEmpty(Request.QueryString["userId"]) &&
        Request.QueryString["userType"] != null)
      {
        if (Request.QueryString["userType"] != "teacher")
        {
          student.Checked = true;
          specialityInputGroup.Visible = false;
          specialityRFV.Enabled = false;
          profilePictureFileUpload.Attributes["src"] = "/resources/images/profile_pictures/default/student_male.png";
        }
      }

      /* load update mode,  if request is to edit profile */
      if (Request.QueryString["userId"] != null)
      {
        try
        {
          var userId = Int32.Parse(Request.QueryString["userId"]);
          var profile = db.EndUser.First(i => i.id == userId);

          firstName.Text = profile.firstName;
          secondName.Text = profile.secondName;
          email.Text = profile.email;
          country.SelectedValue = profile.countryCode;
          city.Text = profile.city;
          profilePicture.Src = profile.profilePicturePath;

          /* check if the image is default or custom */
          var pattern = @"\/resources\/images\/profile_pictures\/custom\/.*\.png";
          if (Regex.IsMatch(profilePicture.Src, pattern))
          {
            isProfilePictureSet.Value = "true";
          }

          switch (profile.gender)
          {
            case "Male":
              male.Checked = true;
              break;
            case "Female":
              female.Checked = true;
              break;
            case "Unspecified":
              unspecified.Checked = true;
              break;
            default:
              break;
          }

          if (profile.type == "teacher")
          {
            var _teacher = db.Teacher.First(t => t.userId == profile.id);
            speciality.Text = _teacher.speciality;

            student.Enabled = false;
            student.Checked = false;
            teacher.Checked = true;
          }
          else
          {
            teacher.Enabled = false;
            teacher.Checked = false;
            student.Checked = true;

            specialityInputGroup.Visible = false;
            specialityRFV.Enabled = false;
          }

          gotoLogin.Visible = false;
          oldPasswordFG.Visible = true;
          oldPasswordRFV.Enabled = true;

          signupLabel.InnerText = "Update Profile";
          signupSubmit.Text = "Update Profile";
          signupSubmit.CommandName = "update";
          signupSubmit.CommandArgument = profile.email;
        }
        catch (Exception error)
        {
          signupErrors.Visible = true;
          signupErrors.InnerText = "Sorry, error occured while loading profile!";
          SignupForm.Visible = false;
        }
      }
    }

    /* handle the submission of form */
    protected void signUpSubmit_ServerClick(object sender, EventArgs e)
    {
      var Sender = (Button)sender;
      signupMessages.Visible = false;
      signupErrors.Visible = false;
      String loginLink = "<span><a href='/login.aspx'>Login</a></span>";
      DatabaseEntities db = new DatabaseEntities();

      var user = db.EndUser.FirstOrDefault(eu => eu.email == email.Text);
      if (user == null)
        user = new EndUser();

      /* user already exist */
      if ((user.email == email.Text && Sender.CommandName != "update") ||
        (user.email == email.Text &&
          Sender.CommandName == "update" && email.Text != Sender.CommandArgument))
      {
        String _message = "This email is already registered with us. Please choose another!";
        signupErrors.InnerHtml = _message;
        signupErrors.Visible = true;
        return;
      }

      /* user password is invalid - in case of update */
      if (Sender.CommandName == "update")
      {
        var originalUser = db.EndUser.First(eu => eu.email == Sender.CommandArgument);
        if (oldPassword.Value != originalUser.password)
        {
          signupErrors.InnerText = "Invalid old password!";
          signupErrors.Visible = true;
          return;
        }
      }

      /* check image type - if file uploaded */
      if (isProfilePictureSet.Value == "true" && profilePictureFileUpload.HasFile)
      {
        if (profilePictureFileUpload.PostedFile.ContentType != "image/png")
        {
          signupErrors.InnerText = "Only png files are supported as profile picture!";
          signupErrors.Visible = true;
          return;
        }
      }

      try
      {
        user.email = email.Text;
        user.password = password.Value;
        user.firstName = firstName.Text;
        user.secondName = secondName.Text;
        user.countryCode = country.SelectedValue;
        user.city = city.Text;
        user.active = true;
        user.profilePicturePath = profilePicture.Src;

        user.gender = "Female";
        if (male.Checked) user.gender = "Male";
        if (unspecified.Checked) user.gender = "Unspecified";

        if (teacher.Checked)
          user.type = "teacher";
        else
          user.type = "student";

        if (Sender.CommandName != "update")
          db.EndUser.Add(user);
        db.SaveChanges();


        /* set profile picture - if user added */
        if (isProfilePictureSet.Value == "true")
        {
          if (profilePictureFileUpload.HasFile) {
            var fileInfo = new FileInfo(profilePictureFileUpload.PostedFile.FileName);
            var path = "/resources/images/profile_pictures/custom/" + user.id + fileInfo.Extension;
            profilePictureFileUpload.PostedFile.SaveAs(Server.MapPath("~" + path));
            user.profilePicturePath = path;
          }

          db.SaveChanges();
        }

        if (teacher.Checked)
        {
          var _teacher = db.Teacher.FirstOrDefault(t => t.userId == user.id);

          if (_teacher == null)
            _teacher = new Teacher();

          _teacher.speciality = speciality.Text;
          _teacher.userId = user.id;

          if (Sender.CommandName != "update")
            db.Teacher.Add(_teacher);

          db.SaveChanges();
        }
        else
        {
          var _student = db.Student.FirstOrDefault(s => s.userId == user.id);

          if (_student == null)
            _student = new Student();

          _student.userId = user.id;

          if (Sender.CommandName != "update")
            db.Student.Add(_student);

          db.SaveChanges();
        }
      }
      catch (Exception err)
      {
        var _message = "Something went wrong!";
        signupErrors.InnerText = _message;
        signupErrors.Visible = true;
        return;
      }

      if (Sender.CommandName == "update") {
        Session["userId"] = user.id.ToString();
        Session["userType"] = user.type;
        Session["firstName"] = user.firstName;
        Session["profilePicture"] = user.profilePicturePath;

        Response.Cookies["login"]["userId"] = user.profilePicturePath;
        Response.Cookies["login"]["firstName"] = user.profilePicturePath;
        Response.Cookies["login"]["userType"] = user.profilePicturePath;
        Response.Cookies["login"]["profilePicture"] = user.profilePicturePath;

        Response.Redirect("/profile/profile.aspx?updated=true");
      }

      var message = "Your account has been successfully created!";
      message += "Please " + loginLink + " to continue.";
      signupMessages.Visible = true;
      signupMessages.InnerHtml = message;
    }

    /* handle the change of user role */
    protected void onRoleChanged(object sender, EventArgs e)
    {
      if (student.Checked)
      {
        specialityInputGroup.Visible = false;
        specialityRFV.Enabled = false;

        if (isProfilePictureSet.Value != "true")
        {
          if (female.Checked)
          {
            profilePicture.Src = "/resources/images/profile_pictures/default/student_female.png";
          }
          else
          {
            profilePicture.Src = "/resources/images/profile_pictures/default/student_male.png";
          }
        }
      }
      else
      {
        specialityInputGroup.Visible = true;
        specialityRFV.Enabled = true;

        if (isProfilePictureSet.Value != "true")
        {
          if (female.Checked)
          {
            profilePicture.Src = "/resources/images/profile_pictures/default/teacher_female.png";
          }
          else
          {
            profilePicture.Src = "/resources/images/profile_pictures/default/teacher_male.png";
          }
        }
      }
    }

    /* handle the change of user gender */
    protected void onGenderChange(object sender, EventArgs e)
    {
      if (isProfilePictureSet.Value == "true")
        return;

      var link = "/resources/images/profile_pictures/default/";
      if (student.Checked) {
        link += "student_";
        if (female.Checked)
          link += "female.png";
        else
          link += "male.png";
      }
      else
      {
        link += "teacher_";
        if (female.Checked)
          link += "female.png";
        else
          link += "male.png";
      }

      profilePicture.Src = link;
    }

    /* custom validator of password */
    protected void password_ServerValidate(object source, ServerValidateEventArgs e)
    {
      if (e.Value.Length < 8 || e.Value.Length > 16)
      {
        e.IsValid = false;
      }
      else
      {
        e.IsValid = true;
      }
    }

    protected void profilePictureDelete_ServerClick(object sender, EventArgs e)
    {
      isProfilePictureSet.Value = "false";
      var link = "/resources/images/profile_pictures/default/";

      if (teacher.Checked)
      {
        link += "teacher_";
        if (female.Checked)
          link += "female.png";
        else
          link += "male.png";
      }
      else
      {
        link += "student_";
        if (female.Checked)
          link += "female.png";
        else
          link += "male.png";
      }

      profilePicture.Src = link;
    }
  }
}