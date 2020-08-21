<%@ Page Title="" Language="C#" MasterPageFile="~/student_quizzes/student_quizzes.master" AutoEventWireup="true" CodeBehind="my_submissions.aspx.cs" Inherits="onlineQuiz_bsef17m35.student_quizzes.my_submissions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="quizes" runat="server">
  <div class="p-1 m-1">
    <div class="alert alert-danger" runat="server" id="loadError"
      visible="false">Something went wrong. Unable to load submissions</div>

    <asp:Repeater runat="server" ID="quizRepeater">
      <ItemTemplate>
        <div class="m-1 p-2 asp-panel">
          <div class="p-2 alert alert-dark">
            <b><%# Eval("quizTitle") %></b>
          </div>

          <div class="p-2">
            <b>Teacher Name:</b><asp:Label runat="server" CssClass="px-2"
              Text='<%# Eval("teacherName") %>'></asp:Label>
          </div>

          <div class="p-2">
            <b>Teacher Email:</b><asp:Label runat="server" CssClass="px-2"
              Text='<%# Eval("teacherEmail") %>'></asp:Label>
          </div>

          <asp:Repeater runat="server" ID="questionRepeater" Visible="false">
            <ItemTemplate>
              <div class="m-1 p-2 asp-panel">
                <b>Question:</b><asp:Label runat="server" CssClass="px-2"
                  Text='<%# Eval("question") %>'></asp:Label>

                <b>Your Answer:</b><asp:Label runat="server" CssClass="px-2"
                  Text='<%# Eval("answer") %>'></asp:Label>

                <asp:Repeater runat="server" ID="answerRepeater"
                  ItemType="System.string">
                  <ItemTemplate>
                    <asp:Label runat="server" CssClass="px-2"
                      Text='<%# Item %>'></asp:Label>
                  </ItemTemplate>
                </asp:Repeater>
              </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
</asp:Content>
