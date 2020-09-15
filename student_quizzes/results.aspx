<%@ Page Title="" Language="C#" MasterPageFile="~/student_quizzes/student_quizzes.master" AutoEventWireup="true" CodeBehind="results.aspx.cs" Inherits="onlineQuiz_bsef17m35.student_quizzes.results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="quizes" runat="server">
  <div class="m-1 p-2">
    <asp:Repeater runat="server" ID="resultRepeater">
      <ItemTemplate>
        <div class="p-2 asp-panel">
          <div class="alert alert-dark p-2">
            <b><%# Eval("title") %></b>
          </div>

          <div class="p-2">
            <b>Teacher Name:</b><asp:Label runat="server" CssClass="px-2"><%# Eval("teacherName") %></asp:Label>
          </div>

          <div class="p-2">
            <b>Teacher Email:</b><asp:Label runat="server" CssClass="px-2"><%# Eval("teacherEmail") %></asp:Label>
          </div>

          <div class="p-2">
            <b>Total Marks:</b><asp:Label runat="server" CssClass="px-2"><%# Eval("totalMarks") %></asp:Label>
          </div>

          <div class="p-2">
            <b>Passing Marks:</b><asp:Label runat="server" CssClass="px-2"><%# Eval("passingMarks") %></asp:Label>
          </div>

          <div class="p-2">
            <b>Obtained Marks:</b><asp:Label runat="server" CssClass="px-2"><%# Eval("obtainedMarks") %></asp:Label>
          </div>

          <div class="p-2">
            <b>Status:</b><asp:Label runat="server" CssClass="px-2" id="status" Text='<%# Eval("status") %>'></asp:Label>
          </div>

          <div class="p-2 d-flex flex-row-reverse">
            <asp:Button runat="server" id="resultDetailedView"
              CssClass="btn btn-light ml-1" CommandName="DetailedView"
              CommandArgument='<%# Container.ItemIndex %>'
              OnClick="resultActions" Text="Detailed View"/>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
</asp:Content>
