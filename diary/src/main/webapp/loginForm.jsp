<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck_login.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String errMsg = request.getParameter("errMsg");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/loginForm.css">
</head>
<body>
    <div class="container">
        <div class="loginBox">
            <div class="messageBox">
                <%
                    if (errMsg != null) {
                %>
                        <div class="message"><%=errMsg%></div>
                <%
                    } else {
                %>
                        <div class="message">My Diary</div>
                <%
                    }
                %>
            </div>
            <div class="loginInputBox">
                <form method="post" action="/diary/loginAction.jsp">
                    <div class="loginInput">
                        <input type="text" name="loginId" placeholder="ID">
                    </div>
                    <div class="loginInput">
                        <input type="password" name="loginPw" placeholder="PASSWORD">
                    </div>
                    <div class="loginInput">
                        <button type="submit">Sign in</button>
                    </div>
                </form>
            </div>
            <div class="signUpBox">
                <div class="signUpMessage">
                    <span>Don't have an account?</span>
                </div>
                <div class="signUpNew">
                    <span>Sign Up new</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>