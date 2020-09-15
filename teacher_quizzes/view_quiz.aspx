<%@ Page Title="" Language="C#" MasterPageFile="~/teacher_quizzes/teacher_quizzes.master" AutoEventWireup="true" CodeBehind="view_quiz.aspx.cs" Inherits="onlineQuiz_bsef17m35.teacher_quizzes.view_quiz" %>



<asp:Content ID="Content1" ContentPlaceHolderID="teacherQuizHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="quizes" runat="server">
  <div runat="server" id="loadError" class="alert alert-danger" visible="false">
    Unable to load quiz! No such quiz.
  </div>

  <div runat="server" id="quizView">
    <div class="d-flex flex-row asp-panel bg-light m-1">
      <div class="p-1 flex-fill mr-2 d-flex flex-column">
        <h5 runat="server" id="quizTitle"></h5>
      </div>
      <div class="d-flex flex-row p-1 mr-2">
        <button class="btn btn-light mr-1">Edit</button>
        <button class="btn btn-light mr-1">View Submissions</button>
        <button class="btn btn-danger mr-1">Delete</button>
      </div>
    </div>

    <div runat="server" class="p-1 m-1" id="quizQuestionsView">
    </div>
  </div>
</asp:Content>
