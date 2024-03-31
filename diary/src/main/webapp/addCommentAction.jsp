<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
    String memo = request.getParameter("memo");
%>

<%
    String addCommentSQL = 
        "INSERT INTO diary_comment(diary_date, memo, update_date, create_date) VALUES (?, ?, now(), now())";
    
    PreparedStatement addCommentStmt = null;
    addCommentStmt = jdbcConn.prepareStatement(addCommentSQL);
    addCommentStmt.setString(1, diaryDate);
    addCommentStmt.setString(2, memo);
    
    int result = addCommentStmt.executeUpdate();
    
    if (result == 0) {
        String errMsg = URLEncoder.encode("메모가 저장되지 못했습니다.", "utf-8");
        response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    } else {
        response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    }
    
    addCommentStmt.close();
    jdbcConn.close();
%>