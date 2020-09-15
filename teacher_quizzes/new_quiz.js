/*****************************************************************************/
// CLASSES 
class Question {
  constructor() {
    this.question = '';
    this.description = "";
    this.type = '';
    this.options = [];
    this.marks = 0;
    this.validOptionAdded = false;
  }
}

class Option {
  constructor(value, valid) {
    this.value = value;
    this.valid = valid;
  }
}
/*****************************************************************************/


/*****************************************************************************/
/// Global Variables
const sessionQuestions = [new Question()];
let currentQuestion = 0;
let currentOption = 0;
let globalWhiteList = [];
let globalBlackList = [];
/*****************************************************************************/


/*****************************************************************************/
/// EVENT HANDLERS

/* handles change in question type 
  @eventHandler
*/
function questionTypeChange() {
  const questionType = $("[id$=questionType]").find(":selected");
  const questionOptions = $("[id$=questionOptions]");

  if (questionType.val() == "Multiple Choice" || questionType.val() == "Checkboxes") {
    questionOptions.fadeIn();
  } else {
    questionOptions.fadeOut();
  }
}


/* handles change in question visiblity
  @eventHandler
*/
function visibilityChange() {
  const visibility = $("[id$=visibility]").find(":selected");
  const whiteList = $("[id$=whiteList]");
  const blackList = $("[id$=blackList]");

  if (visibility.val() == "Public") {
    if (globalBlackList.length > 0) {
      const confirm = window.confirm("You have existing emails in Black List!"
        + " Continue? This will discard Black List!");
      if (!confirm) {
        return;
      }
    }

    blackList.fadeIn();
    whiteList.fadeOut();
    globalWhiteList = [];
    globalBlackList = [];
  } else {
    if (globalWhiteList.length > 0) {
      const confirm = window.confirm("You have existing emails in White List!"
        + " Continue? This will discard White List!");
      if (!confirm) {
        return;
      }
    }

    whiteList.fadeIn();
    blackList.fadeOut();
    globalBlackList = [];
    globalWhiteList = [];
  }
}


/*****************************************************************************/


/*****************************************************************************/
/// MANAGEMENT FUNCTIONS
/* delete an email */
function deleteEmailAddress() {
  let emailIndex = 0;
  const visibility = $("[id$=visibility]").find(":selected");
  let emails = null;

  if (visibility.val() == "Public") {
    emails = globalBlackList;
  } else {
    emails = globalWhiteList;
  }

  try {
    emailIndex = Number($(this).attr("data-edit-index"));
    if (emailIndex < 0) {
      throw new Error();
    }
  } catch {
    window.alert("Something went wrong!");
    return;
  }

  emails.splice(emailIndex, 1);
  $(this).parent().parent().remove();
}


/* delete a question */
function deleteQuestion() {
  var questionIndex = Number($(this).attr('data-edit-index'));

  if (questionIndex >= 0) {
    sessionQuestions[currentQuestion] = undefined; // invalidate current question
    sessionQuestions.splice(questionIndex, 1);
    currentQuestion = sessionQuestions.length;
    sessionQuestions[currentQuestion] = new Question();

    showQuestions();
  }
}


/* delete a question option */
function deleteQuestionOption() {
  const optionLabel = $("[id$=questionOptionLabel]");
  const optionValidCheckBox = $("[id$=questionOptionValidity]");

  const optionIndex = Number($(this).attr('data-edit-index'));
  if (optionIndex >= 0) {
    sessionQuestions[currentQuestion].options.splice(optionIndex, 1);
    showOptions(sessionQuestions[currentQuestion].options);
    optionLabel.text("Option " + (sessionQuestions[currentQuestion].options.length + 1))
    optionValidCheckBox.prop("disabled", false);
    currentOption = sessionQuestions[currentQuestion].options.length;

    if (sessionQuestions[currentQuestion].type == "Multiple Choice") {
      var valid = sessionQuestions[currentQuestion].options.find(o => o.valid);
      if (!valid) {
        optionValidCheckBox.prop("disabled", true);
      }
    }
  }
}


/* add another email address to list(black or white) */
function addEmail() {
  const visibility = $("[id$=visibility]");
  const existingWhiteEmails = $("[id$=existingWhiteEmails]");
  const existingBlackEmails = $("[id$=existingBlackEmails]");
  const whiteEmail = $("[id$=whiteEmail]");
  const blackEmail = $("[id$=blackEmail]");
  const invalidWhiteEmail = $("[id$=invalidWhiteEmail]");
  const invalidBlackEmail = $("[id$=invalidBlackEmail]");

  let emails = null;
  let existingEmails = null;
  let email = null;
  let invalidEmail = null;

  if (visibility.val() == "Public") {
    emails = globalBlackList;
    existingEmails = existingBlackEmails;
    email = blackEmail;
    invalidEmail = invalidBlackEmail;
  } else {
    emails = globalWhiteList;
    existingEmails = existingWhiteEmails;
    email = whiteEmail;
    invalidEmail = invalidWhiteEmail;
  }

  if (!validateEmail(email.val())) {
    invalidEmail.removeClass("d-none");
    return;
  } else {
    invalidEmail.addClass("d-none");
  }

  const index = emails.findIndex(e => e == email.val());
  if (index >= 0) {
    email.val("");
    return;
  }

  emails.push(email.val());
  email.val("");

  existingEmails.html("");
  for (let i = 0; i < emails.length; i++) {
    const div = $(document.createElement('div'))
      .addClass('alert alert-secondary d-flex flex-row ' +
        'align-items-center');

    const text = $(document.createElement('div'))
      .addClass('px-2')
      .text(emails[i])
      .addClass('overflow-hidden');

    const edit = $(document.createElement('div'))
      .append($(document.createElement('button'))
        .addClass('btn btn-light')
        .attr('data-edit-index', i) /* important: sets index to denote which option to edit */
        .attr('type', 'button')
        .on('click', editEmail)
        .append($(document.createElement('i'))
          .addClass('far fa-edit')
        )
      );

    const _delete = $(document.createElement('div'))
      .append($(document.createElement('button'))
        .addClass('btn btn-light')
        .attr('data-edit-index', i) /* important: sets index to denote which option to edit */
        .attr('type', 'button')
        .on('click', deleteEmailAddress)
        .append($(document.createElement('i'))
          .addClass('far fa-trash-alt')
        )
      );

    div.append(edit, _delete, text);
    existingEmails.append(div);
  }
}

/* add another question option */
function addQuestionOption() {
  const questionType = $("[id$=questionType]");
  const optionValue = $("[id$=questionOptionValue]");
  const optionLabel = $("[id$=questionOptionLabel]");
  const optionValidCheckBox = $("[id$=questionOptionValidity]");
  const optionValueError = $("[id$=questionOptionValueError]");
  const optionExistError = $("[id$=questionOptionExistError]");

  /* validate current option */
  if (optionValue.val().length < 1 || optionValue.val().length > 64) {
    optionValueError.removeClass('d-none');
    return;
  } else {
    optionValueError.addClass('d-none');
  }

  /* check if option already exist */
  const index = sessionQuestions[currentQuestion].options.findIndex(o => {
    return o.value === optionValue.val();
  });
  if (index >= 0) {
    optionExistError.removeClass('d-none');
    return;
  } else {
    optionExistError.addClass('d-none');
  }

  /* save current option */
  const value = optionValue.val();
  const validity = optionValidCheckBox.is(":checked");
  sessionQuestions[currentQuestion].options[currentOption] =
    new Option(value, validity);
  if (validity && questionType.val() == "Multiple Choice") {
    optionValidCheckBox.attr("disabled", "true");
    optionValidCheckBox.prop("checked", false);
  }

  /* reset option */
  optionLabel.text(optionLabel.text().replace(/[\d]/,
    sessionQuestions[currentQuestion].options.length + 1));
  optionValue.val('');
  optionValidCheckBox.prop("checked", false);

  /* show existing options */
  const existingOptions = $("[id$=existingOptions]");
  existingOptions.html("");

  const options = sessionQuestions[currentQuestion].options;
  showOptions(options);
  
  currentOption = sessionQuestions[currentQuestion].options.length;
}


/* add another Question to quiz */
function addAnotherQuestion() {
  const questionValue = $("[id$=question]");
  const questionDescription = $("[id$=questionDescription]");
  const questionMarks = $("[id$=questionMarks]");
  const questionType = $("[id$=questionType]").find(":selected");

  const questionError = $("[id$=questionError]");
  const questionMarksError = $("[id$=questionMarksError]");
  const questionOptionError = $("[id$=questionOptionError]");
  const questionTypeError = $("[id$=questionTypeError]");

  const existingOptions = $("[id$=existingOptions]");
  const optionValue = $("[id$=questionOptionValue]");
  const optionLabel = $("[id$=questionOptionLabel]");
  const optionValidCheckBox = $("[id$=questionOptionValidity]");

  /* validate current Question */
  if (!questionValue.val().length) {
    questionError.removeClass("d-none");
    return;
  } else {
    questionError.addClass("d-none");
  }

  if (Number(questionMarks.val()) < 1 || Number((questionMarks).val()) > 50) {
    questionMarksError.removeClass("d-none");
    return;
  } else {
    questionMarksError.addClass("d-none");
  }

  if (questionType.val() == "-1") {
    questionTypeError.removeClass("d-none");
    return;
  } else {
    questionTypeError.addClass("d-none");
  }

  if (questionType.val() === "Multiple Choice" ||
    questionType.val() === "Checkboxes") {
    if (!sessionQuestions[currentQuestion].options.length) {
      questionOptionError.removeClass("d-none");
      return;
    } else {
      questionOptionError.addClass("d-none");
    }

    if (optionValue.val().length >= 1) {
      const optionIndex = sessionQuestions[currentQuestion].options.findIndex(o => {
        return o.value == optionValue.val();
      });
      if (optionIndex < 0) {
        const confirm = window.confirm("Current option has not yet been saved! Continue? " +
          "Warning: This will discard current option!");
        if (!confirm) {
          return;
        }
      }
    }

    /* reset option */
    optionLabel.text("Option 1");
    optionValue.val("");
    optionValidCheckBox.prop("checked", false);
    optionValidCheckBox.prop("disabled", false);
    existingOptions.html("");
  }

  /* save current question */
  sessionQuestions[currentQuestion].question = questionValue.val();
  sessionQuestions[currentQuestion].description = questionDescription.val();
  sessionQuestions[currentQuestion].type = questionType.val();
  sessionQuestions[currentQuestion].marks = Number(questionMarks.val());
  if (questionType.val() != "Multiple Choice" &&
    questionType.val() != "Checkboxes") {
    sessionQuestions[currentQuestion].options = null;
  }

  /* reset question form */
  questionValue.val("");
  questionDescription.val("");
  questionType.children().first().attr("selected", "selected");
  questionMarks.val("0");


  currentQuestion = sessionQuestions.length;
  sessionQuestions[currentQuestion] = new Question();
  currentOption = 0;

  /* show questions */
  showQuestions();
}


/* edit an email address */
function editEmail() {
  let emailIndex = 0;
  const visibility = $("[id$=visibility]");
  const whiteEmail = $("[id$=whiteEmail]");
  const blackEmail = $("[id$=blackEmail]");
  let emails = null;
  let email = null;

  try {
    emailIndex = Number($(this).attr('data-edit-index'));
    if (emailIndex < 0) {
      throw new Error();
    }
  } catch {
    window.alert("Something went wrong!");
    return;
  }

  if (visibility.val() == "Public") {
    emails = globalBlackList;
    email = blackEmail;
  } else {
    emails = globalWhiteList;
    email = whiteEmail;
  }

  const _email = emails[emailIndex];
  email.val(_email);
  emails.splice(emailIndex, 1);

  $(this).parent().parent().remove();
}


/* edit a question option */
function editQuestionOption() {
  const optionValue = $("[id$=questionOptionValue]");
  const optionValidCheckBox = $("[id$=questionOptionValidity]");

  /* save OR discard current option */
  const index = sessionQuestions[currentQuestion].options.findIndex(o => {
    return o.value == optionValue.val();
  });
  if (optionValue.val().length && (index < 0)){
    const confirm = window.confirm("This option is not yet saved. Continue? " +
      "Warning: This will discard this option!");
    if (!confirm) {
      return;
    }
  }

  let optionIndex = NaN;
  try {
    optionIndex = Number($(this).attr('data-edit-index'));
    if (optionIndex < 0) {
      throw new Error();
    }
  } catch (e) {
    alert("Something went wrong!");
    return; // invalid index
  }

  const option = sessionQuestions[currentQuestion].options[optionIndex];
  optionValue.val(option.value);
  optionValidCheckBox.prop("checked", option.valid ? true : false);

  /* remove existing option */
  sessionQuestions[currentQuestion].options.splice(optionIndex, 1);
  currentOption = sessionQuestions[currentQuestion].options.length;

  $(this).parent().parent().remove();
}


/* edit a question */
function editQuestion() {
  const questionValue = $("[id$=question]");
  const questionDescription = $("[id$=questionDescription]");
  const questionType = $("[id$=questionType]");
  const questionMarks = $("[id$=questionMarks]");

  const questionOptionLabel = $("[id$=questionOptionLabel]");
  const questionOptionValue = $("[id$=questionOptionValue]");

  /* save or discard current question */
  const existingQuestionIndex = sessionQuestions.find(q => {
    return q.question == questionValue.val();
  });
  if (questionValue.val().length >= 0 && existingQuestionIndex < 0) {
    const confirm = window.confirm("Current Question is not yet saved! Continue? " +
      "Warning: This will discard current question!");
    if (!confirm) {
      return;
    }
  }

  let editQuestionIndex = 0;
  try {
    editQuestionIndex = Number($(this).attr('data-edit-index'));
    if (editQuestionIndex < 0 || editQuestionIndex >= sessionQuestions.length) {
      throw new Error();
    }
  } catch (e) {
    window.alert("Something went wrong!");
    return;
  }

  const question = sessionQuestions[editQuestionIndex];
  questionValue.val(question.question);
  questionDescription.val(question.description);
  questionType.val(question.type);
  questionMarks.val(question.marks);

  sessionQuestions.splice(editQuestionIndex, 1);
  currentQuestion = sessionQuestions.length - 1;
  sessionQuestions[currentQuestion] = new Question();

  if (question.type == "Multiple Choice") {
    sessionQuestions[currentQuestion].options = question.options;
    showOptions(question.options);    

    /* reset Option Form */
    questionOptionLabel.text("Option 1");
    questionOptionValue.val("");
  }

  $(this).parent().parent().remove();
}


/* Save Quiz */
function saveQuiz() {
  const form = $("[id$=indexMaster]");
  const title = $("[id$=title]");
  const description = $("[id$=description]");
  const totalMarks = $("[id$=totalMarks]");
  const passingMarks = $("[id$=passingMarks]");
  const visibility = $("[id$=visibility]").find(":selected");
  const quiz = $("[id$=quiz]");
  const questionValue = $("[id$=question]");

  const titleError = $("[id$=titleError]");
  const totalMarksError = $("[id$=totalMarksError]");
  const passingMarksError = $("[id$=passingMarksError]");
  const questionRequiredError = $("[id$=questionRequiredError]");
  const whiteListError = $("[id$=whiteListError]");

  // title invalid error
  if (title.val().length < 10 || title.val().length > 64) {
    titleError.removeClass("d-none");
    return;
  } else {
    titleError.addClass("d-none");
  }

  // total marks invalid error
  if ((Number(totalMarks.val()) < 1 || Number(totalMarks.val())) > 1000) {
    totalMarksError.removeClass("d-none");
    return;
  } else {
    totalMarksError.addClass("d-none");
  }

  // passing marks invalid error 
  if (Number(passingMarks.val()) < 1 || Number(passingMarks.val()) > 1000 ||
    Number(passingMarks.val()) > Number(totalMarks.val())) {
    passingMarksError.removeClass("d-none");
    return;
  } else {
    passingMarksError.addClass("d-none");
  }

  // white list error, need at least 1 white email for private quiz
  if (visibility.val() == "Private" && !globalWhiteList.length) {
    whiteListError.removeClass('d-none');
    return;
  } else {
    whiteListError.addClass('d-none');
  }

  /* no question error */
  if (sessionQuestions.length <= 1) { // an extra question exist in sessionQuestions
    questionRequiredError.removeClass("d-none");
    return;
  } else {
    questionRequiredError.addClass("d-none");
  }

  // question unsaved error
  if (questionValue.val().length >= 1) {
    const questionIndex = sessionQuestions.findIndex(q => {
      return q.question == questionValue.val();
    });

    if (questionIndex < 0) {
      const confirm = window.confirm("You have an unsaved question. Continue? " +
        "Warning: This will discard the question!");
      if (!confirm) {
        return;
      }
    }
  }

  /* remove last empty question from questions */
  sessionQuestions.splice(sessionQuestions.length - 1, 1);

  try {
    const quizObject = {
      title: title.val(),
      description: description.val(),
      totalMarks: Number(totalMarks.val()),
      passingMarks: Number(passingMarks.val()),
      visibility: visibility.val(),
      blackList: globalBlackList,
      whiteList: globalWhiteList,
      questions: sessionQuestions
    };

    let json = JSON.stringify(quizObject);
    /* make sure it is safe */
    json = json.replace("<", "&lt;");
    json = json.replace(">", "&gt;");

    quiz.val(json);
  } catch {
    window.alert("Something went wrong.");
    return;
  }

  form.submit();
}
/*****************************************************************************/


/*****************************************************************************/
/// OTHER FUNCTIONS
function showOptions(options) {
  const existingOptions = $("[id$=existingOptions]")
    .html("");

  for (let i = 0; i < options.length; i++) {
    const div = $(document.createElement('div'))
      .addClass('alert alert-secondary d-flex flex-row' +
        'align-items-center p-2')
      .appendTo(existingOptions);

    const validityWrapper = $(document.createElement('span'))
      .addClass('mr-1')
      .addClass(options[i].valid ? "text-success" : "text-danger")
      .appendTo(div);
    const validity = $(document.createElement('i'))
      .addClass("fas " + (options[i].valid ? "fa-check-circle" : "fa-times-circle"))
      .appendTo(validityWrapper);

    const text = $(document.createElement('div'))
      .addClass('mr-1 flex-fill')
      .text(options[i].value)
      .appendTo(div);

    /* edit option */
    const editWrapper = $(document.createElement('div'))
      .addClass("mr-1")
      .appendTo(div);

    const editButton = $(document.createElement('button'))
      .addClass('btn btn-light')
      .attr('data-edit-index', i) /* important: sets index to denote which option to edit */
      .attr('type', 'button')
      .on('click', editQuestionOption)
      .appendTo(editWrapper)

    const editIcon = $(document.createElement('i'))
      .addClass('far fa-edit')
      .appendTo(editButton);

    /* delete option */
    const deleteWrapper = $(document.createElement('div'))
      .addClass('mr-1')
      .appendTo(div);

    const deleteButton = $(document.createElement('button'))
      .addClass('btn btn-danger')
      .attr('data-edit-index', i) /* important: sets index to denote which option to edit */
      .attr('type', 'button')
      .on('click', deleteQuestionOption)
      .appendTo(deleteWrapper)

    const deleteIcon = $(document.createElement('i'))
      .addClass('far fa-trash-alt')
      .appendTo(deleteButton);
  }
}


/* show Questions */
function showQuestions() {
  const existingQuestions = $("[id$=existingQuestions]")
    .html("");

  for (let i = 0; i < sessionQuestions.length - 1; i++) {
    const div = $(document.createElement('div'))
      .addClass('alert alert-secondary d-flex flex-row-reverse ' +
        'align-items-center p-1 m-1');


    const deleteWrapper = $(document.createElement('div'))
      .addClass("ml-1")
      .appendTo(div);

    const deleteButton = $(document.createElement('button'))
      .addClass('btn btn-danger')
      .attr('data-edit-index', i) /* important: sets index to denote which option to edit */
      .attr('type', 'button')
      .on('click', deleteQuestion)
      .appendTo(deleteWrapper);

    const deleteIcon = $(document.createElement('i'))
      .addClass("far fa-trash-alt")
      .appendTo(deleteButton);

    const edit = $(document.createElement('div'))
      .addClass("ml-1")
      .append($(document.createElement('button'))
        .addClass('btn btn-light')
        .attr('data-edit-index', i) /* important: sets index to denote which option to edit */
        .attr('type', 'button')
        .on('click', editQuestion)
        .append($(document.createElement('i'))
          .addClass('far fa-edit')
        ))
      .appendTo(div);

    const text = $(document.createElement('div'))
      .addClass('ml-1 flex-fill')
      .text(sessionQuestions[i].question)
      .addClass('overflow-hidden')
      .appendTo(div);

    div.append(edit, text);
    existingQuestions.append(div);
  }
}

/* validate an email address
  @utilityFunction
*/
function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}

/* Set up settings on startup */
function bootstrap() {
  const activeLink = $("[id$=newQuizButton]");
  const questionType = $("[id$=questionType]");
  const visiblity = $("[id$=visibility]");
  const whiteList = $("[id$=whiteList]");
  const questionOptions = $("[id$=questionOptions]");

  activeLink.addClass("bg-dark text-light");

  questionType.find("[value='Brief']").attr("selected", true);
  visiblity.find("[value='Public']").attr("selected", true);

  whiteList.fadeOut();
  questionOptions.fadeOut();

  var updateMode = $("[id$=updateMode]");
  if (updateMode.val() == "true") {
    var quizJSON = $("[id$=quiz]");
    var quiz = JSON.parse(quizJSON.val());

    $("[id$=submitButton]").text("Update")
      .addClass("btn-success");
    $("[id$=title]").val(quiz.title);
    $("[id$=description]").val(quiz.description);
    $("[id$=totalMarks]").val(quiz.totalMarks);
    $("[id$=passingMarks]").val(quiz.passingMarks);
    $("[id$=visibility]").val(quiz.visibility);
    globalBlackList = quiz.blackList || [];
    globalWhiteList = quiz.whiteList || [];

    sessionQuestions.splice(0, sessionQuestions.length); // truncate questions first
    for (const q of quiz.questions) {
      sessionQuestions.push(q);
    }

    currentQuestion = sessionQuestions.length;
    sessionQuestions[currentQuestion] = new Question();
    showQuestions();
  }
}

$(document).ready(() => {
  bootstrap();
});