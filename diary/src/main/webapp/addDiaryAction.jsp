<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.jsp"%>

<%
    // addDiaryForm에서 전달되는 값 담기
    String diaryDate = request.getParameter("diaryDate");
    String feeling = request.getParameter("feeling");
    String title = request.getParameter("title");
    String weather = request.getParameter("weather");
    String content = request.getParameter("content");
    // System.out.println("<addDiaryAction.jsp> diaryDate : " + diaryDate);
    // System.out.println("<addDiaryAction.jsp> feeling : " + feeling);
    // System.out.println("<addDiaryAction.jsp> title : " + title);
    // System.out.println("<addDiaryAction.jsp> weather : " + weather);
    // System.out.println("<addDiaryAction.jsp> content : " + content);
%>

<%
    // 날씨의 값에 따른 분기문
    if (weather != null && !weather.equals("select") && weather.equals("1")) {
        weather = "맑음";
    } else if (weather.equals("2")) {
        weather = "흐림";
    } else if (weather.equals("3")) {
        weather = "비";
    } else if (weather.equals("4")) {
        weather = "눈";
    } else {
        String errMsg = URLEncoder.encode("날씨를 선택해주세요.", "utf-8");
        response.sendRedirect("/diary/addDiaryForm.jsp?errMsg="+errMsg);
        return;
    }
    // System.out.println("<addDiaryAction.jsp> weather : " + weather);
    
    // diary_content에 값을 저장 할 sql문
    String addDiarySQL = 
        "INSERT INTO diary_content(diary_date, feeling, title, weather, content, update_date, create_date) VALUES (?, ?, ?, ?, ?, now(), now())";
    
    PreparedStatement addDiaryStmt = null;
    addDiaryStmt = sessionCheckConn.prepareStatement(addDiarySQL);
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
    sessionCheckRs.close();
    sessionCheckStmt.close();
    sessionCheckConn.close();
%>