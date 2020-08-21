using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace onlineQuiz_bsef17m35
{
  public class LocalQuiz
  {
    public int teacherId { get; set; }
    public int id { get; set; }
    public String title { get; set; }
    public String description { get; set; }
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
          id = question.id,
          question = question.title,
          description = question.description,
          marks = question.marks,
          type = question.type,
          options = localOptions.ToArray()
        });
      }

      return new LocalQuiz
      {
        id = quiz.id,
        teacherId = quiz.teacherId,
        title = quiz.title,
        description = quiz.description,
        totalMarks = quiz.totalMarks,
        passingMarks = quiz.passingMarks,
        visibility = quiz.visibility,
        questions = localQuestions.ToArray()
      };
    }

    public void CreateQuiz(DatabaseEntities connection)
    {
      var quiz = new Quiz();
      var transaction = connection.Database.BeginTransaction();

      try
      {
        quiz.teacherId = this.teacherId;
        quiz.title = this.title;
        quiz.description = this.description;
        quiz.totalMarks = this.totalMarks;
        quiz.passingMarks = this.passingMarks;
        quiz.visibility = this.visibility;
        connection.Quiz.Add(quiz);
        connection.SaveChanges();

        foreach (var question in questions)
        {
          var newQuestion = question.ToQuestion();
          newQuestion.quizId = quiz.id;
          newQuestion.teacherId = quiz.teacherId;
          connection.Question.Add(newQuestion);
          connection.SaveChanges();

          if (newQuestion.type == "Multiple Choice" ||
            newQuestion.type == "Checkboxes")
          {
            foreach (var option in question.options)
            {
              var newOption = option.ToQuestionOption();
              newOption.questionId = newQuestion.id;
              newOption.quizId = quiz.id;
              newOption.teacherId = quiz.teacherId;
              connection.QuestionOption.Add(newOption);
              connection.SaveChanges();
            }
          }
        }

        if (this.visibility == "Public")
        {
          foreach (string bl in this.blackList)
          {
            var blackEmail = new Blacklist();
            blackEmail.email = bl;
            blackEmail.quizId = quiz.id;
            blackEmail.teacherId = quiz.teacherId;
            connection.Blacklist.Add(blackEmail);
            connection.SaveChanges();
          }
        } else
        {
          foreach (string wl in this.whiteList)
          {
            var whiteEmail = new Whitelist();
            whiteEmail.email = wl;
            whiteEmail.quizId = quiz.id;
            whiteEmail.teacherId = quiz.teacherId;
            connection.Whitelist.Add(whiteEmail);
            connection.SaveChanges();
          }
        }

        transaction.Commit();
      } catch (Exception err)
      {
        transaction.Rollback();
        throw err;
      }
    }

    public void UpdateQuiz(DatabaseEntities connection)
    {
      if (this.id < 0)
      {
        throw new Exception("Quiz.id must be non-negtive to perform update.");
      }

      var quiz = connection.Quiz.Where(q => q.id == this.id &&
        q.teacherId == this.teacherId).Single();
      var transaction = connection.Database.BeginTransaction();

      try {
        /* remove existing data */
        this.Purge(connection);

        /* add new data */
        foreach (var question in questions)
        {
          var newQuestion = question.ToQuestion();
          newQuestion.quizId = quiz.id;
          newQuestion.teacherId = quiz.teacherId;
          connection.Question.Add(newQuestion);
          connection.SaveChanges();

          if (newQuestion.type == "Multiple Choice" ||
            newQuestion.type == "Checkboxes")
          {
            foreach (var option in question.options)
            {
              var newOption = option.ToQuestionOption();
              newOption.questionId = newQuestion.id;
              newOption.quizId = quiz.id;
              newOption.teacherId = quiz.teacherId;
              connection.QuestionOption.Add(newOption);
              connection.SaveChanges();
            }
          }
        }

        if (this.visibility == "Public")
        {
          foreach (string bl in this.blackList)
          {
            var blackEmail = new Blacklist();
            blackEmail.email = bl;
            blackEmail.quizId = quiz.id;
            blackEmail.teacherId = quiz.teacherId;
            connection.Blacklist.Add(blackEmail);
            connection.SaveChanges();
          }
        } else
        {
          foreach (string wl in this.whiteList)
          {
            var whiteEmail = new Whitelist();
            whiteEmail.email = wl;
            whiteEmail.quizId = quiz.id;
            whiteEmail.teacherId = quiz.teacherId;
            connection.Whitelist.Add(whiteEmail);
            connection.SaveChanges();
          }
        }

        quiz.title = this.title;
        quiz.description = this.description;
        quiz.totalMarks = this.totalMarks;
        quiz.passingMarks = this.passingMarks;
        quiz.visibility = this.visibility;

        connection.SaveChanges();
        transaction.Commit();
      } catch (Exception err) {
        transaction.Rollback();
        throw new Exception("Error: please see inner exception for details.", err);
      }
    }

  
    public void DeleteQuiz(DatabaseEntities connection)
    {
      if (this.id < 0)
      {
        throw new Exception("Quiz.id must be non-negtive to perform update.");
      }

      var quiz = connection.Quiz.Where(q => q.id == this.id &&
        q.teacherId == this.teacherId).Single();
      var transaction = connection.Database.BeginTransaction();

      try
      {
        this.Purge(connection);
        connection.Quiz.Remove(quiz);
        connection.SaveChanges();
        transaction.Commit();
      } catch(Exception err)
      {
        transaction.Rollback();
        throw err;
      }
    }

    protected void Purge(DatabaseEntities connection)
    {
      var existingQuestions = connection.Question.Where(q => q.teacherId == this.teacherId &&
          q.quizId == this.id);

      foreach (var question in existingQuestions)
      {
        var existingOptions = connection.QuestionOption.Where(
          q => q.teacherId == this.teacherId && q.quizId == id &&
          q.questionId == question.id);
        connection.QuestionOption.RemoveRange(existingOptions);
        connection.SaveChanges();

        connection.Question.Remove(question);
        connection.SaveChanges();
      }

      var blackList = connection.Blacklist.Where(bl => bl.quizId == this.id &&
        bl.teacherId == this.teacherId);
      connection.Blacklist.RemoveRange(blackList);
      connection.SaveChanges();

      var whiteList = connection.Whitelist.Where(wl => wl.quizId == this.id &&
        wl.teacherId == this.teacherId);
      connection.Whitelist.RemoveRange(whiteList);
      connection.SaveChanges();
    }
  }
}