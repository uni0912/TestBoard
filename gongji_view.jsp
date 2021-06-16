<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, java.util.Date, java.text.*, java.util.TimeZone" %>

<%
TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
Date date = new Date();
SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
sd.setTimeZone(time);
%>
<%
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    Connection conn=DriverManager.getConnection("jdbc:mysql://192.168.23.73/kopoctc", "root" , "kopoctc" ); 
    Statement stmt=conn.createStatement(); 

    String id = request.getParameter( "key" );

    int boardid = 0, boardview = 0;
    String boardtitle="", boarddate="", boardcontent="";

        
    ResultSet rset=stmt.executeQuery("select * from gongji where id='"+id+"';"); 
          
		while (rset.next()) {
            boardid = rset.getInt(1);
            boardtitle = rset.getString(2);
            boardview = rset.getInt(3);
            boarddate = rset.getString(4);
            boardcontent = rset.getString(5);
            boardview++;
		}
       
    stmt.executeUpdate("update gongji set viewcnt='"+boardview+"' where id="+id+";");
        %>
<!DOCTYPE html>        
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script languate="JavaScript">
        function submitForm(mode) {
            if (mode == "write") {
                fm.action = "comment_write.jsp?key=INSERT";
            } else if (mode == "delete") {
                fm.action = "comment_write.jsp?key=DELETE";
            } else if (mode == "update") {
                fm.action = "comment_write.jsp?key=UPDATE";
            }
            fm.submit();
        }

        $(".delete").on("click", submitForm('delete'));
    </script>
</head>
<body>
    <h2>[ <%=boardid%> ]번 게시글</h2>
    <form method="POST" name="fmboard">
        <table border="1px solid black">
            <tr>
                <td>글 번호</td>
                <td><input type="hidden" name="id" value="<%=boardid%>" readonly><%=boardid%></td>
            </tr>
            <tr>
                <td>글 제목</td>
                <td><input type="hidden" name="boardtitle" value="<%=boardtitle%>" readonly><%=boardtitle%></td>
            </tr>
            <tr>
                <td>조회수</td>
                <td><input type="hidden" name="boardview" value="<%=boardview%>" readonly><%=boardview%></td>
            </tr>
            <tr>
                <td>등록일자</td>
                <td><input type="hidden" name="boarddate" value="<%=boarddate%>" readonly><%=boarddate%></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea style="width: 500px; height: 250px;" name="content" cols="70" rows="600" readonly><%=boardcontent%></textarea></td>
            </tr>
</table>
<table>
    <tr>
        <td width=500></td>
        <td><input type="button" value="목록" onclick="location.href='gongji_list.jsp?page=1'"></button></td>
        <td><input type="button" value="수정" onclick="location.href='gongji_update.jsp?key=<%=id%>'"></td>
    </tr>
</table>
</form>
<form method="POST" name="fm">
<table border="1px solid black">

    <tr>
        <td><input type="hidden" name="boardid" value="<%=boardid%>">댓글</td>
        <td><input type="text" name="commentcontent"></td>
        <td><button onclick="submitForm('write')">댓글입력</button></td>
    </tr>
    </table>
    
    <table>
    <%

        rset = stmt.executeQuery("select * from comment where boardid = '"+id+"';");

        while (rset.next()) {
            
            out.println("<tr>");
            out.println("<td><input type=hidden name=boardid value="+rset.getInt(1)+"></td>");
            out.println("<td><input type=hidden name=commentid value="+rset.getInt(2)+"></td>");
            out.println("<td><input type=hidden name=newcommentcontent value="+rset.getString(3)+">"+rset.getString(3)+"</td>");
            out.println("<td><input type=hidden name=commentdate value="+rset.getString(4)+">"+rset.getString(4)+"</td>");
            out.println("<td><button class='update'>수정</button></td>");
            out.println("<td><button class='delete'>삭제</button></td>");
            out.println("</tr>");
            }
            rset.close();
            stmt.close();
            conn.close();
    %>
</table>
</form>
</body>
</html>