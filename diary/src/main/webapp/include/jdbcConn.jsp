<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    // JDBC 사용, 연결
    Class.forName("org.mariadb.jdbc.Driver");
    Connection jdbcConn = null;
    jdbcConn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/goodee", "root", "dreamon");
%>