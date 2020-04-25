<%@ Page Title="" Language="C#" MasterPageFile="~/teacher_quizzes/teacher_quizzes.master" AutoEventWireup="true" CodeBehind="all_quizzes.aspx.cs" Inherits="onlineQuiz_bsef17m35.teacher_quizes.all_quizzes" %>
<%@ MasterType VirtualPath="~/teacher_quizzes/teacher_quizzes.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="teacherQuizHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="quizes" runat="server">
  <div runat="server" class="p-2 d-flex flex-column" id="allQuizesContainer">
    <asp:Repeater runat="server" ID="AllQuizzesRepeater">
      <ItemTemplate>
        <div class="asp-panel p-2">
          <div class="alert alert-dark p-2"><b><%# Eval("title") %></b></div>
          <div class="p-2"><b><%# Eval("description") %></b></div>

          <div class="row p-2 flex-wrap">
            <div class="border border-danger mr-1 field">
              <div class="alert alert-dark">ID</div>
              <div class="alert"><%# Eval("id") %></div>
            </div>

            <div class="border border-danger mr-1 field">
              <div class="alert alert-dark">Submissions</div>
              <div class="alert"><%# Eval("submissionCount") %></div>
            </div>

            <div class="border border-danger mr-1 field">
              <div class="alert alert-dark">Questions</div>
              <div class="alert"><%# Eval("questionCount") %></div>
            </div>

            <div class="border border-danger mr-1 field">
              <div class="alert alert-dark">Total Marks</div>
              <div class="alert"><%# Eval("totalMarks") %></div>
            </div>

            <div class="border border-danger mr-1 field">
              <div class="alert alert-dark">Passing Marks</div>
              <div class="alert"><%# Eval("passingMarks") %></div>
            </div>

            <div class="border border-danger mr-1 field">
              <div class="alert alert-dark">Visiblity</div>
              <div class="alert"><%# Eval("visibility") %></div>
            </div>
          </div>

          <div class="d-flex flex-row-reverse p-2">
            <button class="btn btn-danger">Delete</button>
            <button class="btn btn-light mr-1 field">Edit</button>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
  <script>
    $(document).ready(() => {
      const allQuizzesButton = $("[id$=allQuizzesButton]");
      if (allQuizzesButton) {
        allQuizzesButton.attr("class", "btn btn-active bg-dark text-light");
      }

      $("#teacherLinkAllQuizzes").addClass("text-dark");
    });
  </script>
</asp:Content>
