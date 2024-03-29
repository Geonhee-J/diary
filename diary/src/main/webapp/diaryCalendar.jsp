<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    // DB에서 tYear와 tMonth에 해당되는 diary_content 목록 추출
    String inquireDateSQL = "SELECT diary_date diaryDate, DAY(diary_date) day, feeling FROM diary_content WHERE year(diary_date) = ? AND month(diary_date) = ?";
    
    PreparedStatement diaryExtractStmt = null;
    ResultSet diaryExtractRs = null;
    
    diaryExtractStmt = jdbcConn.prepareStatement(inquireDateSQL);
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
    <header>
        <div class="header-calendar">
            <div class="calendar-yymm">
                <%=tYear%>년
                <%=tMonth + 1%>월
            </div>
            <div class="calendar-btn">
                <a href="/diary/diaryCalendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth - 1%>">이전 달</a>
                <div class="header-btn-column"></div>
                <a href="/diary/diaryCalendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth + 1%>">다음 달</a>
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
        <div class="calendar-container">
            <div class="calendar-wrap">
                <div class="calendar-content">
                    <%
                        for (int i = 0; i < yo.length; i = i + 1) {
                            if (i == 0) {
                                %>
                                    <div class="day sunday"><%=yo[i]%></div>
                                <%
                            } else if (i + 1 == yo.length) {
                                %>
                                    <div class="day saturday"><%=yo[i]%></div>
                                <%
                            } else {
                                %>
                                    <div class="day"><%=yo[i]%></div>
                                <%
                            }
                        }
                    %>
                    
                    <%
                        for (int i = 1; i <= countDiv; i = i + 1) {
                            int date = i - startBlank; // 날짜(1, 2, 3 ... 29, 30, 31)
                            int todayDate = 0; // 오늘 날짜가 들어갈 변수
                            boolean sunday = i % 7 == 1; // 일요일
                            boolean saturday = i % 7 == 0; // 토요일
                            boolean monthDate = 0 < date && date <= lastDate; // 해당 달의 첫 날과 마지막 날을 구하는 비교식
                            boolean blank = date <= 0 || lastDate < date; // 해당 달의 첫 날과 마지막 날을 제외한 공백을 구하는 비교식
                            boolean todayResult = nowYear == tYear && nowMonth == tMonth && nowDay == i; // 오늘 날짜를 구하는 비교식
                            if (todayResult) {
                                todayDate = nowDay - startBlank; // true면 오늘 날짜를 담아줌
                            }
                            /* 여기서 부터 분기문 시작 */
                            if (todayResult) {
                                if (sunday) {
                                    if (monthDate) {
                    %>
                                        <div class="date-box date sunday today">
                                            <%=todayDate%>
                                            <div class="in-date">
                                                    <%
                                                        while (diaryExtractRs.next()) {
                                                            int day = diaryExtractRs.getInt("day");
                                                            String diaryDate = diaryExtractRs.getString("diaryDate");
                                                            String feeling = diaryExtractRs.getString("feeling");
                                                            if (todayDate == day) {
                                                    %>
                                                                <a class="pockeBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
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
                                        <div class="date-box blank-date sunday"></div>
                    <%
                                    }
                                } else if (saturday) {
                                    if (monthDate) {
                    %>
                                        <div class="date-box date saturday today">
                                            <%=todayDate%>
                                            <div class="in-date">
                                                    <%
                                                        while (diaryExtractRs.next()) {
                                                            int day = diaryExtractRs.getInt("day");
                                                            String diaryDate = diaryExtractRs.getString("diaryDate");
                                                            String feeling = diaryExtractRs.getString("feeling");
                                                            if (todayDate == day) {
                                                    %>
                                                                <a class="pockeBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
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
                                        <div class="date-box blank-date saturday"></div>
                    <%
                                    }
                                } else {
                                    if (monthDate) {
                    %>
                                        <div class="date-box date today">
                                            <%=todayDate%>
                                            <div class="in-date">
                                                    <%
                                                        while (diaryExtractRs.next()) {
                                                            int day = diaryExtractRs.getInt("day");
                                                            String diaryDate = diaryExtractRs.getString("diaryDate");
                                                            String feeling = diaryExtractRs.getString("feeling");
                                                            if (todayDate == day) {
                                                    %>
                                                                <a class="pockeBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
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
                                        <div class="date-box blank-date"></div>
                    <%
                                    }
                                }
                            } else {
                                if (sunday) {
                                    if (monthDate) {
                    %>
                                        <div class="date-box date sunday">
                                            <%=date%>
                                            <div class="in-date">
                                                    <%
                                                        while (diaryExtractRs.next()) {
                                                            int day = diaryExtractRs.getInt("day");
                                                            String diaryDate = diaryExtractRs.getString("diaryDate");
                                                            String feeling = diaryExtractRs.getString("feeling");
                                                            if (date == day) {
                                                    %>
                                                                    <a class="pockeBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
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
                                        <div class="date-box blank-date sunday"></div>
                    <%
                                    }
                                } else if (saturday) {
                                    if (monthDate) {
                    %>
                                        <div class="date-box date saturday">
                                            <%=date%>
                                            <div class="in-date">
                                                    <%
                                                        while (diaryExtractRs.next()) {
                                                            int day = diaryExtractRs.getInt("day");
                                                            String diaryDate = diaryExtractRs.getString("diaryDate");
                                                            String feeling = diaryExtractRs.getString("feeling");
                                                            if (date == day) {
                                                    %>
                                                                    <a class="pockeBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
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
                                        <div class="date-box blank-date saturday"></div>
                    <%
                                    }
                                } else {
                                    if (monthDate) {
                    %>
                                        <div class="date-box date">
                                            <%=date%>
                                            <div class="in-date">
                                                    <%
                                                        while (diaryExtractRs.next()) {
                                                            int day = diaryExtractRs.getInt("day");
                                                            String diaryDate = diaryExtractRs.getString("diaryDate");
                                                            String feeling = diaryExtractRs.getString("feeling");
                                                            if (date == day) {
                                                    %>
                                                                    <a class="pockeBall" href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"></a>
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
                                        <div class="date-box blank-date"></div>
                    <%
                                    }
                                }
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<%
    // DB자원 반납
    diaryExtractStmt.close();
    diaryExtractRs.close();
    jdbcConn.close();
%>