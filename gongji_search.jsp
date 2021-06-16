<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, java.util.Date, java.text.*" %>

<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
<body>
    <%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    Connection conn=DriverManager.getConnection("jdbc:mysql://192.168.23.73/kopoctc", "root" , "kopoctc" ); 
    Statement stmt=conn.createStatement(); 
    String searchtitle = request.getParameter( "search" );
    
    int searchcnt = 0;
    ResultSet rset1 = stmt.executeQuery("select count(id) from gongji where title LIKE '%"+searchtitle+"%';"); 

    while (rset1.next()) {
        searchcnt = rset1.getInt(1);
    }

    %>

        <h2>[ <%=searchtitle%> ] 검색결과:</h2>
        <div>[ <%=searchcnt%> ]건 검색되었습니다. </div>

        <table border="1px solid black" width=600>
            <tr>
                <td>번호</td>
                <td width=300>제목</td>
                <td>조회수</td>
                <td>등록일자</td>
            </tr>

            <% 
            ResultSet rset=stmt.executeQuery("select id, title, viewcnt, date from gongji where title LIKE '%"+searchtitle+"%' order by id desc;"); 
            while (rset.next()) {
                int id = rset.getInt(1);
                out.println("<tr>");
                out.println("<td><a href='gongji_view.jsp?key="+id+"' target='main'>"+rset.getInt(1)+"</a></td>");
                out.println("<td><a href='gongji_view.jsp?key="+id+"' target='main'>"+rset.getString(2)+"</a></td>");
                out.println("<td>"+rset.getString(3)+"</td>");
                out.println("<td>"+rset.getString(4)+"</td>");
                out.println("</tr>");
                }
                rset.close();
                stmt.close();
                conn.close();
                %>

        </table>
        
        <table>
            <tr>
                <td>
                    <button onclick="location.href='gongji_list.jsp?page=1'">홈으로</button>
                </td>
                <td>
                    <button onclick="location.href='gongji_insert.jsp'">글쓰기</button>
                </td>
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