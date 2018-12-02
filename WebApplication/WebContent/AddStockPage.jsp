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

 	rs = stmt.executeQuery("select * from Item");

	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount()-1;
	for(int i = 1;i<=cnt;i++)
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	out.println("<th>amount</th>");
	out.println("<th>add</th>");
	int count = 0;
	while(rs.next()){
		out.println("<tr>");
		for(int i = 1;i<=cnt;i++)
			out.println("<td>"+rs.getString(i)+"</td>");
		String itemCode =  rs.getString(1);
	%>
	   <form action = "AddStock.jsp" method = "POST">
		<td><input type="text" <%="name=addStock_" + rs.getString(1) %>><br></td>
		<td> <input type="submit" value="Add" name = "AddStockButton" ></td>
    </form>		
		<%
		
		//out.println("</tr>");
		count++;
		 
	}
	stmt.executeQuery(commit);
	
	out.println("</table>");
	%>

	
%>
</html>