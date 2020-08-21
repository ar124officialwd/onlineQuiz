using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace onlineQuiz_bsef17m35
{
  [DefaultProperty("Text")]
  [ToolboxData("<{0}:QuizQuestion runat=server></{0}:QuizQuestion>")]
  public class QuizQuestion : WebControl
  {
    [Bindable(true)]
    [Category("Appearance")]
    [DefaultValue("")]
    [Localizable(true)]

    public Question question
    {
      get
      {
        var q = (Question)ViewState["question"];
        return ((q == null) ? new Question(): q);
      }

      set
      {
        ViewState["question"] = (object)value;
      }
    }

    protected override void RenderContents(HtmlTextWriter output)
    {
      Controls.Add(BuildControls());
      Controls[0].RenderControl(output);
    }

    protected Panel BuildControls()
    {
      var container = new Panel();
      container.CssClass = CssClass + " asp-panel d-block m-1";

      /* add title */
      var titleContainer = new Panel();
      titleContainer.CssClass = "p-1";
      var title = new Label();
      title.CssClass = "font-weight-bolder";
      title.Text = "Question: " + question.title;
      titleContainer.Controls.Add(title);
      container.Controls.Add(titleContainer);

      /* add description */
      var descriptionContainer = new Panel();
      descriptionContainer.CssClass = "p-1";

      var description = new Label();
      description.CssClass = "font-weight-light";
      description.Text = question.description;

      if (string.IsNullOrEmpty(description.Text))
      {
        description.Text = "No Description";
      }

      descriptionContainer.Controls.Add(description);
      container.Controls.Add(descriptionContainer);

      /* add other attributes *************************************************/
      var attributeContainer = new Panel();
      attributeContainer.CssClass = "p-2 d-flex flex-row";

      // add Quetion type
      var typeContainer = new Panel();
      typeContainer.CssClass = "mr-1 asp-panel d-flex flex-column p-0";

      var typeTitle = new Label();
      typeTitle.CssClass = "text-dark alert alert-dark p-2";
      typeTitle.Text = "Type";
      typeContainer.Controls.Add(typeTitle);

      var typeValue = new Label();
      typeValue.Text = question.type;
      typeValue.CssClass = "p-2";
      typeContainer.Controls.Add(typeValue);

      attributeContainer.Controls.Add(typeContainer);

      // add Grades
      var gradesContainer = new Panel();
      gradesContainer.CssClass = "mr-1 asp-panel d-flex flex-column p-0";

      var gradesTitle = new Label();
      gradesTitle.CssClass = "text-dark alert alert-dark p-2";
      gradesTitle.Text = "Grades";
      gradesContainer.Controls.Add(gradesTitle);

      var gradesValue = new Label();
      gradesValue.Text = question.marks.ToString();
      gradesValue.CssClass = "p-2";
      gradesContainer.Controls.Add(gradesValue);

      attributeContainer.Controls.Add(gradesContainer);

      container.Controls.Add(attributeContainer);
      /* end adding other attributes ******************************************/

      // add Question Options
      if (question.QuestionOption.Count() >= 1) {
        var questionOptionsContainer = new Panel();
        questionOptionsContainer.CssClass = "p-2";

        var heading = new Label();
        heading.Text = "Options";
        heading.CssClass = "font-weight-bold d-block";
        questionOptionsContainer.Controls.Add(heading);

        var optionsContainer = new Panel();
        optionsContainer.CssClass = "p-1 d-flex flex-row";
        
        foreach (var option in question.QuestionOption)
        {
          var optionLabel = new Label();
          optionLabel.Text = option.value;

          optionLabel.CssClass = "alert p-1 mr-1 ";
          if (option.valid)
          {
            optionLabel.CssClass += "alert-success";
          } else
          {
            optionLabel.CssClass += "alert-danger";
          }

          optionsContainer.Controls.Add(optionLabel);
        }

        questionOptionsContainer.Controls.Add(optionsContainer);
        container.Controls.Add(questionOptionsContainer);
      }

      return container;
    }
  }
}
