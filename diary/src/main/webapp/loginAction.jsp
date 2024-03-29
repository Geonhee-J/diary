<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/login.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%
    String loginId = request.getParameter("loginId");
    String loginPw = request.getParameter("loginPw");
    
    // 1. diary_member DB에서 id, pw 확인
    PreparedStatement memberCheckStmt = null;
    ResultSet memberCheckRs = null;
    
    String memberCheckSQL = "SELECT member_id memberId FROM diary_member WHERE member_id = ? AND member_pw = ?";
    
    memberCheckStmt = jdbcConn.prepareStatement(memberCheckSQL);
    memberCheckStmt.setString(1, loginId);
    memberCheckStmt.setString(2, loginPw);
    memberCheckRs = memberCheckStmt.executeQuery();
    
    String memberCheck = null;
    
    if (memberCheckRs.next()) {
        memberCheck = memberCheckRs.getString("memberId");
        session.setAttribute("loginMember", memberCheck);
        System.out.println("<loginAction.jsp> memberCheck : " + memberCheck);
    }
    
%>

<%
    PreparedStatement loginUpdateStmt = null;

    // 2. 1번 과정 후 loginForm에서 넘어온 loginId, DB에서 불러온 memberId를 비교
    if (memberCheck != null && memberCheck.equals(loginId)) {
        String sessionUpdateSQL = "INSERT INTO diary_login(my_session, on_date) VALUES ('ON', now());";
        loginUpdateStmt = jdbcConn.prepareStatement(sessionUpdateSQL);
        int result = loginUpdateStmt.executeUpdate();
        System.out.println("<loginAction.jsp> result : " + result);
        response.sendRedirect("/diary/diaryCalendar.jsp");
    } else {
        String errMsg = URLEncoder.encode("ID, PW를 확인해주세요", "utf-8");
        response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
    }
    
    memberCheckRs.close();
    memberCheckStmt.close();
    loginUpdateStmt.close();
    jdbcConn.close();
%>