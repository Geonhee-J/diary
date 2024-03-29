<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/loginOn.jsp"%>
<%@ include file="../include/jdbcConn.jsp"%>
<%@ include file="../include/calendar.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    int currentPage = 1;
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    
    int rowPerPage = 10;
    int startRow = (currentPage - 1) * rowPerPage;
    /* if (request.getParameter("rowPerPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("rowPerPage"));
    } */
    int totalRow = 0;
    
    String searchWord = "";
    if (request.getParameter("searchWord") != null) {
        searchWord = request.getParameter("searchWord");
    }
%>

<%
    String searchSQL =
            "SELECT diary_date diaryDate, month(diary_date) month, day(diary_date) day, feeling, title FROM diary_content WHERE title LIKE ? ORDER BY diary_date desc LIMIT ?, ?";
    
    PreparedStatement searchStmt = null;
    ResultSet searchRs = null;
    
    searchStmt = jdbcConn.prepareStatement(searchSQL);
    searchStmt.setString(1, "%" + searchWord + "%");
    searchStmt.setInt(2, startRow);
    searchStmt.setInt(3, rowPerPage);
    searchRs = searchStmt.executeQuery();
    
    String totalRowCountSQL = "SELECT count(*) FROM diary_content";
    
    PreparedStatement totalRowStmt = null;
    ResultSet totalRowRs = null;
    totalRowStmt = jdbcConn.prepareStatement(totalRowCountSQL);
    totalRowRs = totalRowStmt.executeQuery();
    
    if (totalRowRs.next()) {
        totalRow = totalRowRs.getInt("count(*)");
    }
    
    int lastPage = totalRow / rowPerPage;
    if (totalRow % rowPerPage != 0) {
        lastPage = lastPage + 1;
    }
    // System.out.println("lastPage : " + lastPage);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY DIARY</title>
    <link rel="stylesheet" href="/diary/css/diaryList.css">
</head>
<body>
    <div class="container">
        <div class="btnGroup">
            <div class="actionBtn">
                <form method="post" action="/diary/logoutAction.jsp">
                    <input type="hidden" name="logout" value="true">
                    <button class="logoutBtn" type="submit">LOGOUT</button>
                </form>
                <form method="post" action="/diary/addDiaryForm.jsp">
                    <button type="submit">WRITING DIARY</button>
                </form>
            </div>
            <div class="modeBtn">
                <form method="post" action="/diary/diaryCalendar.jsp">
                    <button type="submit">DIARY VIEW</button>
                </form>
                <form method="post" action="/diary/diaryList.jsp">
                    <button class="logoutBtn" type="submit">BOARD VIEW</button>
                </form>
            </div>
        </div>
        <div class="diary-title-box">
            <div class="diary-title">
                <%=tYear%>년
                <%=tMonth + 1%>월
            </div>
        </div>
        <div class="diaryBox">
            <div class="diaryListContentBox">
                <%
                    while (searchRs.next()) {
                        String month = searchRs.getString("month");
                        String day = searchRs.getString("day");
                        String feeling = searchRs.getString("feeling");
                        String title = searchRs.getString("title");
                        String diaryDate = searchRs.getString("diaryDate");
                %>
                        <div class="diaryListContent">
                            <div class="contentDate"><%=month%>월
                                <%=day%>일
                            </div>
                            <div>
                                <span class="feeling"><%=feeling%></span>
                            </div>
                            <div class="contentTitle">
                                <a href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"> <%=title%>
                                </a>
                            </div>
                        </div>
                <%
                    }
                %>
            </div>
            <div class="diaryListPaging">
                <%
                    if (currentPage > 1) {
                %>
                        <div class="pagingBtn">
                            <a href="./diaryList.jsp">처음페이지</a>
                        </div>
                        <div class="pagingBtn">
                            <a href="./diaryList.jsp?currentPage=<%=currentPage - 1%>">이전페이지</a>
                        </div>
                <%
                    }
                    if (currentPage < lastPage) {
                %>
                        <div class="pagingBtn">
                            <a href="./diaryList.jsp?currentPage=<%=currentPage + 1%>">다음페이지</a>
                        </div>
                        <div class="pagingBtn">
                            <a href="./diaryList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
                        </div>
                <%
                    }
                %>
            </div>
            <div class="searchInput">
                <form method="get" action="/diary/diaryList.jsp">
                    <input type="text" name="searchWord" placeholder="Search for a title" value="<%=searchWord%>">
                    <div class="searchBtnGroup">
                        <button class="resetButton" type="submit">초기화</button>
                        <button class="searchButton" type="submit">검색</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>