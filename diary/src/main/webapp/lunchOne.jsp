<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/sessionCheck.jsp"%>
<%@ include file="../include/fonts.jsp"%>

<%
    String checkDate = request.getParameter("checkDate");
    String ck = request.getParameter("ck");
    String menu = request.getParameter("menu");
    String errMsg = request.getParameter("errMsg");
    System.out.println("checkDate : " + checkDate);
    
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
    <div class="container">
        <div class="lunchOneBox">
            <div class="checkDateInputBox">
                <form method="post" action="/diary/lunchOneCheckDateAction.jsp">
                    <div class="messageBox">
                        <%
                        if (!msg.equals("")) {
                        %>
                        <div class="messageBox2">
                            <%
                            if (errMsg != null) {
                            %>
                            <div class="message"><%=errMsg%></div>
                            <%
                            }
                            %>
                            <div class="message"><%=msg%></div>
                            <%
                            if (!menu.equals("")) {
                            %>
                            <div class="message">
                                선택하신 메뉴는
                                <%=menu%>입니다.
                            </div>
                            <%
                            }
                            %>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="message">날짜를 선택 후 확인을 눌러주세요.</div>
                        <%
                        }
                        %>
                    </div>
                    <div class="checkDateInput">
                        <input type="date" name="checkDate" value="<%=checkDate%>">
                    </div>
                    <div class="checkDateInput">
                        <button type="submit">확인</button>
                    </div>
                </form>
            </div>
            <%
            if (ck.equals("T")) {
            %>
            <div class="voteLunchInputBox">
                <form method="post" action="/diary/lunchOneAction.jsp">
                    <div class="lunchSelect">
                        <div class="selectContent">
                            <label for="1">&#129505;</label> <label for="1">한식</label>
                            <div>
                                <input type="radio" name="lunch" value="한식" id="1">
                            </div>
                        </div>
                        <div class="selectContent">
                            <label for="2">&#128153;</label> <label for="2">중식</label>
                            <div>
                                <input type="radio" name="lunch" value="중식" id="2">
                            </div>
                        </div>
                        <div class="selectContent">
                            <label for="3">&#128154;</label> <label for="3">일식</label>
                            <div>
                                <input type="radio" name="lunch" value="일식" id="3">
                            </div>
                        </div>
                        <div class="selectContent">
                            <label for="4">&#128155;</label> <label for="4">양식</label>
                            <div>
                                <input type="radio" name="lunch" value="양식" id="4">
                            </div>
                        </div>
                        <div class="selectContent">
                            <label for="5">&#128156;</label> <label for="5">기타</label>
                            <div>
                                <input type="radio" name="lunch" value="기타" id="5">
                            </div>
                        </div>
                    </div>
                    <div class="voteLunchInput">
                        <input type="hidden" name="diaryDate" value="<%=checkDate%>">
                        <button type="submit">투표</button>
                    </div>
                </form>
            </div>
            <%
            }
            %>
            <form method="post" action="/diary/diaryCalendar.jsp">
                <div class="prevBtn">
                    <button type="submit">이전</button>
                </div>
            </form>
            <%
            if (ck.equals("F")) {
            %>
            <div class="falseBtn">
                <form method="post" action="/diary/deleteLunchOne.jsp">
                    <div class="deleteBtn">
                        <input type="hidden" name="diaryDate" value="<%=checkDate%>">
                        <button type="submit">삭제</button>
                    </div>
                </form>
                <form method="post" action="/diary/statsLunch.jsp">
                    <div class="statsBtn">
                        <button type="submit">점심 통계</button>
                    </div>
                </form>
            </div>
            <%
            }
            %>
        </div>
    </div>
</body>
</html>