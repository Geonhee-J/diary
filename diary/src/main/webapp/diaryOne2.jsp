<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String diaryDate = request.getParameter("diaryDate");
    
    PreparedStatement diaryOneStmt = null;
    ResultSet diaryOneRs = null;
    
    String diaryOneSQL = "SELECT diary_date, feeling, title, weather, content, update_date, create_date FROM diary_content WHERE diary_date = ?";
    
    diaryOneStmt = sessionCheckConn.prepareStatement(diaryOneSQL);
    diaryOneStmt.setString(1, diaryDate);
    diaryOneRs = diaryOneStmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/diaryOne.css">
</head>
<body>
    <div class="container">
        <div class="diaryOneBox">
            <div class="diaryOneContentBox">
                <div class="diaryOneBtnBox">
                    <form method="post" action="/diary/diaryCalendar.jsp">
                        <div class="diaryOneBackBtn">
                            <button type="submit">나가기</button>
                        </div>
                    </form>
                </div>
                <%
                    if (diaryOneRs.next()) {
                        String diary_date = diaryOneRs.getString("diary_date");
                        String feeling = diaryOneRs.getString("feeling");
                        String title = diaryOneRs.getString("title");
                        String weather = diaryOneRs.getString("weather");
                        String content = diaryOneRs.getString("content");
                        String update_date = diaryOneRs.getString("update_date");
                        String create_date = diaryOneRs.getString("create_date");
                %>
                        <div class="diaryOne">
                            <div class="diaryOneTableName">기록</div>
                            <div class="diaryOneColumn"></div>
                            <div><%=diary_date%></div>
                        </div>
                        <div class="diaryOne">
                            <div class="diaryOneTableName">기분</div>
                            <div class="diaryOneColumn"></div>
                            <div class="feeling"><%=feeling%></div>
                        </div>
                        <div class="diaryOne">
                            <div class="diaryOneTableName">제목</div>
                            <div class="diaryOneColumn"></div>
                            <div><%=title%></div>
                        </div>
                        <div class="diaryOne">
                            <div class="diaryOneTableName">날씨</div>
                            <div class="diaryOneColumn"></div>
                            <div><%=weather%></div>
                        </div>
                        <div class="diaryOneContent">
                            <div class="diaryOneTableName">작성일</div>
                            <div class="diaryOneRow"></div>
                            <div><%=content%></div>
                        </div>
                        <div class="diaryOne">
                            <div class="diaryOneTableName">작성일</div>
                            <div class="diaryOneColumn"></div>
                            <div><%=create_date%></div>
                        </div>
                        <div class="diaryOne">
                            <div class="diaryOneTableName">수정일</div>
                            <div class="diaryOneColumn"></div>
                            <div><%=update_date%></div>
                        </div>
                <%
                    }
                %>
                <div class="diaryOneBtnBox">
                    <form method="get" action="/diary/updateDiaryForm.jsp">
                        <div class="diaryOneEditBtn">
                            <input type="hidden" name="diaryDate" value="<%=diaryDate%>">
                            <button type="submit">수정</button>
                        </div>
                    </form>
                    <form method="get" action="/diary/deleteDiaryAction.jsp">
                        <div class="diaryOneDeleteBtn">
                            <input type="hidden" name="diaryDate" value="<%=diaryDate%>">
                            <button type="submit">삭제</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<%
    // DB자원 반납
    diaryOneRs.close();
    diaryOneStmt.close();
    sessionCheckRs.close();
    sessionCheckStmt.close();
    sessionCheckConn.close();
%>