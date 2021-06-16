<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, java.util.Date, java.text.*, java.util.TimeZone" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        function submitForm(mode){
            fm.action = "gongji_write.jsp?key=INSERT";
            fm.submit();
        }
    </script>
</head>
<body>
    <%
        TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
        Date date = new Date();
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sd.setTimeZone(time);
    %>
    <form method="POST" name="fm">

        <table border="1px solid black">
            <tr>
                <td>글 번호</td>
                <td>신규(insert)<input type="hidden" name="id" value='INSERT'></td>
            </tr>
            <tr>
                <td>글 제목</td>
                <td><input type="text" name="title"></td>
            </tr>
            <tr>
                <td>등록일자</td>
                <td><%out.println(sd.format(date));%><input type="hidden" name="date" value="<%out.println(sd.format(date));%>"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea style="width: 500px; height: 250px;" name="content" cols="70" rows="600"></textarea></td>
            </tr>
        </table>
        <table>
            <tr>
                <td width=500></td>
                <td><input type="button" value="취소" onclick="location.href='gongji_list.jsp?page=1'"></td>
                <td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
            </tr>
        </table>
    </form>
</body>
</html>