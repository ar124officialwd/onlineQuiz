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
          if (SaveQuiz(quiz.Value)) {
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

        if (!string.IsNullOrEmpty(Request.QueryString["quizId"])) {
          try {
            var teacherId = Int32.Parse(Session["userId"].ToString());
            var quizId = Int32.Parse(Request.QueryString["quizId"]);

            var existingQuiz = db.Quiz.Where(q => q.teacherId == teacherId &&
              q.id == quizId).Single();

            if (existingQuiz.Submission.Count > 0)
            {
              quizLoadError.InnerText = "Sorry, but this quiz cannot be updated/edited!";
              quizLoadError.Visible = true;
              newQuizForm.Visible = false;

              return;
            }

            var localQuiz = LocalQuiz.ToLocalQuiz(existingQuiz);
            if (localQuiz.visibility == "Public")
            {
              var blackList = db.Blacklist.Where(b => b.quizId == quizId &&
                b.teacherId == teacherId).ToArray();
              foreach (var bl in blackList)
              {
                localQuiz.blackList.Append(bl.email);
              }
            } else
            {
              var whiteList = db.Whitelist.Where(b => b.quizId == quizId &&
                b.teacherId == teacherId).ToArray();
              foreach (var wl in whiteList)
              {
                localQuiz.whiteList.Append(wl.email);
              }
            }

            quiz.Value = JsonConvert.SerializeObject(localQuiz);
            updateMode.Value = "true";
            ViewState["quizId"] = Request.QueryString["quizId"];
          } catch (Exception err)
          {
            quizLoadError.InnerText = "Something went wrong, Unable to load quiz!";
            quizLoadError.Visible = true;
            newQuizForm.Visible = false;
          }
        }
      }
    }
    protected bool SaveQuiz(String quizJson)
    {
      DatabaseEntities db = new DatabaseEntities();

      try {
        var userId = Int32.Parse(Session["userId"].ToString());

        /* make sure safety replacements are reverted */
        quizJson.Replace("&lt;", "<");
        quizJson.Replace("&gt;", ">");

        LocalQuiz localQuiz = JsonConvert.DeserializeObject<LocalQuiz>(quizJson);
        localQuiz.teacherId = userId;

        if (updateMode.Value == "true")
        {
          localQuiz.id = Int32.Parse(ViewState["quizId"].ToString());
          localQuiz.UpdateQuiz(db);
        } else {
          localQuiz.CreateQuiz(db);
        }

        return true;
      } catch (Exception error) {
        throw error;
      }
    }
  }
}