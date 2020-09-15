<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="onlineQuiz_bsef17m35.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Login</title>
  <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="login.css" />
</head>
<body>
  <form id="loginForm" runat="server">
    <div class="logo d-flex flex-row justify-content-center" id="logo">
      <div>
        <img src="resources/images/logo.png" class="img64" />
      </div>
    </div>
    <div runat="server" class="form card asp-panel p-2" id="realLoginForm">
      <div runat="server" id="loginErrors" class="alert alert-danger" visible="false"></div>

      <div class="form-group">
        <input runat="server" type="email" id="email" class="form-control"
          placeholder="Email Address" />
        <asp:RegularExpressionValidator runat="server" ControlToValidate="email"
          ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
          ErrorMessage="Please enter valid email!" CssClass="text-danger text-muted"></asp:RegularExpressionValidator>
      </div>

      <div class="form-group">
        <input runat="server" type="password" id="password" class="form-control"
          placeholder="Password" />
        <asp:CustomValidator ID="passwordCV" runat="server" ControlToValidate="password"
          OnServerValidate="password_ServerValidate"
          ErrorMessage="Password is required, please use 8 to 16 characters password."
          Visible="false">
        </asp:CustomValidator>
      </div>

      <div class="form-group">
        <button runat="server" class="btn btn-primary" type="button"
          id="loginButton" onserverclick="loginButton_ServerClick">
          Login</button>
      </div>

      <div class="form-group w-75 m-auto">
        Not have an account? <a href="signup.aspx">Signup instead</a>
      </div>
    </div>
  </form>
</body>
</html>
