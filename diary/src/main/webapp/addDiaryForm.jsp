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
        <div class="add-diary-container">
            <div class="add-diary-wrap">
                <div class="checkdate-container">
                    <form method="post" action="/diary/checkDateAction.jsp">
                        <div class="checkdate-message-wrap">
                            <%
                                if (!msg.equals("")) {
                            %>
                                    <div class="checkdate-message"><%=msg%></div>
                            <%
                                } else {
                            %>
                                    <div class="checkdate-message">날짜를 선택 후 확인을 눌러주세요.</div>
                            <%
                                }
                            %>
                        </div>
                        <div class="checkdate-input-wrap">
                            <input class="checkdate-input" type="date" name="checkDate" value="<%=checkDate%>">
                            <button class="add-diary-btn" type="submit">확인</button>
                        </div>
                    </form>
                </div>
                <div class="input-container">
                    <form method="post" action="/diary/addDiaryAction.jsp">
                        <div class="input-style">
                            <%
                                if (ck.equals("T")) {
                            %>
                                    <input class="add-diary-input-font" value="<%=checkDate%>" type="text" name="diaryDate" placeholder="날짜" readonly="readonly">
                            <%
                                } else {
                            %>
                                    <input class="add-diary-input-font" value="<%=checkDate%>" type="text" name="diaryDate" placeholder="날짜" readonly="readonly">
                            <%
                                }
                            %>
                        </div>
                        <div class="input-feeling-style">
                            <label class="feeling-label">기분</label>
                            <div class="feeling-input">
                                <div>
                                    <label for="1">&#128525;</label>
                                    <input id="1" type="radio" name="feeling" value="&#128525;">
                                </div>
                                <div>
                                    <label for="2">&#128515;</label>
                                    <input id="2" type="radio" name="feeling" value="&#128515;">
                                </div>
                                <div>
                                    <label for="3">&#128528;</label>
                                    <input id="3" type="radio" name="feeling" value="&#128528;">
                                </div>
                                <div>
                                    <label for="4">&#128557;</label>
                                    <input id="4" type="radio" name="feeling" value="&#128557;">
                                </div>
                                <div>
                                    <label for="5">&#128545;</label>
                                    <input id="5" type="radio" name="feeling" value="&#128545;">
                                </div>
                            </div>
                        </div>
                        <div class="input-style">
                            <input class="add-diary-input-font" type="text" name="title" placeholder="제목">
                        </div>
                        <div class="input-style">
                            <select name="weather">
                                <option value="select">날씨를 선택해주세요.</option>
                                <option value="1">맑음</option>
                                <option value="2">흐림</option>
                                <option value="3">비</option>
                                <option value="4">눈</option>
                            </select>
                        </div>
                        <div class="input-style">
                            <textarea class="add-diary-input-font" rows="5" cols="20" name="content" placeholder="일기장"></textarea>
                        </div>
                        <div style="display: flex; justify-content: flex-end;">
                            <button class="add-diary-btn" type="submit">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>