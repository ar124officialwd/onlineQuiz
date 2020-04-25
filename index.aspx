<%@ Page Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebApplication1.home" %>

<asp:Content runat="server" ContentPlaceHolderID="indexHead">
  <link rel="stylesheet" type="text/css" href="index.css" />
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="NavbarNav">
  <li class="px-2 nav-item active">
    <a href="/index.aspx" class="nav-link">Home</a>
  </li>
  <li class="px-2 nav-item">
    <a href="#" class="nav-link">Motivations</a>
  </li>
  <li class="px-2 nav-item">
    <a href="#" class="nav-link">Recent Open Quizzes</a>
  </li>
  <li class="px-2 nav-item">
    <a href="#" class="nav-link">Help</a>
  </li>
  <li class="px-2 nav-item">
    <a href="#" class="nav-link">About</a>
  </li>
  <li class="px-2 nav-item">
    <a href="/login.aspx" class="nav-link">Login</a>
  </li>
</asp:Content>

<asp:Content runat="server" ID="homeContent" ContentPlaceHolderID="mainContent">
  <div class="home">
    <div class="banner d-flex flex-row-reverse p-4 mr-5">
      <div class="d-flex flex-column-reverse mr-5">
        <div class="p-2 pb-5"></div>

        <div class="p-5 mr-5 d-flex flex-row-reverse">
          <div class="d-flex flex-row align-items-center">
            <div class="text-light">
              <h3>Continue as</h3>
            </div>
            <div class="mx-2 p-0 alert bg-light">
              <div class="btn bg-light p-2 d-flex flex-row">
                <div class="px-2">
                  <img class="img24" src="resources/images/teacher.png" />
                </div>
                <div class="px-2">
                  <a href="/signup.aspx?userType=teacher" class="text-dark">Teacher</a>
                </div>
              </div>
            </div>
            <div class="mx-2 p-0 alert bg-light">
              <div class="btn bg-light p-2 d-flex flex-row">
                <div class="px-2">
                  <img class="img24" src="resources/images/student.png" />
                </div>
                <div class="px-2">
                  <a href="/signup.aspx?userType=student" class="text-dark">Student</a>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div>
          <div>
            <h1 class="text-light">In the lockdown,</h1>
          </div>
          <div class="px-5">
            <h1 class="text-warning">Lets unlock the Learnings
            </h1>
          </div>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
