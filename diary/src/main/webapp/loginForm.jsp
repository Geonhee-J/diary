<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/login.jsp"%>
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
        <div class="login-container">
            <div class="meesage-wrap">
                <%
                    if (errMsg != null) {
                %>
                        <div class="message-content"><%=errMsg%></div>
                <%
                    } else {
                %>
                        <div class="message-content">나 혼자만 일기장</div>
                <%
                    }
                %>
            </div>
            <div class="login-input-wrap">
                <form method="post" action="/diary/loginAction.jsp">
                    <div class="login-input">
                        <input type="text" name="loginId" placeholder="계정">
                    </div>
                    <div class="login-input">
                        <input type="password" name="loginPw" placeholder="암호">
                    </div>
                    <div class="login-input">
                        <button type="submit">접속</button>
                    </div>
                </form>
            </div>
            <div class="sign-up-wrap">
                <div class="sign-up-message">
                    <span>계정이 없으신가요?</span>
                </div>
                <div class="sing-up-new">
                    <span>새로 만들기</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>