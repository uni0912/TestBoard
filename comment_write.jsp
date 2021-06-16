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
        String boardid = request.getParameter("boardid");
        
        String commentid = request.getParameter("commentid");
        String commentcontent = request.getParameter("commentcontent");	
        String newcommentcontent = request.getParameter("newcommentcontent");	
        String commentdate = request.getParameter("commentdate");
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.73/kopoctc",                  
                                            "root" , "kopoctc");
        Statement stmt = conn.createStatement();
		String newdate = sd.format(date1);
		
    %>
    <%
        if (mode.equals("INSERT")) {
            out.println("<h2>추가</h2>");
            String sql = "insert into comment (boardid, commentcontent) values ('"
                        + boardid + "','"
						+ commentcontent + "');";
            stmt.execute(sql);
        } else if (mode.equals("UPDATE")) {
            out.println("<h2>수정</h2>");
            String sql = "update comment set commentcontent='"+newcommentcontent+"', where commentid="+commentid+";";
            stmt.executeUpdate(sql);
        } else if (mode.equals("DELETE")) {
            out.println("<h2>삭제</h2>");
            String sql = "delete from comment where commentid ="+commentid;
            stmt.executeUpdate(sql);
        }
    %>
    <%
		
        stmt.close();
        conn.close();
        response.sendRedirect("gongji_view.jsp?key="+boardid);
    %>
</body>
</html>