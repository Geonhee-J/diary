<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
    // 출력하고자 하는 달력의 년, 월 값을 넘겨받음
    String targetYear = request.getParameter("targetYear");
    String targetMonth = request.getParameter("targetMonth");
    
    // 오늘 날짜를 구하는 Calendar API
    Calendar target = Calendar.getInstance();
    Calendar now = Calendar.getInstance();
    
    // System.out.println("calendar target : " + target);
    
    // 년, 월 값을 넘겨받지 못 하면 현재 년, 월의 값을 새로 설정함
    // target.set(1, 2) -> 1) 설정할 년, 월 / 2) 값을 저장할 변수
    if (targetYear != null && targetMonth != null) {
        target.set(Calendar.YEAR, Integer.parseInt(targetYear));
        target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
        // System.out.println("calendar if targetYear : " + targetYear);
        // System.out.println("calendar if targetMonth : " + targetMonth);
    }
    // 시작 공백의 개수 -> 1일의 요일이 필요 -> 요일에 맵핑된 숫자 -> 타겟 날짜를 1일로 변경
    target.set(Calendar.DATE, 1);
    
    int tYear = target.get(Calendar.YEAR);
    int tMonth = target.get(Calendar.MONTH);
    // System.out.println("calendar tYear : " + tYear);
    // System.out.println("calendar tMonth : " + tMonth);
    
    int yoNum = target.get(Calendar.DAY_OF_WEEK); // 일:1, 월:2 ... 토:7
    
    // 시작 공백의 개수 -> 일요일 공백이 없고, 월요일은 1칸, 화요일은 2칸 ... yoNum - 1 공백의 개수
    int startBlank = yoNum - 1;
    
    int nowYear = now.get(Calendar.YEAR);
    int nowMonth = now.get(Calendar.MONTH);
    int nowDay = now.get(Calendar.DATE) + startBlank;
    // System.out.println("calendar nowYear : " + nowYear);
    // System.out.println("calendar nowMonth : " + nowMonth);
    // System.out.println("calendar nowDay : " + nowDay);
    
    // 타겟 달의 마지막 날짜 반환
    int lastDate = target.getActualMaximum(Calendar.DATE);
    int endBlank = 0;
    
    if ((startBlank + lastDate + endBlank) % 7 != 0) {
        endBlank = 7 - (((startBlank + lastDate) % 7));
    }
    // System.out.println("calendar startBlank : " + startBlank);
    // System.out.println("calendar lastDate : " + lastDate);
    // System.out.println("calendar endBlank : " + endBlank);
    
    // 필요한 <div> 태그의 개수
    int countDiv = startBlank + lastDate + endBlank;
    if (countDiv != 42) {
        countDiv = 42;
    }
    // System.out.println("calendar countDiv : " + countDiv);
    
    String[] yo = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT",};
%>