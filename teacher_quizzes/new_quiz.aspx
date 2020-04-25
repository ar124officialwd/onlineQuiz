<%@ Page Title="" Language="C#" MasterPageFile="~/teacher_quizzes/teacher_quizzes.master" AutoEventWireup="true" CodeBehind="new_quiz.aspx.cs" Inherits="onlineQuiz_bsef17m35.teacher_quizes.new_quiz" %>
<%@ MasterType VirtualPath="~/teacher_quizzes/teacher_quizzes.master" %>

<asp:Content runat="server" ContentPlaceHolderID="teacherQuizHead">
  <link rel="stylesheet" type="text/css" href="new_quiz.css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="quizes" runat="server">
  <div runat="server" id="newQuizForm" class="form p-2 pb-5">
    <div class="form-group p-1">
      <asp:Label runat="server" Text="Quiz Title"></asp:Label><br />
      <small class="text-danger">The title of your quiz</small>
      <input runat="server" type="text" id="title" class="form-control" />
    </div>

    <div class="form-group p-1">
      <asp:Label runat="server" Text="Quiz Description"></asp:Label><br />
      <small class="text-danger">Please describe this quiz</small>
      <textarea runat="server" id="description" class="form-control" rows="2" maxlength="128">
      </textarea>
    </div>

    <div class="form-group p-1">
      <asp:Label runat="server" Text="Maximum Marks"></asp:Label><br />
      <small class="text-danger">The maximum achiveable marks for this quiz, between 1 and 1000</small>
      <input runat="server" type="number" min="1" max="100" id="totalMarks" class="form-control"/>
    </div>

    <div class="form-group p-1">
      <asp:Label runat="server" Text="Passing Marks"></asp:Label><br />
      <small class="text-danger">The passing marks for this quiz, between 1 and 999 and lesser than or equal to total
        marks</small>
      <input runat="server" type="number" id="passingMarks"
        class="form-control" />
    </div>


    <div class="form-group">
      <asp:Label runat="server" Text="Visibility"></asp:Label><br />
      <small>Who can View and Submit this Quiz? Public(Anyone) or 
        Private(Selected Emails)?
      </small>
      <select runat="server" id="visibility" class="form-control"
        onchange="visibilityChange()">
        <option value="-1">Please select Visibility</option>
      </select>
    </div>

    <div class="asp-panel">
      <div runat="server" class="form-group" id="whiteList">
        <div><b>White List</b></div>
        <small>Allowed people's email addresses</small>

        <div class="form-group">
          <label>Email Address</label>

          <div class="input-group">
            <input runat="server" type="email" id="whiteEmail"
              class="form-control" 
              pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">

            <div class="input-group-append px-2">
              <button runat="server" type="button" id="addWhiteEmail"
                class="btn btn-light" onclick="addEmail()">
                Add Email</button>
            </div>
          </div>
          <div class="d-none text-danger" id="invalidWhiteEmail">
            Please enter a valid email!
          </div>

          <div runat="server" id="existingWhiteEmails"></div>
        </div>
      </div>

      <div runat="server" class="form-group" id="blackList">
        <div><b>Black List</b></div>
        <small>Not Allowed people's email addresses</small>

        <div class="form-group">
          <label>Email Address</label>

          <div class="input-group">
            <input runat="server" type="email" id="blackEmail"
              class="form-control" 
              pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">

            <div class="input-group-append px-2">
              <button runat="server" type="button" id="addBlackEmail"
                class="btn btn-light" onclick="addEmail()">
                Add Email</button>
            </div>
          </div>
          <div class="d-none text-danger" id="invalidBlackEmail">
            Please enter a valid email!
          </div>

          <div runat="server" id="existingBlackEmails"></div>
        </div>
      </div>
    </div>

    <div class="form-group p-1">
      <asp:HiddenField runat="server" ID="quiz" Value="" />
    </div>

    <asp:Panel runat="server" CssClass="asp-panel p-1">
      <div><b>Quesions</b></div>

      <div class="form-group">
        <asp:Label runat="server" Text="Question"></asp:Label><br />
        <asp:TextBox runat="server" ID="question" CssClass="form-control">
        </asp:TextBox>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="Question Desription(Optional)"></asp:Label><br />
        <asp:TextBox runat="server" ID="questionDescription"
          MaxLength="128" CssClass="form-control">
        </asp:TextBox>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="Question Grade"></asp:Label><br />
        <small>Please enter marks for this question, between 1 and 50</small>
        <asp:TextBox runat="server" TextMode="Number" 
          ID="questionMarks" CssClass="form-control">
        </asp:TextBox>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="Type of Question"></asp:Label><br />
        <select runat="server" id="questionType" class="form-control" onchange="questionTypeChange()">
          <option value="-1">Select a Question Type</option>
        </select>
      </div>

      <asp:Panel runat="server" CssClass="asp-panel" ID="questionOptions">
        <small>Please check checkbox in front of Options to denote an option as true</small>

        <div id="questionOption" class="form-group">
          <label id="questionOptionLabel">Option 1</label><br />
          <small>Enter the option value of length between 1 and 64</small>
          <div class="input-group">
            <asp:TextBox runat="server" maxlength="64" ID="questionOptionValue"
              CssClass="form-control" AutoPostBack="false"></asp:TextBox>

            <div class="input-group-append px-2">
              <input runat="server" type="checkbox" id="questionOptionValidity" />
            </div>
          </div>
          <div class="text-danger d-none" id="questionOptionValueError">
            Please enter a valid option
          </div>
          <div class="text-danger d-none" id="questionOptionExistError">
            This option already exist, please choose another value
          </div>
          <div class="text-danger d-none" id="questionOptionUpdateError">
            This option will be removed, unless you click '+' button
          </div>
        </div>

        <div class="d-flex flex-row-reverse">
          <button type="button" class="btn btn-light btn-primary p-3"
            title="Add another option"
            id="questionOptionAdd"
            onclick="addQuestionOption()">
            Save Option</button>
        </div>

        <div id="existingOptions" class="p-2"></div>
      </asp:Panel>

      <div class="text-danger d-none" id="questionError">
        Question is required! Please add question Text
      </div>
      <div class="text-danger d-none" id="questionMarksError">
        Question Grade is required! Please add marks for the question
      </div>
      <div class="text-danger d-none" id="questionTypeError">
        Question Type is required! Please Select a Question Type
      </div>
      <div class="text-danger d-none" id="questionOptionError">
        Please add at least one option, or change Question Type
      </div>

      <div class="d-flex flex-row-reverse p-2">
        <button type="button" class="btn btn-light btn-primary p-3"
          title="Save current & Add another question"
          id="addQuestion"
          onclick="addAnotherQuestion()">
          Save Question</button>
      </div>

      <div id="existingQuestions" class="p-2"></div>
    </asp:Panel>

    <div class="p-2">
      <span id="titleError" class="text-danger d-none">
        Please enter a valid title(Length between 10 to 64 characters)
      </span>
      <span id="whiteListError" class="text-danger d-none">
        Please add at least 1 email in White List OR make the quiz Public
      </span>
      <span id="totalMarksError" class="text-danger d-none">
        Please enter valid marks(A number between 1 and 1000)
      </span>
      <span id="passingMarksError" class="text-danger d-none">
        Please enter valid passing marks, (A number between 1 and 999, must be less then Passing Marks)
      </span>
      <span id="questionRequiredError" class="text-danger d-none">
        Please add at least one question
      </span>
    </div>

    <div class="p-2">
      <button onClick="saveQuiz()" class="btn btn-primary"
        type="button">Save Quiz</button>
    </div>
  </div>

  <div runat="server" id="response" class="asp-panel alert alert-info">
    Quiz has been successfully Saved. <a href="new_quiz.aspx">Add another quiz</a>
  </div>

  <div runat="server" id="applicationError"
    class="asp-panel alert alert-danger p-2">
    We are really Sorry, but something went wrong while processing quiz. Please
    try again!
  </div>

  <script>
    $("#teacherLinkNewQuiz").addClass("text-dark");
  </script>
</asp:Content>
