<%@ Page Title="" Language="C#" MasterPageFile="~/teacher_quizzes/teacher_quizzes.master" AutoEventWireup="true" CodeBehind="evaluate_quiz.aspx.cs" Inherits="onlineQuiz_bsef17m35.teacher_quizzes.evaluate_quiz" %>
<%@ MasterType VirtualPath="~/teacher_quizzes/teacher_quizzes.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="teacherQuizHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="quizes" runat="server">
  <div class="alert alert-success m-1 p-2" runat="server"
    id="resultIssued" visible="false">
    Result has been issued! Click <a href="submissions.aspx">here</a>
    to go back to submissions.
  </div>

  <div class="p-2" runat="server" id="mainView">
    <div class="alert alert-dark p-2">
      <b runat="server" id="quizTitle"></b>
    </div>

    <div class="p-2 d-flex flex-column">
      <div>
        <b>Student Name: </b><span runat="server" id="studentName"></span>
      </div>
      <div>
        <b>Student ID: </b><span runat="server" id="studentEmail"></span>
      </div>
    </div>

    <div runat="server" id="evaluationView">
      <asp:Repeater runat="server" ID="questionRepeater">
        <ItemTemplate>
          <div class="m-1 asp-panel p-2">
            <div>
              <b>Question: </b><span><%# Eval("question") %></span>
            </div>

            <div>
              <b>Question Type:</b>
              <span class="p-2"><%# Eval("type") %></span>
            </div>

            <div>
              <b>Max Grades:</b>
              <span class="p-2"><%# Eval("marks") %></span>
            </div>

            <div>
              <b>Given Answer(s):</b>
              <div class="m-1 py-1 px-2 border-1 border-left border-primary"><%# Eval("answer") %></div>
              <asp:Repeater ItemType="System.string" runat="server" ID="answers">
                <ItemTemplate>
                  <div class="py-1 px-2 border-1 border-left border-primary"><%# Item %></div>
                </ItemTemplate>
              </asp:Repeater>
            </div>

            <div>
              <b>Grades</b>
              <asp:TextBox runat="server" CssClass="form-control m-1" TextMode="number"
                ID="questionGrades" Text="0" />

              <asp:RangeValidator runat="server" ControlToValidate="questionGrades"
                Type="Integer" MinimumValue="0" MaximumValue='<%# Eval("marks") %>'
                CssClass="text-danger" ErrorMessage="Grade cannot excceed max grades!">
              </asp:RangeValidator>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>

      <div class="m-1 d-flex flex-row">
        <button class="btn btn-primary" runat="server" id="reviewResult"
          onserverclick="reviewResult_ServerClick">
          Preview Result</button>
      </div>
    </div>

    <div runat="server" id="resultPreview" class="p-2" visible="false">
      <div class="alert alert-danger" runat="server" id="issueResultError"
        visible="false"></div>

      <div>
        <b>Total Marks: </b><span runat="server" id="totalMarks"></span>
      </div>

      <div>
        <b>Total Marks: </b><span runat="server" id="passingMarks"></span>
      </div>

      <div>
        <b>Marks Obtained: </b><span runat="server" id="marksObtained"></span>
      </div>

      <div>
        <b>Status: </b><span runat="server" id="status"></span>
      </div>

      <div class="m-1 d-flex flex-row">
        <button class="btn btn-primary mr-1" runat="server" id="reEvaluateResult"
          onserverclick="reEvaluateResult_ServerClick">
          Re-Evaluate Result</button>
        <button class="btn btn-primary" runat="server" id="issueResult"
          onserverclick="issueResult_ServerClick">
          Issue Result</button>
      </div>
    </div>
  </div>
</asp:Content>
