<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%
    String loginMember = (String)(session.getAttribute("loginMember"));
    if (loginMember != null) {
        response.sendRedirect("/diary/diaryCalendar.jsp");
        return;
    }
%>