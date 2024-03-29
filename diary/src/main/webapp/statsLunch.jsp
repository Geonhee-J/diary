<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String lunchSQL = "SELECT menu, count(*) cnt FROM diary_lunch GROUP BY menu;";
    PreparedStatement statsLunchStmt = null;
    ResultSet statsLunchRs = null;
    statsLunchStmt = sessionCheckConn.prepareStatement(lunchSQL);
    statsLunchRs = statsLunchStmt.executeQuery();
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
    <div class="container">
        <div class="statsLunchBox">
            <div class="statsLunchContentBox">
                <%
                    double totalCnt = 0;
                    while (statsLunchRs.next()) {
                        totalCnt = totalCnt + statsLunchRs.getInt("cnt");
                    }
                    statsLunchRs.beforeFirst();
                %>
                <div class="statsLunchOne">
                    <div class="statsLunchTableName">
                        <div>이번 달에 먹은 점심 횟수는 ?</div>
                    </div>
                    <div class="statsLunchColumn"></div>
                    <div class="totalCtn">
                        <div><%=(int) totalCnt%></div>
                    </div>
                </div>
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
                    // System.out.println("food : " + Arrays.toString(food));
                %>
                <div class="statsLunchOne">
                    <div class="statsLunchTableName"><%=menu%></div>
                    <div class="statsLunchColumn"></div>
                    <div class="statsLunchHeart">
                        <%
                            for (int i = 0; i < food.length; i++) {
                        %>
                                <div class="heart"><%=food[i]%></div>
                        <%
                            }
                        %>
                    </div>
                </div>
                <%
                    }
                    statsLunchRs.beforeFirst();
                %>
                <div class="statsLunchBtnBox">
                    <form method="post" action="/diary/diaryCalendar.jsp">
                        <div class="statsLunchBackBtn">
                            <button type="submit">나가기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>