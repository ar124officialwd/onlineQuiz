<%@ Page Title="" Language="C#" MasterPageFile="~/teacher_quizzes/teacher_quizzes.master" AutoEventWireup="true" CodeBehind="new_quiz_1.aspx.cs" Inherits="onlineQuiz_bsef17m35.teacher_quizzes.new_quiz_1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="teacherQuizHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="quizes" runat="server">
  <asp:HiddenField runat="server" ID="updateMode" Value="false" />
  <div runat="server" id="quizLoadError" visible="false"
    class="alert alert-danger"></div>

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
  </div>
</asp:Content>
