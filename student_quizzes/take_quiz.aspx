<%@ Page Title="" Language="C#" MasterPageFile="~/student_quizzes/student_quizzes.master" AutoEventWireup="true" CodeBehind="take_quiz.aspx.cs" Inherits="onlineQuiz_bsef17m35.student_quizzes.take_quiz" %>
<asp:Content ID="Content1" ContentPlaceHolderID="quizes" runat="server">
  <asp:HiddenField runat="server" ID="quizJSON" />

  <div id="takeQuizError" runat="server" class="m-1 alert alert-danger"
    visible="false"></div>

  <div runat="server" id="takeQuizView">
    <div class="m-1 asp-panel d-flex flex-row bg-light align-items-center justify-content-around">
      <div class="d-flex flex-column flex-fill">
        <h4 class="flex-fill" runat="server" id="quizTitle"></h4>
        <div class="font-weight-light p-1" runat="server" id="quizDescription"></div>
      </div>

      <div class="d-flex flex-row align-items-center">
        <div class="mr-2 bg-light">
          <span>Total Questions: </span>
          <span runat="server" id="totalQuestions"></span>
        </div>
        <div class="mr-2 bg-light">
          <span>Total Marks: </span>
          <span runat="server" id="totalMarks"></span>
        </div>
        <button class="btn btn-light" runat="server">Close</button>
      </div>
    </div>

    <div id="questionsWindow" class="m-1 asp-panel d-flex flex-row flex-wrap">
      <div class="flex-fill">Select a question</div>
    </div>

    <div id="answerWindow" class="m-1 asp-panel d-flex flex-column">
      <div class="d-flex flex-row">
        <div id="questionTitle" class="font-weight-bold flex-fill"></div>
        <div id="questionType" class="bg-light p-2"></div>
      </div>

      <div id="questionDescription" class="font-weight-light"></div>

      <div class="font-weight-bold my-1">Your answer</div>
      <div id="answerBox"></div>

      <div class="m-1 d-flex flex-row-reverse">
        <button id="answerSubmit" type="button" class="btn btn-light">Save Answer</button>
      </div>
    </div>

    <div id="sumbitWindow" class="m-1">
      <button type="button" class="btn btn-primary" id="submitButton">Submit</button>
      <button class="btn btn-primary" id="realSubmitButton"
        runat="server" onserverclick="realSubmitButton_ServerClick"
        style="display: none;"></button>
    </div>
  </div>
</asp:Content>
