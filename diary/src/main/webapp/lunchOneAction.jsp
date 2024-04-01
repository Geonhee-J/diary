<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
    String menu = request.getParameter("menu");
%>

<%
    String addDiarySQL = "INSERT INTO diary_lunch(lunch_date, menu, update_date, create_date) VALUES (?, ?, now(), now())";
    
    PreparedStatement addDiaryStmt = null;
    addDiaryStmt = jdbcConn.prepareStatement(addDiarySQL);
    addDiaryStmt.setString(1, diaryDate);
    addDiaryStmt.setString(2, menu);
    
    int result = addDiaryStmt.executeUpdate();
    
    if (result == 0) {
        String errMsg = URLEncoder.encode("메뉴가 저장되지 못했습니다.", "utf-8");
        response.sendRedirect("/diary/lunchOne.jsp?checkDate=" + diaryDate + "&errMsg=" + errMsg);
    } else {
        response.sendRedirect("/diary/diaryCalendar.jsp");
    }
    
    addDiaryStmt.close();
    jdbcConn.close();
%>