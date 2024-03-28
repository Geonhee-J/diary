<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
    // JDBC 사용, 연결
    Class.forName("org.mariadb.jdbc.Driver");
    Connection sessionCheckConn = null;
    sessionCheckConn =
        DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/goodee", "root", "dreamon");
%>

<%
    PreparedStatement sessionCheckStmt = null;
    ResultSet sessionCheckRs = null;
    
    // my_session의 on/off 값을 불러 올 sql문 
    String sessionCheckSQL = "SELECT my_session FROM diary_login";
    
    sessionCheckStmt = sessionCheckConn.prepareStatement(sessionCheckSQL);
    sessionCheckRs = sessionCheckStmt.executeQuery();
    
    String sessionCheck = null; // my_session의 on/off 값을 담을 변수
    
    if (sessionCheckRs.next()) {
        // sql문으로 DB에서 불러 온 값을 담아주고, 확인
        sessionCheck = sessionCheckRs.getString("my_session");
        System.out.println("<sessionCheck.jsp> sessionCheck : " + sessionCheck);
    }
    
    if (sessionCheck.equals("OFF")) {
        // 아니라면 에러메시지를 담아주고, login으로 이동
        String errMsg = URLEncoder.encode("잘못된 접근입니다.", "utf-8");
        response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg);
        return;
    }
%>