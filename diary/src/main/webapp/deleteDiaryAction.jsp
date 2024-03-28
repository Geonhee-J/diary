<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.jsp"%>

<%
    // diaryOne에서 전달되는 값 담기
    String diaryDate = request.getParameter("diaryDate");
    // System.out.println("<addDiaryAction.jsp> diaryDate : " + diaryDate);
%>

<%
    String deleteDiarySQL = "DELETE FROM diary_content WHERE diary_date = ?";
    
    PreparedStatement deleteDiaryStmt = null;
    deleteDiaryStmt = sessionCheckConn.prepareStatement(deleteDiarySQL);
    deleteDiaryStmt.setString(1, diaryDate);
    
    int result = deleteDiaryStmt.executeUpdate();
    
    if (result == 0) {
        String errMsg = URLEncoder.encode("일기가 삭제되지 못했습니다.", "utf-8");
        response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    } else {
        response.sendRedirect("/diary/diaryCalendar.jsp");
    }
    
    deleteDiaryStmt.close();
    sessionCheckRs.close();
    sessionCheckStmt.close();
    sessionCheckConn.close();
%>