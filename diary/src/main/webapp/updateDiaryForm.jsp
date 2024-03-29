<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
    
    PreparedStatement diaryOneStmt = null;
    ResultSet diaryOneRs = null;
    
    String diarySelectSQL =
            "SELECT diary_date, feeling, title, weather, content, update_date, create_date FROM diary_content WHERE diary_date = ?";
    
    diaryOneStmt = jdbcConn.prepareStatement(diarySelectSQL);
    diaryOneStmt.setString(1, diaryDate);
    diaryOneRs = diaryOneStmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/updateDiaryForm.css">
</head>
<body>
    <div class="container">
        <div class="updateDiaryBox">
            <div class="checkDateInputBox">
                <div class="messageBox">
                    <div class="message">일기 수정</div>
                </div>
            </div>
            <div>
                <form method="get" action="/diary/updateDiaryAction.jsp">
                    <%
                        if (diaryOneRs.next()) {
                            String feeling = diaryOneRs.getString("feeling");
                            System.out.println("feeling : " + feeling);
                            String title = diaryOneRs.getString("title");
                            String weather = diaryOneRs.getString("weather");
                            String content = diaryOneRs.getString("content");
                    %>
                            <div class="updateDiaryInput">
                                <input type="text" name="diaryDate" value="<%=diaryDate%>" readonly="readonly">
                            </div>
                            <div class="updateDiaryInputMood">
                                <div class="moodBox">
                                    <%
                                        if (feeling.equals("&#128525;") || feeling.equals("😍")) {
                                    %>
                                                <div class="mood">
                                                    <label for="1">&#128525;</label>
                                                    <input type="radio" name="feeling" id="1" value="&#128525;" checked="checked">
                                                </div>
                                                <div class="mood">
                                                    <label for="2">&#128515;</label>
                                                    <input type="radio" name="feeling" id="2" value="&#128515;">
                                                </div>
                                                <div class="mood">
                                                    <label for="3">&#128528;</label>
                                                    <input type="radio" name="feeling" id="3" value="&#128528;">
                                                </div>
                                                <div class="mood">
                                                    <label for="4">&#128557;</label>
                                                    <input type="radio" name="feeling" id="4" value="&#128557;">
                                                </div>
                                                <div class="mood">
                                                    <label for="5">&#128545;</label>
                                                    <input type="radio" name="feeling" id="5" value="&#128545;">
                                                </div>
                                    <%
                                        } else if (feeling.equals("&#128515;") || feeling.equals("😃")) {
                                    %>
                                                <div class="mood">
                                                    <label for="1">&#128525;</label>
                                                    <input type="radio" name="feeling" id="1" value="&#128525;">
                                                </div>
                                                <div class="mood">
                                                    <label for="2">&#128515;</label>
                                                    <input type="radio" name="feeling" id="2" value="&#128515;" checked="checked">
                                                </div>
                                                <div class="mood">
                                                    <label for="3">&#128528;</label>
                                                    <input type="radio" name="feeling" id="3" value="&#128528;">
                                                </div>
                                                <div class="mood">
                                                    <label for="4">&#128557;</label>
                                                    <input type="radio" name="feeling" id="4" value="&#128557;">
                                                </div>
                                                <div class="mood">
                                                    <label for="5">&#128545;</label>
                                                    <input type="radio" name="feeling" id="5" value="&#128545;">
                                                </div>
                                    <%
                                        } else if (feeling.equals("&#128528;") || feeling.equals("😐")) {
                                    %>
                                                <div class="mood">
                                                    <label for="1">&#128525;</label>
                                                    <input type="radio" name="feeling" id="1" value="&#128525;">
                                                </div>
                                                <div class="mood">
                                                    <label for="2">&#128515;</label>
                                                    <input type="radio" name="feeling" id="2" value="&#128515;">
                                                </div>
                                                <div class="mood">
                                                    <label for="3">&#128528;</label>
                                                    <input type="radio" name="feeling" id="3" value="&#128528;" checked="checked">
                                                </div>
                                                <div class="mood">
                                                    <label for="4">&#128557;</label>
                                                    <input type="radio" name="feeling" id="4" value="&#128557;">
                                                </div>
                                                <div class="mood">
                                                    <label for="5">&#128545;</label>
                                                    <input type="radio" name="feeling" id="5" value="&#128545;">
                                                </div>
                                    <%
                                        } else if (feeling.equals("&#128557;") || feeling.equals("😭")) {
                                    %>
                                                <div class="mood">
                                                    <label for="1">&#128525;</label>
                                                    <input type="radio" name="feeling" id="1" value="&#128525;">
                                                </div>
                                                <div class="mood">
                                                    <label for="2">&#128515;</label>
                                                    <input type="radio" name="feeling" id="2" value="&#128515;">
                                                </div>
                                                <div class="mood">
                                                    <label for="3">&#128528;</label>
                                                    <input type="radio" name="feeling" id="3" value="&#128528;">
                                                </div>
                                                <div class="mood">
                                                    <label for="4">&#128557;</label>
                                                    <input type="radio" name="feeling" id="4" value="&#128557;" checked="checked">
                                                </div>
                                                <div class="mood">
                                                    <label for="5">&#128545;</label>
                                                    <input type="radio" name="feeling" id="5" value="&#128545;">
                                                </div>
                                    <%
                                        } else if (feeling.equals("&#128545;") || feeling.equals("😡")) {
                                    %>
                                                <div class="mood">
                                                    <label for="1">&#128525;</label>
                                                    <input type="radio" name="feeling" id="1" value="&#128525;">
                                                </div>
                                                <div class="mood">
                                                    <label for="2">&#128515;</label>
                                                    <input type="radio" name="feeling" id="2" value="&#128515;">
                                                </div>
                                                <div class="mood">
                                                    <label for="3">&#128528;</label>
                                                    <input type="radio" name="feeling" id="3" value="&#128528;">
                                                </div>
                                                <div class="mood">
                                                    <label for="4">&#128557;</label>
                                                    <input type="radio" name="feeling" id="4" value="&#128557;">
                                                </div>
                                                <div class="mood">
                                                    <label for="5">&#128545;</label>
                                                    <input type="radio" name="feeling" id="5" value="&#128545;" checked="checked">
                                                </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="updateDiaryInput">
                                <input type="text" name="title" placeholder="TITLE" value="<%=title%>">
                            </div>
                            <div class="updateDiaryInput">
                                <select name="weather">
                                    <%
                                        if (weather.equals("맑음")) {
                                    %>
                                            <option value="select">Select a weather</option>
                                            <option value="1" selected>맑음</option>
                                            <option value="2">흐림</option>
                                            <option value="3">비</option>
                                            <option value="4">눈</option>
                                    <%
                                        } else if (weather.equals("흐림")) {
                                    %>
                                            <option value="select">Select a weather</option>
                                            <option value="1">맑음</option>
                                            <option value="2" selected>흐림</option>
                                            <option value="3">비</option>
                                            <option value="4">눈</option>
                                    <%
                                        } else if (weather.equals("비")) {
                                    %>
                                            <option value="select">Select a weather</option>
                                            <option value="1">맑음</option>
                                            <option value="2">흐림</option>
                                            <option value="3" selected>비</option>
                                            <option value="4">눈</option>
                                    <%
                                        } else if (weather.equals("눈")) {
                                    %>
                                            <option value="select">Select a weather</option>
                                            <option value="1">맑음</option>
                                            <option value="2">흐림</option>
                                            <option value="3">비</option>
                                            <option value="4" selected>눈</option>
                                    <%
                                        } else {
                                    %>
                                            <option value="select">Select a weather</option>
                                            <option value="1">맑음</option>
                                            <option value="2">흐림</option>
                                            <option value="3">비</option>
                                            <option value="4">눈</option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="updateDiaryInput">
                                <textarea rows="5" cols="20" name="content" placeholder="WRITING A DIARY"><%=content%></textarea>
                            </div>
                    <%
                        }
                    %>
                    <div class="updateDiaryInput">
                        <button type="submit">수정</button>
                    </div>
                </form>
                <form method="post" action="/diary/diaryCalendar.jsp">
                    <div class="prevBtn">
                        <button type="submit">이전</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

<%
    // DB자원 반납
    diaryOneRs.close();
    diaryOneStmt.close();
    jdbcConn.close();
%>