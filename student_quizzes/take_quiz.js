let quiz = null;

$(document).ready(() => {
  prepareQuiz();
});

function prepareQuiz() {
  const quizJSON = $("[id$=quizJSON]").val();
  quiz = JSON.parse(quizJSON);

  const windowSize = 10;
  const maxItems = quiz.questions.length;
  $("#questionsWindow").append(getItemsWindow(windowSize, maxItems, questionIndexChanged));
  $("#submitButton").click(submitQuiz);
}

function questionIndexChanged(button, questionIndex, previous, next) {
  var question = quiz.questions[questionIndex];

  if (question != null && question != undefined) {
    prepareQuestion(question);
    $("#answerSubmit").off();
    $("#answerSubmit").click(() => {
      saveAnswer(question);

      if (questionIndex < quiz.questions.length - 1) {
        next.click();
      } else {
        $("#sumbitButton").focus();
      }
    });
  }
}

function prepareQuestion(question) {
  $("#questionTitle").text(question.question);

  $("#questionDescription").text(question.description);
  if ($("#questionDescription").text() == "") {
    $("#questionDescription").text("No description!");
  }

  $("#answerBox").html("");
  switch (question.type) {
    case "Brief":
    case "Descriptive":
      $("#questionType").text("Brief");
      const answer = $(document.createElement('textarea'))
        .addClass("form-control")
        .prop("rows", 3)
        .prop("id", "answer")
        .prop("maxlength", 500)
        .prop("placeholder", "Enter your answer here")
        .appendTo("#answerBox");

      if (question.type == "Descriptive") {
        $("#questionType").text("Descriptive");
        answer.prop("rows", 7);
        answer.prop("maxlength", 2048);
      }

      if (!!question.answer) {
        answer.val(question.answer);
      }
      break;

    case "Multiple Choice":
    case "Checkboxes":
      $("#questionType").text("Multiple Choice");

      for (const o of question.options) {
        $(document.createElement("input"))
          .prop("type", "radio")
          .prop("name", "choice")
          .val(o.value)
          .addClass("ml-2")
          .appendTo("#answerBox");

        $(document.createElement("span"))
          .text(o.value)
          .addClass("mx-2")
          .appendTo("#answerBox");

        $(document.createElement("br"))
          .appendTo("#answerBox");
      }

      if (question.type == "Checkboxes") {
        $("#questionType").text("Checkboxes");
        $("[name=choice]").prop("type", "checkbox")
          .prop("name", "choices");
      }

      break;
  }
}


function saveAnswer(question) {
  if (question) {
    if ((question.answer != null && question.answer != undefined && question.answer != "" &&
      question.answers != null && question.answer != undefined)) {
      const confirm = window.confirm("You have already answered this question. " +
        "Saving this will cause overwrite previous answer. " +
        "Continue?");

      if (!confirm) {
        return;
      }
    }

    switch (question.type) {
      case "Brief":
      case "Descriptive":
        question.answer = $("#answer").val();
        break;

      case "Multiple Choice":
        var selected = $("#answerBox").find(":checked")[0];

        if (selected) {
          question.answer = $(selected).val();
        }

        break;

      case "Checkboxes":
        var selected = $("#answerBox").find(":checked");
        question.answers = [];
        for (const s of selected) {
          question.answers.push($(s).val());
        }
        break;

      default:
        break;
    }
  }
}

function submitQuiz() {
  for (var q of quiz.questions) {
    if (q.type != "Checkboxes" && (
      q.answer == null || q.answer == undefined || q.answer == "")) {
      var confirm = window.confirm("One or more questions are still " +
        "un-answered. Submitting will result in empty answer to them. " +
        "Continue?");

      if (!confirm) {
        return;
      }

      break;
    }
  }

  $("[id$=quizJSON]").val(JSON.stringify(quiz));
  $("[id$=realSubmitButton]").click();
}