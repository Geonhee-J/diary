<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
    String feeling = request.getParameter("feeling");
    String title = request.getParameter("title");
    String weather = request.getParameter("weather");
    String content = request.getParameter("content");
%>

<%
    String one = "맑음";
    String two = "흐림";
    String three = "비";
    String four = "눈";
%>

<%
    if (weather != null && !weather.equals("select") && weather.equals("1")) {
        weather = one;
    } else if (weather.equals("2")) {
        weather = two;
    } else if (weather.equals("3")) {
        weather = three;
    } else if (weather.equals("4")) {
        weather = four;
    } else {
        String errMsg = URLEncoder.encode("날씨를 선택해주세요.", "utf-8");
        response.sendRedirect("/diary/addDiaryForm.jsp?errMsg="+errMsg);
        return;
    }
    
    String addDiarySQL = 
        "INSERT INTO diary_content(diary_date, feeling, title, weather, content, update_date, create_date) VALUES (?, ?, ?, ?, ?, now(), now())";
    
    PreparedStatement addDiaryStmt = null;
    addDiaryStmt = jdbcConn.prepareStatement(addDiarySQL);
    addDiaryStmt.setString(1, diaryDate);
    addDiaryStmt.setString(2, feeling);
    addDiaryStmt.setString(3, title);
    addDiaryStmt.setString(4, weather);
    addDiaryStmt.setString(5, content);
    
    int result = addDiaryStmt.executeUpdate();
    
    if (result == 0) {
        String errMsg = URLEncoder.encode("일기가 저장되지 못했습니다.", "utf-8");
        response.sendRedirect("/diary/addDiaryForm.jsp");
    } else {
        response.sendRedirect("/diary/diaryCalendar.jsp");
    }
    
    addDiaryStmt.close();
    jdbcConn.close();
%>