<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.jsp"%>

<%
    // diaryCalendar에서 전달되는 값 담기
    String checkDate = request.getParameter("checkDate");
    System.out.println("<checkDateAction.jsp> checkDate : " + checkDate);
    
    PreparedStatement checkDateStmt = null;
    ResultSet checkDateRs = null;
    
    // diary_content의 diary_date 값을 불러 올 sql문
    String checkDateSQL = "SELECT diary_date FROM diary_content WHERE diary_date = ?";
    
    checkDateStmt = sessionCheckConn.prepareStatement(checkDateSQL);
    checkDateStmt.setString(1, checkDate);
    checkDateRs = checkDateStmt.executeQuery();
    
    if (checkDateRs.next()) {
        System.out.println("<checkDateAction.jsp> no : " + checkDate);
        response.sendRedirect("/diary/addDiaryForm.jsp?checkDate=" + checkDate + "&ck=F");
    } else {
        System.out.println("<checkDateAction.jsp> yes : " + checkDate);
        response.sendRedirect("/diary/addDiaryForm.jsp?checkDate=" + checkDate + "&ck=T");
    }
    
    checkDateRs.close();
    checkDateStmt.close();
    sessionCheckRs.close();
    sessionCheckStmt.close();
    sessionCheckConn.close();
%>
