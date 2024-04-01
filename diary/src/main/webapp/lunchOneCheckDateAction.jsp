<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>

<%
    String checkDate = request.getParameter("checkDate");
    // System.out.println("<checkDateAction.jsp> checkDate : " + checkDate);
    
    PreparedStatement checkDateStmt = null;
    ResultSet checkDateRs = null;
    
    String checkDateSQL = "SELECT lunch_date, menu FROM diary_lunch WHERE lunch_date = ?";
    
    checkDateStmt = jdbcConn.prepareStatement(checkDateSQL);
    checkDateStmt.setString(1, checkDate);
    checkDateRs = checkDateStmt.executeQuery();
    
    if (checkDateRs.next()) {
        String menu = URLEncoder.encode(checkDateRs.getString("menu"), "utf-8");
        // System.out.println("<checkDateAction.jsp> no : " + checkDate);
        response.sendRedirect("/diary/lunchOne.jsp?checkDate=" + checkDate + "&menu=" + menu + "&ck=F");
    } else {
        // System.out.println("<checkDateAction.jsp> yes : " + checkDate);
        response.sendRedirect("/diary/lunchOne.jsp?checkDate=" + checkDate + "&ck=T");
    }
    
    checkDateRs.close();
    checkDateStmt.close();
    jdbcConn.close();
%>
