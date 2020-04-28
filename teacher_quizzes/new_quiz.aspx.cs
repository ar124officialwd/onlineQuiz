using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text.RegularExpressions;
using Newtonsoft.Json;

namespace onlineQuiz_bsef17m35.teacher_quizes
{
  public partial class new_quiz : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      /* validate login */
      Master.ValidateSession();

      if (IsPostBack)
      {
        var button = (Button)Master.FindControl("newQuizButton");
        if (button != null) {
          button.CssClass = "btn active bg-dark text-light";
        }

        /* try saving quiz */
        try {
          if (Save_Quiz(quiz.Value)) {
            response.Visible = true;
            newQuizForm.Visible = false;
            applicationError.Visible = false;
          } else
          {
            throw new Exception();
          }
        } catch(Exception)
        {
          newQuizForm.Visible = false;
          response.Visible = false;
          applicationError.Visible = true;
        }
      } else {
        response.Visible = false; // hide response text
        applicationError.Visible = false;
        
        DatabaseEntities db = new DatabaseEntities();
        var quizes = db.getQuestionTypes().ToArray();
        var visibilities = db.getVisibility().ToArray();

        questionType.DataSource = quizes;
        questionType.DataBind();
        questionType.Value = "Brief";

        visibility.DataSource = visibilities;
        visibility.DataBind();
        visibility.Value = "Public";

        /* register client scripts */
        Type scriptType = this.GetType();
        String scriptName = "script";
        String scriptUrl = "./new_quiz.js";
        String scriptText = File.ReadAllText(Server.MapPath(scriptUrl));
        ClientScriptManager scriptManager = Page.ClientScript;
        if (!scriptManager.IsClientScriptBlockRegistered(scriptType, scriptName))
        {
          scriptManager.RegisterClientScriptBlock(scriptType, scriptName, scriptText, true);
        }
      }
    }
    protected bool Save_Quiz(String quizJSON)
    {
      DatabaseEntities db = new DatabaseEntities();
      var transaction = db.Database.BeginTransaction();

      try {
        var userType = Request.Cookies["login"]["userType"];
        var userId = -1;

        try {
          userId = Int32.Parse(Request.Cookies["login"]["userId"]);
        } catch (Exception) {
          throw new Exception();
        } 

        /* make sure safety replacements are reverted */
        quizJSON.Replace("&lt;", "<");
        quizJSON.Replace("&gt;", ">");

        LocalQuiz quizRawObject = JsonConvert.DeserializeObject<LocalQuiz>(quizJSON);

        /* set up quiz */
        Quiz newQuiz = new Quiz
        {
          title = quizRawObject.title,
          description = quizRawObject.descritption,
          totalMarks = quizRawObject.totalMarks,
          passingMarks = quizRawObject.passingMarks,
          teacherId = userId,
          visibility = quizRawObject.visibility
        };
        db.Quiz.Add(newQuiz);
        db.SaveChanges();

        foreach (var question in quizRawObject.questions) {
          Question newQuestion = new Question
          {
            quizId = newQuiz.id,
            title = question.question,
            description = question.description, 
            teacherId = userId,
            type = question.type,
            marks = question.marks
          };
          db.Question.Add(newQuestion);
          db.SaveChanges();

          if (question.type == "Multiple Choice" || question.type == "Checkboxes") {
            foreach (var option in question.options) {
              QuestionOption newOption = new QuestionOption
              {
                value = option.value,
                valid = option.valid,
                teacherId = userId,
                quizId = newQuiz.id,
                questionId = newQuestion.id
              };
              db.QuestionOption.Add(newOption);
              db.SaveChanges();
            }
          }

        }

        if (newQuiz.visibility == "Public") {
          foreach (var blackEmail in quizRawObject.blackList) {
            Blacklist newBlackEmail = new Blacklist
            {
              email = blackEmail,
              teacherId = userId,
              quizId = newQuiz.id
            };
            db.Blacklist.Add(newBlackEmail);
            db.SaveChanges();
          }
        } else {
          foreach (var whiteEmail in quizRawObject.whiteList) {
            Whitelist newWhiteEmail = new Whitelist
            {
              email = whiteEmail,
              teacherId = userId,
              quizId = newQuiz.id
            };
            db.Whitelist.Add(newWhiteEmail);
            db.SaveChanges();
          }
        }

        transaction.Commit();
        return true;
      } catch (Exception error) {
        transaction.Rollback();
        throw error;
      }
    }
  }
}