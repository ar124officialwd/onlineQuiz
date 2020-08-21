<%@ Page Title="" Language="C#" MasterPageFile="~/teacher_quizzes/teacher_quizzes.master" AutoEventWireup="true" CodeBehind="submissions.aspx.cs" Inherits="onlineQuiz_bsef17m35.teacher_quizzes.submissions" %>
<%@ MasterType VirtualPath="~/teacher_quizzes/teacher_quizzes.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="teacherQuizHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="quizes" runat="server">
  <div class="m-1">
    <asp:Repeater runat="server" ID="quizRepeater">
      <ItemTemplate>
        <div class="asp-panel m-1">
          <div class="alert alert-dark p-2">
            <b><%# Eval("title") %></b>
          </div>

          <div class="p-1">
            <asp:Repeater runat="server" ID="submissionRepeater">
              <ItemTemplate>
                <div class="m-1 p-1 d-flex flex-row">
                  <div class="flex-fill d-flex flex-column">
                    <div>
                      <b>Student Name: </b><span><%# Eval("studentName") %></span>
                    </div>

                    <div>
                      <b>Student Email: </b><span><%# Eval("studentEmail") %></span>
                    </div>
                  </div>

                  <div class="d-flex flex-row">
                    <asp:Button runat="server" CssClass="btn btn-light mr-1"
                      ID="evaluate" CommandName='<%# Eval("quizId") %>'
                      CommandArgument='<%# Eval("studentId") %>'
                      OnClick="evaluate_Click" Text="Evaluate"></asp:Button>
                  </div>
                </div>
              </ItemTemplate>
            </asp:Repeater>
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

      $("#teacherLinkSubmissions").addClass("text-dark");
    });
  </script>
</asp:Content>
