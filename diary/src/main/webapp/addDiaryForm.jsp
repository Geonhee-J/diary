<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String checkDate = request.getParameter("checkDate");
    String ck = request.getParameter("ck");
    
    if (checkDate == null) {
        checkDate = "";
    }
    
    if (ck == null) {
        ck = "";
    }
    
    String msg = "";
    
    if (ck.equals("T") && !checkDate.equals("")) {
        msg = "일기를 작성 할 수 있어요.";
    } else if (ck.equals("F")) {
        msg = "이미 작성한 일기가 있어요.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/addDiaryForm.css">
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
            <form method="post" action="/diary/statsLunch.jsp">
                <button class="common-btn" type="submit">점심메뉴보기</button>
            </form>
            <div class="header-btn-column"></div>
            <form method="post" action="/diary/include/logout.jsp">
                <button class="common-btn" type="submit">로그아웃</button>
            </form>
        </div>
    </header>
    <div class="container">
        <div class="addDiaryBox">
            <div class="checkDateInputBox">
                <form method="post" action="/diary/checkDateAction.jsp">
                    <div class="messageBox">
                        <%
                            if (!msg.equals("")) {
                        %>
                                <div class="message"><%=msg%></div>
                        <%
                            } else {
                        %>
                                <div class="message">날짜를 선택 후 확인을 눌러주세요.</div>
                        <%
                            }
                        %>
                    </div>
                    <div class="checkDateInput">
                        <input type="date" name="checkDate" value="<%=checkDate%>">
                    </div>
                    <div class="checkDateInput">
                        <button type="submit">확인</button>
                    </div>
                </form>
            </div>
            <div class="addDiaryInputBox">
                <form method="post" action="/diary/addDiaryAction.jsp">
                    <div class="addDiaryInput">
                        <%
                            if (ck.equals("T")) {
                        %>
                                <input value="<%=checkDate%>" type="text" name="diaryDate" placeholder="DATE" readonly="readonly">
                        <%
                            } else {
                        %>
                                <input value="<%=checkDate%>" type="text" name="diaryDate" placeholder="DATE" readonly="readonly">
                        <%
                            }
                        %>
                    </div>
                    <div class="addDiaryInputMood">
                        <label class="moodLabel">MOOD</label>
                        <div>
                            &#128525;<input type="radio" name="feeling" value="&#128525;">
                            &#128515;<input type="radio" name="feeling" value="&#128515;">
                            &#128528;<input type="radio" name="feeling" value="&#128528;">
                            &#128557;<input type="radio" name="feeling" value="&#128557;">
                            &#128545;<input type="radio" name="feeling" value="&#128545;">
                        </div>
                    </div>
                    <div class="addDiaryInput">
                        <input type="text" name="title" placeholder="TITLE">
                    </div>
                    <div class="addDiaryInput">
                        <select name="weather">
                            <option value="select">Select a weather</option>
                            <option value="1">맑음</option>
                            <option value="2">흐림</option>
                            <option value="3">비</option>
                            <option value="4">눈</option>
                        </select>
                    </div>
                    <div class="addDiaryInput">
                        <textarea rows="5" cols="20" name="content" placeholder="WRITING A DIARY"></textarea>
                    </div>
                    <div class="addDiaryInput">
                        <button type="submit">저장</button>
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