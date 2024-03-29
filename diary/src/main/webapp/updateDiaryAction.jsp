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

    String updateDiarySQL =
            "UPDATE diary_content SET feeling = ?, title = ?, weather = ?, content = ?, update_date = now() WHERE diary_date = ?";
    
    PreparedStatement updateDiaryStmt = null;
    updateDiaryStmt = jdbcConn.prepareStatement(updateDiarySQL);
    updateDiaryStmt.setString(1, feeling);
    updateDiaryStmt.setString(2, title);
    updateDiaryStmt.setString(3, weather);
    updateDiaryStmt.setString(4, content);
    updateDiaryStmt.setString(5, diaryDate);
    
    int result = updateDiaryStmt.executeUpdate();
    
    if (result == 0) {
        String errMsg = URLEncoder.encode("일기가 수정되지 못했습니다.", "utf-8");
        response.sendRedirect("/diary/diaryCalendar.jsp?msg=" + errMsg);
    } else {
        response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    }
    
    updateDiaryStmt.close();
    jdbcConn.close();
%>