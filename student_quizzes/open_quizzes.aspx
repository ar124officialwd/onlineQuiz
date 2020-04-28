<%@ Page Title="" Language="C#" MasterPageFile="~/student_quizzes/student_quizzes.master" AutoEventWireup="true" CodeBehind="open_quizzes.aspx.cs" Inherits="onlineQuiz_bsef17m35.student_quizzes.open_quizzes" %>
<%@ MasterType VirtualPath="~/student_quizzes/student_quizzes.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="quizes" runat="server">
  <div class="p-2">
    <asp:Repeater id="openQuizzesRepeater" runat="server">
      <ItemTemplate>
        <div class="asp-panel mb-1">
          <div class="p-1">
            <b><%# Eval("title") %></b>
          </div>

          <div class="p-1">
            <small>
              <%# Eval("description") %>
            </small>
          </div>

          <div class="p-1">
            <b>Total Questions: </b>
            <span><%# Eval("questionCount") %></span>
          </div>

          <div class="p-1">
            <b>Total Marks: </b>
            <span><%# Eval("totalMarks") %></span>
          </div>

          <div class="p-1">
            <b>Passing Marks: </b>
            <span><%# Eval("passingMarks") %></span>
          </div>

          <div class="p-1">
            <asp:Button runat="server" CssClass="btn btn-primary quizLinkButton"
              Text="Take Quiz" OnClick="OpenQuiz" CommandName='<%# Eval("teacherId") %>'
              CommandArgument='<%# Eval("id") %>'/>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>

  <asp:HiddenField runat="server" ID="selectedQuizEmail" Value=""/>
  <asp:HiddenField runat="server" ID="selectedQuizId" Value=""/>

  <script>
    $(document).ready(() => {
      const quizzesButton = $("[id$=openQuizzesButton]");
      if (quizzesButton.length) {
        quizzesButton.addClass('btn-active bg-dark text-light');
      }

      $(".quizLinkButton").click(quizLinkClick);

      $("#studentLinkOpenQuizzes").addClass("text-dark").attr("href", "#");
    });

    function quizLinkClick() {
      var selectedQuizEmail = $("[id$=selectedQuizEmail]");
      var selectedQuizId = $("[id$=selectedQuizId]");

      var parent = $(this).parent();
      var teacherEmail = $(parent.find("[data-teacherEmail]")[0]);
      var quizId = $(parent.find("[data-quizId]")[0]);

      selectedQuizEmail.val(teacherEmail.attr('data-teacherEmail'));
      selectedQuizId.val(quizId.attr('data-quizId'));

      console.log(selectedQuizEmail.val());
      console.log(selectedQuizId.val());
    }
  </script>
</asp:Content>
