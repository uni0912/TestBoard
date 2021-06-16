<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
<body>
    <%
    
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    Connection conn=DriverManager.getConnection("jdbc:mysql://192.168.23.73/kopoctc", "root" , "kopoctc" ); 
    Statement stmt=conn.createStatement(); 

    ResultSet rset = stmt.executeQuery("select count(*) from gongji;");
    
    int commentcnt = 0; //댓글 개수
    int totalCount = 0; //총 게시물 수

    while (rset.next()) {
        totalCount = rset.getInt(1); //총 게시물 수
    }
     
    %>
        <h1>자유게시판</h1>
        <div>총 게시물은 [ <%=totalCount%> ] 건입니다.</div>

        <table border="1px solid black" width = 600>
            <tr>
                <td>번호</td>
                <td  width=300>제목</td>
                <td>조회수</td>
                <td>등록일자</td>
            </tr>

            <%
                //페이지설정
                int currentPage = Integer.parseInt(request.getParameter("page")); //현재 페이지 숫자

                int countList = 10; //한 페이지에 출력할 게시물 수

                int totalPage = totalCount / countList; //필요한 총 페이지 수 계산식 = 총 게시물 / 한페이지 출력수
            
                if ((totalCount % countList) > 0) {
                    totalPage++;    //총 게시물 수가 10으로 나누어떨어지지 않으면 한페이지 더 필요
                }

                if (totalPage < currentPage) {
                    currentPage = totalPage;    //현재페이지가 총 페이지 수보다 크다면 현재페이지를 총 페이지수로 강제 치환
                }

                int countPage = 10; //한 화면에 나타날 페이지 개수(1-10, 11-20...)

                int startPage = ((currentPage - 1) / 10) * 10 + 1; //시작페이지 넘버는 현재페이지가 10일때까지 1이 나오도록 설정

                int endPage = startPage + countPage - 1; //시작페이지에 페이지 개수를 더하고 1을 빼서 마지막페이지가 10까지만 나오도록

                if (endPage > totalPage) {
                    endPage = totalPage;    //마지막페이지가 총 페이지수보다 크면 보정
                }
                %>
        <% 
        
        int startCount = (currentPage - 1) * countList + 1; //현재페이지의 첫번째 게시물 번호 구하는 계산식 = 1페이지에서는 1번부터 시작
        
        int endCount = currentPage * countList; // 현재페이지에서 마지막 게시물 번호 구하는 계산식. 1페이지에서는 10번까지 표시
        
        //쿼리문에 limit 시작게시글(startCount), 출력할 게시물 수(countList) 를 마지막에 넣어 처리   
        rset = stmt.executeQuery("select a.id, a.title, count(b.boardid), a.viewcnt, a.date from gongji as a left outer join comment as b on a.id=b.boardid group by a.id order by a.id desc limit "+(startCount-1)+","+ countList+ ";");
        
        while (rset.next()) {
            int id = rset.getInt(1);
            out.println("<tr>");
            out.println("<td><a href='gongji_view.jsp?key="+id+"' style='text-decoration: none;'>"+rset.getInt(1)+"</a></td>");
            out.println("<td><a href='gongji_view.jsp?key="+id+"' style='text-decoration: none;'>"+rset.getString(2)+"("+rset.getString(3)+")</a></td>");
            out.println("<td >"+rset.getString(4)+"</td>");
            out.println("<td>"+rset.getString(5)+"</td>");
            out.println("</tr>");
            }
            rset.close();
            stmt.close();
            conn.close();
            %>

        </table>
        <div border="1px solid black">
            
            
                <%

                if (startPage > 1) {
                    out.println("<span><a href='gongji_list.jsp?page=1'>처음</a></span>");
                }

                if (currentPage > 1) {
                    out.println("<span><a href='gongji_list.jsp?page="+(currentPage-1)+"'>이전</a></span>");
                }

                for (int i = startPage; i <= endPage; i++){
                    if (i == currentPage) {
                        out.println("<span><b><a href='gongji_list.jsp?page="+i+"'>"+i+"</a></b></span>");   //현재페이지 볼드처리
                    } else {
                        out.println("<span><a href='gongji_list.jsp?page="+i+"'>"+i+"</a></span>");  //나머지는 보통굵기
                    }
                }

                if (currentPage < totalPage) {
                    out.println("<span><a href='gongji_list.jsp?page="+(currentPage+1)+"'>다음</a></span>");
                }
                
                if (endPage < totalPage) {
                    out.println("<span><a href='gongji_list.jsp?page="+totalPage+"'>끝</a></span>");
                }
            %>



        </div>
        <table>
            <tr>
                <td><button onclick="location.href='gongji_insert.jsp'">글쓰기</button></td>
                <td>
                    <form action="gongji_search.jsp" method="POST" name="fm">
                        <input type="text" name="search">
                        <button onclick="location.href='gongji_search.jsp'">검색</button>
                    </form>
                    </td>
            </tr>
        </table>
        
</body>
</html>