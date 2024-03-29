<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
%>

<%
    String deleteDiarySQL = "DELETE FROM diary_content WHERE diary_date = ?";
    
    PreparedStatement deleteDiaryStmt = null;
    deleteDiaryStmt = jdbcConn.prepareStatement(deleteDiarySQL);
    deleteDiaryStmt.setString(1, diaryDate);
    
    int result = deleteDiaryStmt.executeUpdate();
    
    if (result == 0) {
        String errMsg = URLEncoder.encode("일기가 삭제되지 못했습니다.", "utf-8");
        response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    } else {
        response.sendRedirect("/diary/diaryCalendar.jsp");
    }
    
    deleteDiaryStmt.close();
    jdbcConn.close();
%>