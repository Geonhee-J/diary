<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
    String commentNo = request.getParameter("commentNo");
%>

<%
    String deleteCommentSQL = "DELETE FROM diary_comment WHERE diary_date = ? AND comment_no = ?";
    
    PreparedStatement deleteCommentStmt = null;
    deleteCommentStmt = jdbcConn.prepareStatement(deleteCommentSQL);
    deleteCommentStmt.setString(1, diaryDate);
    deleteCommentStmt.setString(2, commentNo);
    
    int result = deleteCommentStmt.executeUpdate();
    
    if (result == 0) {
        String errMsg = URLEncoder.encode("댓글이 삭제되지 못했습니다.", "utf-8");
        response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    } else {
        response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    }
    
    deleteCommentStmt.close();
    jdbcConn.close();
%>