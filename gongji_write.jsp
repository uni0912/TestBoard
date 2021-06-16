<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, java.util.Date, java.text.*, java.util.TimeZone" %>

<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
    <%
        TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
        Date date1 = new Date();
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sd.setTimeZone(time);
    %>
    <%
        request.setCharacterEncoding("utf-8");
        String mode = request.getParameter("key");
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String date = request.getParameter("date");	
        String content = request.getParameter("content");
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.73/kopoctc",                  
                                            "root" , "kopoctc");
        Statement stmt = conn.createStatement();
		String newdate = sd.format(date1);
		
    %>
    <%
        if (mode.equals("INSERT")) {
            out.println("<h2>추가</h2>");
            String sql = "insert into gongji (title, content) values ('"
						+ title + "','"
                        + content + "');";
            stmt.executeUpdate(sql);
        } else if (mode.equals("UPDATE")) {
            out.println("<h2>수정</h2>");
            String sql = "update gongji set title='"+title+"', date='"+newdate+"', content='"+content+"' where id="+id+";";
            stmt.executeUpdate(sql);
        } else if (mode.equals("DELETE")) {
            out.println("<h2>삭제</h2>");
            String sql = "delete from gongji where id ="+id;
            stmt.executeUpdate(sql);
			String sql1 = "delete from comment where boardid = "+id;
			stmt.executeUpdate(sql1);
        }
    %>
    <%
		
        stmt.close();
        conn.close();
        response.sendRedirect("gongji_list.jsp?page=1");
    %>
</body>
</html>