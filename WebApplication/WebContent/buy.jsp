<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.text.*,java.sql.*" %>  
<%@page import="test.DBConn" %>  

   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>main Page</title>
</head>
<body>	
<%
	Connection conn = null;
	Statement stmt = null;
	String readCommitted = "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;";
	String commit = "COMMIT";
	
	try{
		
		conn = DBConn.getMySqlConnection();  
		out.print("db conn : " + conn);
		stmt = conn.createStatement();
	
		
		ResultSet rs = null;
		String useDatabase = "USE ShoppingMallDB";	
		stmt = conn.prepareStatement(useDatabase);	
		stmt.executeQuery(useDatabase);
		
		stmt.executeQuery(readCommitted);
	
	 	rs = stmt.executeQuery("select * from Item where ItemCode=\""+request.getParameter("code")+"\"");
	
		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount()-1;
		for(int i = 1;i<=cnt;i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		out.println("<th>buy</th>");
		rs.next();
		out.println("<tr>");
		for(int i = 1;i<=cnt;i++)
			out.println("<td>"+rs.getString(i)+"</td>");
		String itemCode =  rs.getString(1);
		out.println("</tr>");
		out.println("<tr>");
		
		out.print("<td>");
		out.print("<form action= \"basket.jsp\" method = \"POST\">");
		out.print("count:<input type = \"text\" name = \"count\">");
		out.print("<button type=\"submit\" value=\""+request.getParameter("code")+"\" name=\"code\">장바구니</button>");
		out.print("</form>");
		out.print("</td>");
		
		out.println("</tr>");
		out.println("</table>");
	}catch(Exception e){
		e.printStackTrace();
		out.println("이미 바구니에 담으신 제품입니다.");
		out.println("<br><a href=\"Category.jsp\">go Category</a>");
	}finally{
		stmt.executeQuery(commit);
		if(stmt != null) try{stmt.close();}catch(SQLException sqle){}
		if(stmt != null) try{stmt.close();}catch(SQLException sqle){}
		
	}

	
%>
</html>