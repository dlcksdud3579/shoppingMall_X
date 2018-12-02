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
	
	out.println("<table border=\"1\">");
	String readCommitted = "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;";
	String commit = "COMMIT";
	stmt.executeQuery(readCommitted);
	
	String year = request.getParameter("yearInput");	
	if(year.equals(""))
	{
		rs = stmt.executeQuery("SELECT SUM(SumPrice) FROM ItemOrder;");
		rs.next();
		System.out.println("benefit: " + rs.getInt(1));
		out.println("<th>Whole Benefit</th>");
		out.println("<tr>");
		out.println("<td>" + rs.getInt(1) + "</td>");
		out.println("</tr>");
		return;
	}else{
		System.out.println(year);
	}
	
	String month =request.getParameter("monthInput");
	if(month == null)
	{
		out.println("<script>");
		out.println("alert('Please, put month')");	//경고 메시지 출력
		out.println("location='BenefitPage.html'");		//Benefit 페이지로 돌아감
		out.println("</script>");	       
	}
	
	String day =request.getParameter("dayInput");
	if(day.equals(""))
	{
		rs = stmt.executeQuery("SELECT SUM(SumPrice) FROM ItemOrder WHERE OrderDate LIKE '"+year+"-"+month+"-%';");
		rs.next();
		System.out.println("benefit: " + rs.getInt(1));
		out.println("<th>Monthly Benefit</th>");
		out.println("<tr>");
		out.println("<td>" + rs.getInt(1) + "</td>");
		out.println("</tr>");	
		return;
	}

	rs = stmt.executeQuery("SELECT SUM(SumPrice) FROM ItemOrder WHERE OrderDate LIKE '"+year+"-"+month+"-" + day + "';");
	rs.next();
	System.out.println("benefit: " + rs.getInt(1));
	out.println("<th>Monthly Benefit</th>");
	out.println("<tr>");
	out.println("<td>" + rs.getInt(1) + "</td>");
	out.println("</tr>");	
	
	out.println("</table>");
	stmt.executeQuery(commit);

%>
</body>
</html>