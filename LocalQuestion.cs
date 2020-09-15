using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace onlineQuiz_bsef17m35
{
  public class LocalQuestion
  {
    public int id { get; set; }
    public String question { get; set; }
    public String type { get; set; }
    public int marks { get; set; }
    public int obtainedMarks { get; set; }
    public String description { get; set; }
    public LocalOption[] options { get; set; }
    public string answer { get; set; }
    public string[] answers { get; set; }

    public Question ToQuestion()
    {
      return new Question
      {
        title = question,
        description = description,
        type = type,
        marks = marks,
      };
    }
  }
}