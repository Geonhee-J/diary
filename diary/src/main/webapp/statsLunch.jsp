<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String lunchSQL = "SELECT menu, count(*) cnt FROM diary_lunch WHERE year(lunch_date) = ? AND month(lunch_date) = ? GROUP BY menu;";
    PreparedStatement statsLunchStmt = null;
    ResultSet statsLunchRs = null;
    statsLunchStmt = jdbcConn.prepareStatement(lunchSQL);
    statsLunchStmt.setInt(1, tYear);
    statsLunchStmt.setInt(2, tMonth + 1);
    statsLunchRs = statsLunchStmt.executeQuery();
%>

<%
    double totalCnt = 0;
    while (statsLunchRs.next()) {
        totalCnt = totalCnt + statsLunchRs.getInt("cnt");
    }
    statsLunchRs.beforeFirst();
%>

<%
    String korean = "&#129505;";
    String chinese = "&#128153;";
    String japanese = "&#128154;";
    String western = "&#128155;";
    String etc = "&#128156;";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/statsLunch.css">
</head>
<body>
    <header>
        <div class="header-calendar">
            <div class="calendar-yymm">
                <%=tYear%>년
                <%=tMonth + 1%>월
            </div>
            <div class="calendar-btn">
                <a href="/diary/statsLunch.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth - 1%>">이전 달</a>
                <div class="header-btn-column"></div>
                <a href="/diary/statsLunch.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth + 1%>">다음 달</a>
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
        <div class="stats-lunch-container">
            <div class="stats-lunch-wrap">
                <div class="lunch-total-cnt-container">
                    <div class="lunch-total-cnt-wrap">
                        <div class="lunch-total-cnt-message-box">
                            <div class="lunch-total-cnt-message"><%=tMonth + 1%>월에 먹은 점심 횟수는?</div>
                            <div class="lunch-total-cnt-message"><%=(int) totalCnt%></div>
                        </div>
                    </div>
                    <div class="stats-wrap">
                        <%
                            while (statsLunchRs.next()) {
                                int cnt = statsLunchRs.getInt("cnt");
                                String menu = statsLunchRs.getString("menu");
                                String[] food = new String[cnt];
                                for (int i = 0; i < food.length; i++) {
                                    if (menu.equals("한식")) {
                                        food[i] = korean;
                                    } else if (menu.equals("중식")) {
                                        food[i] = chinese;
                                    } else if (menu.equals("일식")) {
                                        food[i] = japanese;
                                    } else if (menu.equals("양식")) {
                                        food[i] = western;
                                    } else if (menu.equals("기타")) {
                                        food[i] = etc;
                                    }
                                }
                        %>
                                <div class="stats-article">
                                    <span class="stats-article-column"><%=menu%></span>
                                    <div class="stats-column-line"></div>
                                    <div>
                                        <%
                                            for (int i = 0; i < food.length; i++) {
                                                %>
                                                    <%=food[i]%>
                                                <%
                                            }
                                        %>
                                    </div>
                                </div>
                        <%
                            }
                            statsLunchRs.beforeFirst();
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>