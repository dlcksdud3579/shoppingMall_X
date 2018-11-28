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
	out.print("db conn : " + conn);
		
	Statement stmt = conn.createStatement();
	
	
	ResultSet rs = null;
	String useDatabase = "USE ShoppingMallDB";	
	stmt = conn.prepareStatement(useDatabase);	
	stmt.executeQuery(useDatabase);

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
		<td><input type="text" <%="id=addStock" + count %>><br></td>"
		<td><a href=<%="AddStock.jsp?code="+itemCode+"&addStock=" + request.getParameter("addStock" + count) %> >add</a></td>" 
		
		<%
		out.println("</tr>");
		count++;
		 
	}
	%>
	out.println("</table>");
	

	
%>
</html>