<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.*,java.sql.*" %>  
<%@page import="test.DBConn" %>  
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = DBConn.getMySqlConnection(); 
	//out.print("db conn : " + conn);
		
	Statement stmt = conn.createStatement();
	
	
	ResultSet rs = null;
	String useDatabase = "USE ShoppingMallDB";	
	stmt = conn.prepareStatement(useDatabase);	
	stmt.executeQuery(useDatabase);
	
	String readCommitted = "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;";
	String commit = "COMMIT";
	stmt.executeQuery(readCommitted);

	out.println("<table border=\"1\">");
	out.println("<th>ShipperName</th>");
	out.println("<th>Delivery times</th>");
	
	out.println("<tr>");
	rs = stmt.executeQuery("SELECT COUNT(*) FROM ItemOrder WHERE ShipperId=\"SH166\";");
	System.out.println("SELECT COUNT(*) FROM ItemOrder WHERE ShipperId=\"SH166\";");
	rs.next();
	out.println("<td>Mustang Express</td>");
	out.println("<td>" + rs.getInt(1) + "</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	rs = stmt.executeQuery("SELECT COUNT(*) FROM ItemOrder WHERE ShipperId=\"SH167\";");
	System.out.println("SELECT COUNT(*) FROM ItemOrder WHERE ShipperId=\"SH167\";");
	rs.next();
	out.println("<td>gate box</td>");
	out.println("<td>" + rs.getInt(1)+ "</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	rs = stmt.executeQuery("SELECT COUNT(*) FROM ItemOrder WHERE ShipperId=\"SH168\";");
	System.out.println("SELECT COUNT(*) FROM ItemOrder WHERE ShipperId=\"SH168\";");
	rs.next();
	out.println("<td>yellow coif</td>");
	out.println("<td>" + rs.getInt(1) + "</td>");
	out.println("</tr>");
	
	
	
	out.println("</table>");
	
	stmt.executeQuery(commit);
	
	%>
</body>
</html>