<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="onlineQuiz_bsef17m35.profile.profile" %>

<%@ MasterType VirtualPath="~/dashboard.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="dashboardHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="dashboardPlaceHolder" runat="server">
  <div class="p-2">
    <div runat="server" id="profileLoadError" class="p-2 alert alert-danger"
      visible="false">
      Something went wrong! We are sorry, but we are unable to load your 
        profile at the moment.
    </div>

    <div runat="server" id="profileUpdated" class="p-2 alert alert-success"
      visible="false">
      Your profile has been successfully updated!
    </div>

    <div runat="server" id="accountDeleteError" class="p-2 alert alert-success"
      visible="false">
      Something went wrong! We are sorry, but we are unable to delete your 
        account at the moment.
    </div>

    <div runat="server" id="DeleteAccountModel" class="p-4" visible="false">
      <div class="p-2 alert alert-warning">
        <div>
          You are about delete your account. This can be dangerous as this would delete:
        </div>
        <div class="p-1">
          <ul>
            <li>Your account</li>
            <li>All quizzes added by you</li>
            <li>All submissions to your every quiz</li>
          </ul>
        </div>
      </div>

      <div class="d-flex alert alert-success flex-row flex-wrap align-items-center">
        <div class="alert alert-success flex-grow-1">No, Get me out of here!</div>
        <div class="alert alert-success">
          <a href="profile.aspx" class="btn btn-success">Go Back</a>
        </div>
      </div>

      <div class="alert alert-danger d-flex flex-row flex-wrap">
        <div class="alert alert-danger flex-grow-1">Yes, I understand!</div>
        <div class="alert alert-danger">
          <asp:Button runat="server" ID="ReallyDeleteAccount" CssClass="btn btn-danger"
            Text="Delete Account" OnClick="ReallyDeleteAccount_Click"/>
        </div>
      </div>
    </div>

    <div runat="server" id="profileView">
      <!-- FULL NAME -->
      <div class="p-2 d-flex flex-row justify-content-center">
        <div class="border border-danger" style="width: 96px; height: 120px;">
          <img runat="server" id="profilePicture" alt="Profile Picture" class="hov-opacity-half"
            style="width: 100%; height: 100%" src="/resources/images/logo.png"/>
        </div>
      </div>

      <div class="p-2 container field mb-1 bg-light">
        <div class="row">
          <div class="col-sm-12 col-md-2">
            <b>Full Name</b>
          </div>

          <div class="col-sm-12 col-md-2">
            <span runat="server" id="fullName"></span>
          </div>
        </div>
      </div>

      <div class="p-2 container field mb-1 bg-light">
        <div class="row">
          <div class="col-sm-12 col-md-2">
            <b>Gender</b>
          </div>

          <div class="col-sm-12 col-md-2">
            <span runat="server" id="gender"></span>
          </div>
        </div>
      </div>

      <!-- Email Address -->
      <div class="p-2 container field  mb-1 bg-light">
        <div class="row">
          <div class="col-sm-12 col-md-2">
            <b>Email Address</b>
          </div>

          <div class="col-sm-12 col-md-2">
            <span runat="server" id="email"></span>
          </div>
        </div>
      </div>

      <!-- Country -->
      <div class="p-2 container field  mb-1 bg-light">
        <div class="row">
          <div class="col-sm-12 col-md-2">
            <b>Country</b>
          </div>

          <div class="col-sm-12 col-md-2">
            <span runat="server" id="country"></span>
          </div>
        </div>
      </div>

      <!-- Country -->
      <div class="p-2 container field  mb-1 bg-light">
        <div class="row">
          <div class="col-sm-12 col-md-2">
            <b>City</b>
          </div>

          <div class="col-sm-12 col-md-2">
            <span runat="server" id="city"></span>
          </div>
        </div>
      </div>

      <!-- Country -->
      <div runat="server" class="p-2 container field  mb-1 bg-light" id="specialityDetails">
        <div class="row">
          <div class="col-sm-12 col-md-2">
            <b>Speciality</b>
          </div>

          <div class="col-sm-12 col-md-2">
            <span runat="server" id="speciality"></span>
          </div>
        </div>
      </div>

      <div class="d-flex flex-row-reverse p-2">
        <div id="deleteLink" class="mr-1">
          <a runat="server" id="DeleteProfileLink" class="btn btn-danger"
            onserverclick="DeleteProfileLink_ServerClick">Delete Account</a>
        </div>

        <div id="editLink" class="mr-1">
          <a runat="server" id="editProfileLink" class="btn btn-light"
            href="/signup.aspx?userId=">Edit Profile</a>
        </div>
      </div>
    </div>
  </div>

  <script>
    $(".sidebar > .btn").addClass("text-primary");
    $("[id$=openProfile]").addClass("text-dark");
  </script>
</asp:Content>
