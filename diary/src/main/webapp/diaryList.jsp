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
    String searchSQL = "SELECT diary_date diaryDate, month(diary_date) month, day(diary_date) day, feeling, title FROM diary_content WHERE title LIKE ? ORDER BY diary_date desc LIMIT ?, ?";
    
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
    <header>
        <div class="header-calendar">
            <div class="calendar-yymm">
                <%=tYear%>년
                <%=tMonth + 1%>월
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
        <div class="list-container">
            <div class="list-wrap">
                <div class="list-search-wrap">
                    <form method="get" action="/diary/diaryList.jsp">
                        <input class="list-search-input" type="text" name="searchWord" placeholder="제목 검색" value="<%=searchWord%>">
                        <button class="search-btn" type="submit">검색</button>
                    </form>
                </div>
                <table class="list-content-wrap">
                    <tr>
                        <th>제목</th>
                        <th>기분</th>
                        <th>날짜</th>
                    </tr>
                    <%
                        while (searchRs.next()) {
                            String diaryDate = searchRs.getString("diaryDate");
                    %>
                            <tr>
                                <td class="list-content-title">
                                    <span><a href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"><%=searchRs.getString("title")%></a></span>
                                </td>
                                <td class="list-content-feeling">
                                    <span class="list-content-feeling"><%=searchRs.getString("feeling")%></span>
                                </td>
                                <td class="list-content-date">
                                    <span><%=searchRs.getString("month")%>월</span>
                                    <span><%=searchRs.getString("day")%>일</span>
                                </td>
                            </tr>
                    <%
                        }
                    %>
                </table>
                <div class="list-page-btn-wrap">
                    <%
                        if (currentPage > 1) {
                    %>
                            <div class="list-page-btn">
                                <a href="./diaryList.jsp">처음페이지</a>
                            </div>
                            <div class="list-page-btn">
                                <a href="./diaryList.jsp?currentPage=<%=currentPage - 1%>">이전페이지</a>
                            </div>
                    <%
                        }
                        if (currentPage < lastPage) {
                    %>
                            <div class="list-page-btn">
                                <a href="./diaryList.jsp?currentPage=<%=currentPage + 1%>">다음페이지</a>
                            </div>
                            <div class="list-page-btn">
                                <a href="./diaryList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
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