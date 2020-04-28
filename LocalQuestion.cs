using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace onlineQuiz_bsef17m35
{
  public class LocalQuestion
  {
    public String question { get; set; }
    public String type { get; set; }
    public int marks { get; set; }
    public String description { get; set; }
    public LocalOption[] options { get; set; }
  }
}