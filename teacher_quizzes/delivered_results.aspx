<%@ Page Title="" Language="C#" MasterPageFile="~/teacher_quizzes/teacher_quizzes.master" AutoEventWireup="true" CodeBehind="delivered_results.aspx.cs" Inherits="onlineQuiz_bsef17m35.teacher_quizzes.delivered_results" %>
<%@ MasterType VirtualPath="~/teacher_quizzes/teacher_quizzes.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="teacherQuizHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="quizes" runat="server">
  <div class="m-1 p-2">
    <asp:Repeater runat="server" ID="quizRepeater">
      <ItemTemplate>
        <div class="m-1 p-2 asp-panel">
          <div class="alert alert-dark p-2">
            <b><%# Eval("title") %></b>
          </div>

          <asp:Repeater runat="server" ID="resultRepeater">
            <ItemTemplate>
              <div class="d-flex flex-row flex-wrap bg-light p-1 m-1">
                <div class="mr-1 d-flex flex-column asp-panel p-0">
                  <span class="p-2 alert alert-dark">Student Name</span>
                  <asp:Label runat="server" CssClass="p-2" Text='<%# Eval("studentName") %>'></asp:Label>
                </div>

                <div class="mr-1 d-flex flex-column asp-panel p-0">
                  <span class="p-2 alert alert-dark">Student Email</span>
                  <asp:Label runat="server" CssClass="p-2" Text='<%# Eval("studentEmail") %>'></asp:Label>
                </div>

                <div class="mr-1 d-flex flex-column asp-panel p-0">
                  <span class="p-2 alert alert-dark">Obtained Marks</span>
                  <asp:Label runat="server" CssClass="px-2" Text='<%# Eval("obtainedMarks") %>'></asp:Label>
                </div>

                <div class="mr-1 d-flex flex-column asp-panel p-0">
                  <span class="p-2 alert alert-dark">Status</span>
                  <asp:Label runat="server" CssClass="px-2" ID="status" Text='<%# Eval("status") %>'></asp:Label>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
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

      $("#teacherLinkDeliveredResults").addClass("text-dark");
    });
  </script>
</asp:Content>
