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

<%
    String commentSQL = "select comment_no commentNo, memo, date_format(create_date, '%m-%e') date, date_format(create_date, '%H') time from diary_comment where diary_date = ?";
    PreparedStatement commentStmt = null;
    ResultSet commentRs = null;
    commentStmt = jdbcConn.prepareStatement(commentSQL);
    commentStmt.setString(1, diaryDate);
    commentRs = commentStmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/diaryOne.css">
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
        <div class="diary-one-container">
            <div class="diary-one-wrap">
                <div class="diary-one-btn-wrap">
                    <form method="get" action="/diary/updateDiaryForm.jsp">
                        <div>
                            <input type="hidden" name="diaryDate" value="<%=diaryDate%>">
                            <button class="diary-one-btn" type="submit">수정</button>
                        </div>
                    </form>
                    <form method="get" action="/diary/deleteDiaryAction.jsp">
                        <div>
                            <input type="hidden" name="diaryDate" value="<%=diaryDate%>">
                            <button class="diary-one-btn delete-btn" type="submit">삭제</button>
                        </div>
                    </form>
                </div>
                <div class="diary-article-wrap">
                    <%
                        if (diaryOneRs.next()) {
                    %>
                            <div class="diary-article">
                                <div class="diary-article-column">기록</div>
                                <div class="article-column-line"></div>
                                <div><%=diaryOneRs.getString("diary_date")%></div>
                            </div>
                            <div class="diary-article">
                                <div class="diary-article-column">기분</div>
                                <div class="article-column-line"></div>
                                <div><%=diaryOneRs.getString("feeling")%></div>
                            </div>
                            <div class="diary-article">
                                <div class="diary-article-column">제목</div>
                                <div class="article-column-line"></div>
                                <div><%=diaryOneRs.getString("title")%></div>
                            </div>
                            <div class="diary-article">
                                <div class="diary-article-column">날씨</div>
                                <div class="article-column-line"></div>
                                <div><%=diaryOneRs.getString("weather")%></div>
                            </div>
                            <div class="diary-article">
                                <div class="diary-article-column">일기</div>
                            </div>
                            <div class="diary-article-content">
                                <div><%=diaryOneRs.getString("content")%></div>
                            </div>
                    <%
                        }
                    %>
                </div>
                <div class="diary-comment-wrap">
                    <div class="diary-article">
                        <div class="diary-article-column">
                            <span>메모</span>
                        </div>
                    </div>
                    <form method="post" action="/diary/addCommentAction.jsp">
                        <div class="diary-comment-input">
                            <textarea name="memo"></textarea>
                        </div>
                        <div class="diary-comment-btn">
                            <input type="hidden" name="diaryDate" value="<%=diaryDate%>">
                            <button class="comment-btn" type="submit">메모하기</button>
                        </div>
                    </form>
                </div>
                <div class="diary-memo-wrap">
                    <%
                        while (commentRs.next()) {
                            %>
                                <div class="diary-comment-memo">
                                    <div class="memo-info">
                                        <div class="memo-date">
                                            <span><%=commentRs.getString("date")%>일</span>
                                            <span><%=commentRs.getString("time")%>시</span>
                                        </div>
                                        <form method="post" action="/diary/deleteCommentAction.jsp">
                                            <input type="hidden" name="diaryDate" value="<%=diaryDate%>">
                                            <input type="hidden" name="commentNo" value="<%=commentRs.getString("commentNo")%>">
                                            <button class="memo-delete-btn" type="submit">삭제</button>
                                        </form>
                                    </div>
                                    <div class="memo"><%=commentRs.getString("memo")%></div>
                                </div>
                            <%
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
    diaryOneRs.close();
    diaryOneStmt.close();
    commentRs.close();
    commentStmt.close();
    jdbcConn.close();
%>