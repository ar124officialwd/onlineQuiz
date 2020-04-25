<%@ Page Title="" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="onlineQuiz_bsef17m35.signUp" %>

<asp:Content runat="server" ContentPlaceHolderID="indexHead">
  <link rel="stylesheet" type="text/css" href="signup.css"/>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
  <div class="container signup-form">
    <div class="d-flex flex-row align-items-center justify-content-around">
      <h3 id="signupLabel" runat="server">Sign Up</h3>
      <a runat="server" href="/login.aspx" id="gotoLogin">Login</a>
    </div>

    <div runat="server" id="signupErrors" class="alert alert-danger" visible="false"></div>
    <div runat="server" id="signupMessages" class="alert alert-primary" visible="false"></div>

    <div runat="server" id="SignupForm">
      <div class="d-flex flex-row-reverse flex-wrap align-items-center justify-content-around my-2 asp-panel">
        <div class="d-flex flex-column asp-panel">
          <div class="border border-danger mb-1" style="width: 96px; height: 120px; position: relative;">
            <img runat="server" src="/resources/images/profile_pictures/default/teacher_male.png" id="profilePicture"
              style="position: relative; width: 100%; height: 100%" class="hov-opacity-half"/>
            <asp:FileUpload runat="server" ID="profilePictureFileUpload" Visible="true"
              data-deleted="true"/>
            <input type="hidden" runat="server" id="isProfilePictureSet" style="display: none"
               value="false"/>
          </div>

          <div class="d-flex flex-row align-items-center justify-content-center border border-danger p-1">
            <span class="btn btn-light mr-1" id="profilePictureChange">
              <i class="far fa-edit"></i>
            </span>

            <button runat="server" class="btn btn-danger" id="profilePictureDelete"
              onserverclick="profilePictureDelete_ServerClick" causesvalidation="false">
              <i class="fas fa-trash-alt"></i>
            </button>
          </div>
        </div>

        <div class="d-flex flex-column">
          <div class="form-group">
            <asp:Label runat="server" Text="">User Role</asp:Label><br />
            <div class="form-control">
              <asp:RadioButton runat="server" GroupName="role" Text="Teacher" Checked="true"
                OnCheckedChanged="onRoleChanged" ID="teacher" AutoPostBack="true" />
              <asp:RadioButton runat="server" GroupName="role" Text="Student" CssClass="ml-2"
                OnCheckedChanged="onRoleChanged" ID="student" AutoPostBack="true" />
            </div>
          </div>

          <div class="form-group">
            <asp:Label runat="server" Text="">Gender</asp:Label><br />
            <div class="form-control">
              <asp:RadioButton runat="server" GroupName="gender" Text="Male" Checked="true"
                OnCheckedChanged="onGenderChange" ID="male" AutoPostBack="true" />
              <asp:RadioButton runat="server" GroupName="gender" Text="Female" CssClass="ml-2"
                OnCheckedChanged="onGenderChange" ID="female" AutoPostBack="true" />
              <asp:RadioButton runat="server" GroupName="gender" Text="Unspecified" CssClass="ml-2"
                OnCheckedChanged="onRoleChanged" ID="unspecified" AutoPostBack="true" />
            </div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="">First Name</asp:Label><br />
        <asp:TextBox runat="server" CssClass="form-control" ID="firstName"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="firstName"
          ErrorMessage="First name is required!" CssClass="text-danger text-muted">
        </asp:RequiredFieldValidator>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="">Second Name</asp:Label><br />
        <asp:TextBox runat="server" CssClass="form-control" ID="secondName"></asp:TextBox>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="">Email Address</asp:Label><br />
        <asp:TextBox runat="server" CssClass="form-control" ID="email"></asp:TextBox>
        <asp:RegularExpressionValidator runat="server" ControlToValidate="email"
          ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
          ErrorMessage="Please enter a valid email address!"></asp:RegularExpressionValidator>
      </div>

      <div class="form-group" runat="server" id="oldPasswordFG" visible="false">
        <asp:Label runat="server" Text="Old Password"></asp:Label><br />
        <input runat="server" type="password" id="oldPassword" class="form-control"
          maxlength="16" />
        <asp:CustomValidator runat="server" ControlToValidate="oldPassword"
          OnServerValidate="password_ServerValidate" Enabled="false" ID="oldPasswordRFV"
          ErrorMessage="Password is required, please use 8 to 16 characters password.">
        </asp:CustomValidator>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="Password"></asp:Label><br />
        <input runat="server" type="password" id="password" class="form-control"
          maxlength="16" />
        <asp:CustomValidator runat="server" ControlToValidate="password"
          OnServerValidate="password_ServerValidate"
          ErrorMessage="Password is required, please use 8 to 16 characters password.">
        </asp:CustomValidator>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="Password Again"></asp:Label><br />
        <input type="password" runat="server" class="form-control" id="passwordAgain" />
        <asp:CompareValidator ControlToValidate="passwordAgain" ControlToCompare="password"
          ErrorMessage="Password do not match, please check both passwords!"
          runat="server">
        </asp:CompareValidator>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="">Country</asp:Label><br />
        <asp:DropDownList runat="server" CssClass="form-control" ID="country">
          <asp:ListItem Value="0" Text="Please select a country"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="country"
          InitialValue="0" ErrorMessage="Country is required!"
          CssClass="text-danger text-muted">
        </asp:RequiredFieldValidator>
      </div>

      <div class="form-group">
        <asp:Label runat="server" Text="">City Name</asp:Label><br />
        <asp:TextBox runat="server" CssClass="form-control" ID="city"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="city"
          ErrorMessage="City Name is required!" CssClass="text-danger text-muted">
        </asp:RequiredFieldValidator>
      </div>

      <div runat="server" class="form-group" id="specialityInputGroup">
        <asp:Label runat="server" Text="">Speciality</asp:Label><br />
        <asp:TextBox runat="server" CssClass="form-control" ID="speciality"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="speciality" ID="specialityRFV"
          ErrorMessage="Speciality is required! e.g: Computer Science" CssClass="text-danger text-muted">
        </asp:RequiredFieldValidator>
      </div>

      <div class="form-group">
        <asp:Button runat="server" ID="signupSubmit" Text="Sign Up"
          OnClick="signUpSubmit_ServerClick" class="btn btn-primary"/>
      </div>
    </div>
  </div>

  <script>
    let oldProfilePictureSrc = null;

    $(document).ready(() => {
      oldProfilePictureSrc = $("[id$=profilePicture]").first().attr("src");
      $("[id$=profilePictureFileUpload]").addClass("d-none");

      $("[id$=profilePicture], #profilePictureChange").click(() => {
        $("[id$=profilePictureFileUpload]").click();
      });

      $("[id$=profilePictureFileUpload]").change(() => {
        var reader = new FileReader();
        reader.onload = () => {
          $("[id$=profilePicture]").attr("src", reader.result);
        }

        var file = $("[id$=profilePictureFileUpload]")[0].files[0];
        if (file) {
          reader.readAsDataURL(file);
          $("[id$=isProfilePictureSet]").val("true");
        }
      });
    });
  </script>
</asp:Content>
