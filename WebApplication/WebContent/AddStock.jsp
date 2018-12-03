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
	
	String readCommitted = "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;";
	String commit = "COMMIT";
	stmt.executeQuery(readCommitted);
	
	String selectAllNames = "SELECT ItemCode FROM Item;";
	rs = stmt.executeQuery(selectAllNames);
	
	
	String inputSource = "";
	String itemCode = null;
	while(rs.next()){
		inputSource = "addStock_" + rs.getString(1);
		System.out.println(inputSource);
		if(request.getParameter(inputSource)!=null){
			itemCode = rs.getString(1);
			break;		
		}
	}
	
	if(itemCode == null)
	{
		out.println("<script>");
		out.println("alert('Please, input amount you want to add')");	//��� �޽��� ���
		out.println("location='AddStockPage.jsp'");	
		out.println("</script>");
	}
	
	String updateQuery = "UPDATE Item SET Stock = Stock + " +request.getParameter(inputSource) + " WHERE ItemCode = \"" + itemCode + "\"";
	out.println(updateQuery);
	stmt.executeUpdate(updateQuery);
	stmt.executeQuery(commit);
	
    out.println("<script>");
    out.println("alert('Add Stock Successful!')" );
    out.println("location='AddStockPage.jsp'");	//��� �߰� �������� ���ư�
    out.println("</script>");   
%>
</html>