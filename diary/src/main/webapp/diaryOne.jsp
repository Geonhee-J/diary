<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
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
    String commentSQL = "select comment_no commentNo, memo, create_date createDate from diary_comment where diary_date = ?";
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
    <div class="container">
        <div class="diaryOneBox">
            <div class="diaryOneContentBox">
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
                            <div class="diaryOneTableName">일기</div>
                            <div class="diaryOneRow"></div>
                            <div><%=content%></div>
                        </div>
                <%
                    }
                %>
                <div class="diaryOneBtnBox">
                    <form method="post" action="/diary/diaryCalendar.jsp">
                        <div class="diaryOneBackBtn">
                            <button type="submit">나가기</button>
                        </div>
                    </form>
                    <div class="diaryOneActionBtn">
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
            <div class="diaryOneCommentBox">
                <div class="">
                    <form method="post" action="/diary/addCommentAction.jsp">
                        <input type="hidden" name="diaryDate" value="<%=diaryDate%>">
                        <div class="diaryOneComment">
                            <textarea name="memo"></textarea>
                        </div>
                        <div class="diaryOneCommentBtnBox diaryOneCommentBtn">
                            <button type="submit">댓글 입력</button>
                        </div>
                    </form>
                </div>
                <%
                    while (commentRs.next()) {
                        %>
                            <div class="diaryOneCommentOne">
                                <div class="commentOneHeader">
                                    <div class="diaryOneTableName" style="font-size: 12px;"><%=commentRs.getString("createDate")%></div>
                                    <form method="post" action="/diary/deleteCommentAction.jsp?comment_no=<%=commentRs.getString("commentNo")%>">
                                        <button type="submit">삭제</button>
                                    </form>
                                </div>
                                <div class="diaryOneRow"></div>
                                <div><%=commentRs.getString("memo")%></div>
                            </div>
                        <%
                    }
                %>
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