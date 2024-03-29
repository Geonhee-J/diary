<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%
    PreparedStatement logoutUpdateStmt = null;
    String sessionUpdateSQL = "INSERT INTO diary_login(my_session, off_date) VALUES ('OFF', now());";
    logoutUpdateStmt = jdbcConn.prepareStatement(sessionUpdateSQL);
    int result = logoutUpdateStmt.executeUpdate();
    session.invalidate(); // 세션 초기화
    response.sendRedirect("/diary/loginForm.jsp");
%>