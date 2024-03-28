<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
    // JDBC 사용, 연결
    Class.forName("org.mariadb.jdbc.Driver");
    Connection logoutActionConn = null;
    logoutActionConn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/goodee", "root", "dreamon");
%>

<%
    // diaryCalendar에서 전달되는 값 담기
    String logout = request.getParameter("logout");
    System.out.println("logout t/f? : " + logout);
    
    PreparedStatement logoutUpdateStmt = null;
    
    // 2. 1번 과정 후 diary_login에서 넘어온 id, DB에서 불러온 memberId를 비교
    if (logout.equals("true")) {
        // diary_login의 my_session, off_date의 값을 변경
        String sessionUpdateSQL = "UPDATE diary_login SET my_session = 'OFF', off_date = now() WHERE my_session = 'ON'";
        logoutUpdateStmt = logoutActionConn.prepareStatement(sessionUpdateSQL);
        // 결과 확인
        int result = logoutUpdateStmt.executeUpdate();
        System.out.println("<logoutAction.jsp> result : " + result);
    }
    
    logoutUpdateStmt.close();
    logoutActionConn.close();
    
    response.sendRedirect("/diary/loginForm.jsp");
%>
