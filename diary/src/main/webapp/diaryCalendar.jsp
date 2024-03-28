<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    // DB에서 tYear와 tMonth에 해당되는 diary_content 목록 추출
    String inquireDateSQL = "SELECT diary_date diaryDate, DAY(diary_date) day, feeling FROM diary_content WHERE year(diary_date) = ? AND month(diary_date) = ?";
    
    PreparedStatement diaryExtractStmt = null;
    ResultSet diaryExtractRs = null;
    
    diaryExtractStmt = sessionCheckConn.prepareStatement(inquireDateSQL);
    diaryExtractStmt.setInt(1, tYear);
    diaryExtractStmt.setInt(2, tMonth + 1);
    diaryExtractRs = diaryExtractStmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/diaryCalendar.css">
</head>
<body>
    <div class="container">
        <div class="btnGroup">
            <div class="actionBtn">
                <form method="post" action="/diary/logoutAction.jsp">
                    <input type="hidden" name="logout" value="true">
                    <button class="logoutBtn" type="submit">로그아웃</button>
                </form>
                <form method="post" action="/diary/addDiaryForm.jsp">
                    <button type="submit">일기쓰기</button>
                </form>
                <form method="post" action="/diary/diaryCalendar.jsp">
                    <button class="logoutBtn" type="submit">달력으로보기</button>
                </form>
                <form method="post" action="/diary/diaryList.jsp">
                    <button type="submit">리스트로보기</button>
                </form>
                <form method="post" action="/diary/lunchOne.jsp">
                    <button class="logoutBtn" type="submit">점심메뉴투표</button>
                </form>
                <form method="post" action="/diary/statsLunch.jsp">
                    <button type="submit">점심메뉴통계</button>
                </form>
            </div>
        </div>
        <div class="calendar-title-box">
            <div class="calendar-title">
                <%=tYear%>년
                <%=tMonth + 1%>월
            </div>
        </div>
        <div class="calendarBox">
            <div class="calendarArrow">
                <a href="/diary/diaryCalendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth - 1%>">PREV</a>
            </div>
            <div>
                <%
                    for (int i = 0; i < yo.length; i = i + 1) {
                        if (i == 0) {
                %>
                            <div class="yo th-seven"><%=yo[i]%></div>
                <%
                        } else if (i + 1 == yo.length) {
                %>
                            <div class="yo th-six"><%=yo[i]%></div>
                <%
                        } else {
                %>
                            <div class="yo"><%=yo[i]%></div>
                <%
                        }
                    }
                    for (int i = 1; i <= countDiv; i = i + 1) {
                    int date = i - startBlank; // 날짜(1, 2, 3 ... 29, 30, 31)
                    int todayDate = 0; // 오늘 날짜가 들어갈 변수
                    boolean sunday = i % 7 == 1; // 일요일
                    boolean saturday = i % 7 == 0; // 토요일
                    // 해당 달의 첫 날과 마지막 날을 구하는 비교식
                    boolean monthDate = 0 < date && date <= lastDate;
                    // 해당 달의 첫 날과 마지막 날을 제외한 공백을 구하는 비교식
                    boolean blank = date <= 0 || lastDate < date;
                    // 오늘 날짜를 구하는 비교식
                    boolean todayResult = nowYear == tYear && nowMonth == tMonth && nowDay == i;
                    // true면 오늘 날짜를 담아줌
                        if (todayResult) {
                            todayDate = nowDay - startBlank;
                        }

                        if (todayResult) {
                            if (sunday) {
                                if (monthDate) {
                                    %>
                                        <div class="date-box date th-seven today">
                                            <div class="in-date">
                                                <%=todayDate%>
                                                <%
                                                    while (diaryExtractRs.next()) {
                                                        int day = diaryExtractRs.getInt("day");
                                                        String diaryDate = diaryExtractRs.getString("diaryDate");
                                                        String feeling = diaryExtractRs.getString("feeling");
                                                        if (todayDate == day) {
                                                            %>
                                                                <a class="diaryBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
                                                                <span class="feeling"><%=feeling%></span>
                                                            <%
                                                            break;
                                                        }
                                                    }
                                                    diaryExtractRs.beforeFirst();
                                                %>
                                            </div>
                                        </div>
                                    <%
                                } else if (blank) {
                                    %>
                                        <div class="date-box date-blank th-seven"></div>
                                    <%
                                }
                            } else if (saturday) {
                                if (monthDate) {
                                    %>
                                        <div class="date-box date th-six today">
                                            <div class="in-date">
                                                <%=todayDate%>
                                                <%
                                                    while (diaryExtractRs.next()) {
                                                        int day = diaryExtractRs.getInt("day");
                                                        String diaryDate = diaryExtractRs.getString("diaryDate");
                                                        String feeling = diaryExtractRs.getString("feeling");
                                                        if (todayDate == day) {
                                                            %>
                                                                <a class="diaryBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
                                                                <span class="feeling"><%=feeling%></span>
                                                            <%
                                                            break;
                                                        }
                                                    }
                                                    diaryExtractRs.beforeFirst();
                                                %>
                                            </div>
                                        </div>
                                    <%
                                } else if (blank) {
                                    %>
                                        <div class="date-box date-blank th-six"></div>
                                    <%
                                }
                            } else {
                                if (monthDate) {
                                    %>
                                        <div class="date-box date today">
                                            <div class="in-date">
                                                <%=todayDate%>
                                                <%
                                                    while (diaryExtractRs.next()) {
                                                        int day = diaryExtractRs.getInt("day");
                                                        String diaryDate = diaryExtractRs.getString("diaryDate");
                                                        String feeling = diaryExtractRs.getString("feeling");
                                                        if (todayDate == day) {
                                                            %>
                                                                <a class="diaryBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
                                                                <span class="feeling"><%=feeling%></span>
                                                            <%
                                                            break;
                                                        }
                                                    }
                                                    diaryExtractRs.beforeFirst();
                                                %>
                                            </div>
                                        </div>
                                    <%
                                } else if (blank) {
                                    %>
                                        <div class="date-box date-blank"></div>
                                    <%
                                }
                            }
                        } else {
                            if (sunday) {
                                if (monthDate) {
                                    %>
                                        <div class="date-box date th-seven">
                                            <div class="in-date">
                                                <%=date%>
                                                <%
                                                    while (diaryExtractRs.next()) {
                                                        int day = diaryExtractRs.getInt("day");
                                                        String diaryDate = diaryExtractRs.getString("diaryDate");
                                                        String feeling = diaryExtractRs.getString("feeling");
                                                        if (date == day) {
                                                            %>
                                                                <a class="diaryBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
                                                                <span class="feeling"><%=feeling%></span>
                                                            <%
                                                            break;
                                                        }
                                                    }
                                                    diaryExtractRs.beforeFirst();
                                                %>
                                            </div>
                                        </div>
                                    <%
                                } else if (blank) {
                                    %>
                                        <div class="date-box date-blank th-seven"></div>
                                    <%
                                }
                            } else if (saturday) {
                                if (monthDate) {
                                    %>
                                        <div class="date-box date th-six">
                                            <div class="in-date">
                                                <%=date%>
                                                <%
                                                    while (diaryExtractRs.next()) {
                                                        int day = diaryExtractRs.getInt("day");
                                                        String diaryDate = diaryExtractRs.getString("diaryDate");
                                                        String feeling = diaryExtractRs.getString("feeling");
                                                        if (date == day) {
                                                            %>
                                                                <a class="diaryBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
                                                                <span class="feeling"><%=feeling%></span>
                                                            <%
                                                            break;
                                                        }
                                                    }
                                                    diaryExtractRs.beforeFirst();
                                                %>
                                            </div>
                                        </div>
                                    <%
                                } else if (blank) {
                                    %>
                                        <div class="date-box date-blank th-six"></div>
                                    <%
                                }
                            } else {
                                if (monthDate) {
                                    %>
                                        <div class="date-box date">
                                            <div class="in-date">
                                                <%=date%>
                                                <%
                                                    while (diaryExtractRs.next()) {
                                                        int day = diaryExtractRs.getInt("day");
                                                        String diaryDate = diaryExtractRs.getString("diaryDate");
                                                        String feeling = diaryExtractRs.getString("feeling");
                                                        if (date == day) {
                                                            %>
                                                                <a class="diaryBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
                                                                <span class="feeling"><%=feeling%></span>
                                                            <%
                                                            break;
                                                        }
                                                    }
                                                    diaryExtractRs.beforeFirst();
                                                %>
                                            </div>
                                        </div>
                                    <%
                                } else if (blank) {
                                    %>
                                        <div class="date-box date-blank"></div>
                                    <%
                                }
                            }
                        }
                    }
                %>
            </div>
            <div class="calendarArrow">
                <a href="/diary/diaryCalendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth + 1%>">NEXT</a>
            </div>
        </div>
    </div>
</body>
</html>

<%
    // DB자원 반납
    diaryExtractStmt.close();
    diaryExtractRs.close();
    sessionCheckRs.close();
    sessionCheckStmt.close();
    sessionCheckConn.close();
%>