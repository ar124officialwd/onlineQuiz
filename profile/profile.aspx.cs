using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35.profile
{
  public partial class profile : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      /* validate session and load user email */
      Master.ValidateSession();

      var userId = Int32.Parse((String)Session["userId"]);
      var userType = (String)Session["userType"];

      editProfileLink.Attributes["href"] += userId;

      var db = new DatabaseEntities();
      var profile = db.getProfile(userId).FirstOrDefault();

      if (profile == null)
      {
        profileLoadError.Visible = true;
        profileView.Visible = false;
        return;
      } else
      {
        profileLoadError.Visible = false;
        profileView.Visible = true;
      }

      fullName.InnerText = profile.fullName;
      gender.InnerText = profile.gender;
      email.InnerText = profile.email;
      country.InnerText = profile.country;
      city.InnerText = profile.city;
      profilePicture.Src = profile.profilePicturePath;

      if (userType != "teacher")
      {
        specialityDetails.Visible = false;
      } else
      {
        specialityDetails.Visible = true;
        speciality.InnerText = profile.speciality;
      }

      if (Request.QueryString["updated"] == "true")
      {
        profileUpdated.Visible = true;
      }
    }

    protected void DeleteProfileLink_ServerClick(object sender, EventArgs e)
    {
      profileLoadError.Visible = false;
      profileUpdated.Visible = false;
      profileView.Visible = false;
      DeleteAccountModel.Visible = true;
    }

    protected void ReallyDeleteAccount_Click(object sender, EventArgs e)
    {
      var userId = Int32.Parse((String)Session["userId"]);
      var userType = (String)Session["userType"];
      var db = new DatabaseEntities();
      var transaction = db.Database.BeginTransaction();

      try
      {
        var user = db.EndUser.First(eu => eu.id == userId);

        if (userType == "teacher")
        {
          var teacher = db.Teacher.First(t => t.userId == userId);
          var quizzes = db.Quiz.Where(q => q.teacherId == userId);

          foreach (var quiz in quizzes)
          {
            var questions = db.Question.Where(q => q.quizId == quiz.id);
            var submissions = db.Submission.Where(q => q.quizId == quiz.id);

            foreach (var question in questions)
            {
              var options = db.QuestionOption.Where(qo => qo.questionId == question.id);
              db.QuestionOption.RemoveRange(options);
            }

            db.Submission.RemoveRange(submissions);
            db.Question.RemoveRange(questions);
          }

          db.Quiz.RemoveRange(quizzes);
          db.Teacher.Remove(teacher);
        } else
        {
          var student = db.Student.First(t => t.userId == userId);
          var submissions = db.Submission.Where(s => s.studentId == userId);

          db.Submission.RemoveRange(submissions);
          db.Student.Remove(student);
        }

        db.EndUser.Remove(user);
        db.SaveChanges();
        transaction.Commit();

        Response.Cookies["login"].Expires = DateTime.Now.AddDays(-1);
        Response.Redirect("/index.aspx");
      } catch(Exception exception)
      {
        if (exception is System.Threading.ThreadAbortException)
        {
          return; // safely ignore this exception
        }

        accountDeleteError.Visible = true;
        profileView.Visible = false;
      }
    }
  }
}