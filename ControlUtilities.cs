using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace onlineQuiz_bsef17m35
{
  public class ControlUtilities
  {
    public static int DirectChildCount(ControlCollection controls)
    {
      int count = 0;
      foreach (Control control in controls)
        count++;
      return count;
    }
  }
}