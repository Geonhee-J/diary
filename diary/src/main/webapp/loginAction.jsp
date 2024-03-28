<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck_login.jsp"%>

<%
    String memberId = request.getParameter("loginId");
    String memberPw = request.getParameter("loginPw");
    
    // 1. diary_member DB에서 id, pw 확인
    // goodee.diary_member.member_id == memberId -> redirect("/diary/diaryCalendar.jsp");
    // goodee.diary_member.member_id != memberId -> redirect("/diary/loginForm.jsp");
    PreparedStatement memberCheckStmt = null;
    ResultSet memberCheckRs = null;
    
    // diary_member의 id, pw의 값을 불러 올 sql문
    String memberCheckSQL = "SELECT member_id memberId FROM diary_member WHERE member_id = ? AND member_pw = ?";
    
    memberCheckStmt = sessionCheckConn.prepareStatement(memberCheckSQL);
    // login.jsp에서 넘어오는 값 sql문에 넣어줌
    memberCheckStmt.setString(1, memberId);
    memberCheckStmt.setString(2, memberPw);
    memberCheckRs = memberCheckStmt.executeQuery();
    
    // ex)
    // id와 pw가 DB에서 일치한다면 memberCheck -> 일치하는 id
    // id 또는 pw가 DB에서 일치하는게 없다면 memberCheck -> null
    String memberCheck = null;
    
    if (memberCheckRs.next()) {
        // sql문으로 DB에서 불러 온 값을 담아주고, 확인
        memberCheck = memberCheckRs.getString("memberId");
        System.out.println("<loginAction.jsp> memberCheck : " + memberCheck);
    }
    
    PreparedStatement loginUpdateStmt = null;
%>

<%
    // 2. 2번 과정 후 login에서 넘어온 id, DB에서 불러온 memberId를 비교
    if (memberCheck != null && memberCheck.equals(memberId)) {
        // diary_login의 my_session, on_date의 값을 변경
        String sessionUpdateSQL = "UPDATE diary_login SET my_session = 'ON', on_date = now() WHERE my_session = 'OFF'";
        loginUpdateStmt = sessionCheckConn.prepareStatement(sessionUpdateSQL);
        // 결과 확인
        int result = loginUpdateStmt.executeUpdate();
        System.out.println("<loginAction.jsp> result : " + result);
        // DB자원 반납 후 diaryCalendar.jsp로 이동(memberId 값을 포함)
        loginUpdateStmt.close();
        response.sendRedirect("/diary/diaryCalendar.jsp");
    } else {
        // 아니라면 에러메시지를 담아주고, login으로 이동
        String errMsg = URLEncoder.encode("ID, PW를 확인해주세요", "utf-8");
        response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
    }
    
    memberCheckRs.close();
    memberCheckStmt.close();
    sessionCheckRs.close();
    sessionCheckStmt.close();
    sessionCheckConn.close();
%>