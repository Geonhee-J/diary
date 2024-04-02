<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
    
    PreparedStatement diaryOneStmt = null;
    ResultSet diaryOneRs = null;
    
    String diaryOneSQL = "SELECT diary_date, feeling, title, weather, content, update_date, create_date FROM diary_content WHERE diary_date = ?";
    
    diaryOneStmt = jdbcConn.prepareStatement(diaryOneSQL);
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
    <header>
        <div class="header-calendar">
            <div class="calendar-yymm">
                <%=tYear%>년
                <%=tMonth + 1%>월
                <%=tDay%>일
            </div>
        </div>
        <div class="header-btn">
            <form method="post" action="/diary/addDiaryForm.jsp">
                <button class="common-btn" type="submit">일기쓰기</button>
            </form>
            <div class="header-btn-column"></div>
            <form method="post" action="/diary/diaryCalendar.jsp">
                <button class="common-btn" type="submit">달력으로보기</button>
            </form>
            <div class="header-btn-column"></div>
            <form method="post" action="/diary/diaryList.jsp">
                <button class="common-btn" type="submit">리스트로보기</button>
            </form>
            <div class="header-btn-column"></div>
            <form method="post" action="/diary/lunchOne.jsp">
                <button class="common-btn" type="submit">점심메뉴선택</button>
            </form>
            <div class="header-btn-column"></div>
            <form method="post" action="/diary/statsLunch.jsp?year=<%=tYear%>&month=<%=tMonth%>">
                <button class="common-btn" type="submit">점심메뉴보기</button>
            </form>
            <div class="header-btn-column"></div>
            <form method="post" action="/diary/include/logout.jsp">
                <button class="common-btn" type="submit">로그아웃</button>
            </form>
        </div>
    </header>
    <div class="container">
        <div class="add-diary-container">
            <div class="add-diary-wrap">
                <div class="checkdate-container">
                    <div class="checkdate-message-wrap">
                        <div class="checkdate-message">일기 수정페이지</div>
                    </div>
                </div>
                <div class="input-container">
                    <form method="post" action="/diary/updateDiaryAction.jsp">
                        <div class="input-style">
                            <input class="add-diary-input-font" value="<%=diaryDate%>" type="text" name="diaryDate" placeholder="날짜" readonly="readonly">
                        </div>
                        <%
                            if (diaryOneRs.next()) {
                                String feeling = diaryOneRs.getString("feeling");
                                %>
                                    <div class="input-feeling-style">
                                        <label class="feeling-label">기분</label>
                                        <div class="feeling-input">
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
                                    <div class="input-style">
                                        <input class="add-diary-input-font" type="text" name="title" value="<%=diaryOneRs.getString("title")%>">
                                    </div>
                                    <div class="input-style">
                                        <select name="weather">
                                            <%
                                                switch (diaryOneRs.getString("weather")) {
                                                    case "맑음":
                                                        %>
                                                            <option value="select">날씨를 선택해주세요.</option>
                                                            <option value="1" selected>맑음</option>
                                                            <option value="2">흐림</option>
                                                            <option value="3">비</option>
                                                            <option value="4">눈</option>
                                                        <%
                                                        break;
                                                    case "흐림":
                                                        %>
                                                            <option value="select">날씨를 선택해주세요.</option>
                                                            <option value="1">맑음</option>
                                                            <option value="2" selected>흐림</option>
                                                            <option value="3">비</option>
                                                            <option value="4">눈</option>
                                                        <%
                                                        break;
                                                    case "비":
                                                        %>
                                                            <option value="select">날씨를 선택해주세요.</option>
                                                            <option value="1">맑음</option>
                                                            <option value="2">흐림</option>
                                                            <option value="3" selected>비</option>
                                                            <option value="4">눈</option>
                                                        <%
                                                        break;
                                                    case "눈":
                                                        %>
                                                            <option value="select">날씨를 선택해주세요.</option>
                                                            <option value="1">맑음</option>
                                                            <option value="2">흐림</option>
                                                            <option value="3">비</option>
                                                            <option value="4" selected>눈</option>
                                                        <%
                                                    default:
                                                        break;
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="input-style">
                                        <textarea class="add-diary-input-font" rows="5" cols="20" name="content"><%=diaryOneRs.getString("content")%></textarea>
                                    </div>
                                    <div style="display: flex; justify-content: flex-end;">
                                        <button class="add-diary-btn" type="submit">수정</button>
                                    </div>
                                <%
                            }
                        %>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>