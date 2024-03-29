<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%
    String loginMember = (String)(session.getAttribute("loginMember"));
    if (loginMember == null) {
        String errMsg = URLEncoder.encode("잘못된 접근입니다.", "utf-8");
        response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg);
        return;
    }
%>