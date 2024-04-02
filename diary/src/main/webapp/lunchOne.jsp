<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String checkDate = request.getParameter("checkDate");
    String ck = request.getParameter("ck");
    String menu = request.getParameter("menu");
    String errMsg = request.getParameter("errMsg");
    
    if (checkDate == null) {
        checkDate = "";
    }
    
    if (ck == null) {
        ck = "";
    }
    
    if (menu == null) {
        menu = "";
    }
    
    String msg = "";
    
    if (ck.equals("T") && !checkDate.equals("")) {
        msg = "투표 할 수 있어요.";
    } else if (ck.equals("F")) {
        msg = "이미 투표를 하셨네요.";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY DIARY</title>
<link rel="stylesheet" href="/diary/css/lunchOne.css">
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
        <div class="lunch-one-container">
            <div class="lunch-one-wrap">
                <div class="checkdate-container">
                    <form method="post" action="/diary/lunchOneCheckDateAction.jsp">
                        <div class="checkdate-message-wrap">
                            <%
                                if (errMsg == null) {
                                    if (!msg.equals("")) {
                                        %>
                                            <div class="checkdate-message-box">
                                                <div class="checkdate-message"><%=msg%></div>
                                                    <%
                                                        if (!menu.equals("")) {
                                                            %>
                                                                <div class="checkdate-message">선택하신 메뉴는 <%=menu%>입니다.</div>
                                                            <%
                                                        }
                                                    %>
                                            </div>
                                        <%
                                    } else {
                                        %>
                                            <div class="checkdate-message">날짜를 선택 후 확인을 눌러주세요.</div>
                                        <%
                                    }
                                } else {
                                    %>
                                        <div class="checkdate-message"><%=errMsg%></div>
                                    <%
                                }
                            %>
                        </div>
                        <div class="checkdate-input-wrap">
                            <input class="checkdate-input" type="date" name="checkDate" value="<%=checkDate%>">
                            <button class="lunch-one-diary-btn" type="submit">확인</button>
                        </div>
                    </form>
                </div>
            <%
                if (ck.equals("T")) {
            %>
                <div class="input-container">
                    <form method="post" action="/diary/lunchOneAction.jsp">
                        <div class="input-style">
                            <div class="menu-select">
                                <label for="1">&#129505;</label> <label for="1">한식</label>
                                <div>
                                    <input type="radio" name="menu" value="한식" id="1">
                                </div>
                            </div>
                            <div class="menu-select">
                                <label for="2">&#128153;</label> <label for="2">중식</label>
                                <div>
                                    <input type="radio" name="menu" value="중식" id="2">
                                </div>
                            </div>
                            <div class="menu-select">
                                <label for="3">&#128154;</label> <label for="3">일식</label>
                                <div>
                                    <input type="radio" name="menu" value="일식" id="3">
                                </div>
                            </div>
                            <div class="menu-select">
                                <label for="4">&#128155;</label> <label for="4">양식</label>
                                <div>
                                    <input type="radio" name="menu" value="양식" id="4">
                                </div>
                            </div>
                            <div class="menu-select">
                                <label for="5">&#128156;</label> <label for="5">기타</label>
                                <div>
                                    <input type="radio" name="menu" value="기타" id="5">
                                </div>
                            </div>
                        </div>
                        <div>
                            <input type="hidden" name="diaryDate" value="<%=checkDate%>">
                            <button class="select-diary-btn" type="submit">투표</button>
                        </div>
                    </form>
                </div>
            <%
                }
                if (ck.equals("F")) {
            %>
                    <form method="post" action="/diary/deleteLunchOneAction.jsp">
                        <div>
                            <input type="hidden" name="diaryDate" value="<%=checkDate%>">
                            <button class="select-diary-btn" type="submit">삭제</button>
                        </div>
                    </form>
            <%
                }
            %>
            </div>
        </div>
    </div>
</body>
</html>