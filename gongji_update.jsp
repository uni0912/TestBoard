<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, java.util.Date, java.text.*, java.util.TimeZone" %>

<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script language="JavaScript">
        function submitForm(mode) {
            if (mode == "write") {
                fm.action = "gongji_write.jsp?key=UPDATE";
            } else if (mode == "delete") {
                fm.action = "gongji_write.jsp?key=DELETE";
            }
            fm.submit();
        }

    </script>
</head>
<body>
    <%
        TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
        Date date1 = new Date();
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sd.setTimeZone(time);
    %>
    <%
    String newdate = sd.format(date1);
    String num = request.getParameter( "key" );
    Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.73/kopoctc",                  
                                            "root" , "kopoctc");
        Statement stmt = conn.createStatement();

        ResultSet rset = stmt.executeQuery("select * from gongji where id='"+num+"';");
    %>

    <form method="POST" name="fm">
        <table border="1px solid black">
            <%
                while (rset.next()) {
                    out.println("<tr><td>글 번호</td>");
                    out.println("<td><input type=text name=id value="+rset.getInt(1)+" readonly></td></tr>");
                    out.println("<tr><td>글 제목</td>");
                    out.println("<td><input type=text name=title value="+rset.getString(2)+"></td></tr>");
                    out.println("<tr><td>조회수</td>");
                        out.println("<td><input type=hidden name=viewcnt value="+rset.getInt(3)+" readonly>"+rset.getInt(3)+"</td></tr>");
                    out.println("<tr><td>등록일자</td>");
                    out.println("<td><input type=hidden name=date value="+newdate+" readonly>"+sd.format(date1)+"</td></tr>");
                    out.println("<tr><td>내용</td>");
                    out.println("<td><textarea style='width: 500px; height: 250px;' name=content cols=70 rows=600>"+rset.getString(5)+"</textarea></td></tr>");
                }
                rset.close();     
                stmt.close();
                conn.close();	
            %>

        </table>
        <table>
            <tr>
                <td width=450></td>
                <td><input type="button" value="취소" onclick="location.href='gongji_list.jsp'"></td>
                <td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
                <td><input type="button" value="삭제" onclick="submitForm('delete')"></td>
            </tr>
        </table>
    </form>
</body>
</html>