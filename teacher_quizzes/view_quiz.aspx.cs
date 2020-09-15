using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35.teacher_quizzes
{
  public partial class view_quiz : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        return;
      }

      /* Parse teacherId & quizId
       * teacherId - Integer >= 1
       * quizId - Integer >= 1
     */
      int teacherId = -1;
      int quizId = -1;

      try
      {
        if (string.IsNullOrEmpty(Request.QueryString["teacherId"]) ||
            string.IsNullOrEmpty(Request.QueryString["quizId"]))
        {
          throw new Exception();
        }

        teacherId = Int32.Parse(Request.QueryString["teacherId"]);
        quizId = Int32.Parse(Request.QueryString["quizId"]);

        if (teacherId < 1 || quizId < 1)
        {
          throw new Exception();
        }
      }
      catch (Exception)
      {
        loadError.Visible = true;
        quizView.Visible = false;
        return;
      }

      var db = new DatabaseEntities();

      var quiz = db.Quiz.Where(q => q.id == quizId && q.teacherId == teacherId).Single();
      quizTitle.InnerText = quiz.title;

      var questions = db.Question.Where(i => i.quizId == quizId && i.teacherId == teacherId).ToArray();
      foreach (var question in questions)
      {
        if (question.type == "Multiple Choice")
        {
          question.QuestionOption = db.QuestionOption.Where(qo => qo.quizId == quizId &&
            qo.teacherId == teacherId && qo.questionId == question.id).ToArray();
        }

        var quizQuestion = new QuizQuestion
        {
          question = question
        };

        quizQuestionsView.Controls.Add(quizQuestion);
      }
    }
  }
}