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

 	rs = stmt.executeQuery("select * from Item where Stock < 20");

	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount()-1;
	for(int i = 1;i<=cnt;i++)
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	while(rs.next()){
		out.println("<tr>");
		for(int i = 1;i<=cnt;i++)
			out.println("<td>"+rs.getString(i)+"</td>");
		String itemCode =  rs.getString(1);
		out.println("</tr>");
	}
	out.println("</table>");
	stmt.executeQuery(commit);

	
%>
</html>