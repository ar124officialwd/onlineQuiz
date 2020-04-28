using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace onlineQuiz_bsef17m35
{
  public class LocalQuiz
  {
    public String title { get; set; }
    public String descritption { get; set; }
    public int totalMarks { get; set; }
    public int passingMarks { get; set; }
    public String visibility { get; set; }
    public String[] blackList { get; set; }
    public String[] whiteList { get; set; }
    public LocalQuestion[] questions { get; set; }

    public static LocalQuiz ToLocalQuiz(Quiz quiz)
    {
      var localQuestions = new List<LocalQuestion>();

      foreach (var question in quiz.Question)
      {
        var localOptions = new List<LocalOption>();
        if (question.type == "Multiple Choice" || question.type == "Checkboxes")
        {
          foreach (var option in question.QuestionOption)
          {
            localOptions.Add(new LocalOption
            {
              value = option.value,
              valid = option.valid
            });
          }
        }

        localQuestions.Add(new LocalQuestion
        {
          question = question.title,
          description = question.description,
          marks = question.marks,
          type = question.type,
          options = localOptions.ToArray()
        });
      }

      return new LocalQuiz
      {
        title = quiz.title,
        descritption = quiz.description,
        totalMarks = quiz.totalMarks,
        passingMarks = quiz.passingMarks,
        questions = localQuestions.ToArray()
      };
    }
  }
}