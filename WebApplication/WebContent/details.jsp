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
<h4>detail</h4>
<%

	PreparedStatement pstmt = null;
	Connection conn = DBConn.getMySqlConnection(); 
	//out.print("db conn : " + conn);
		
	Statement stmt = conn.createStatement();
	
	
	ResultSet rs = null;
	String useDatabase = "USE ShoppingMallDB";
	stmt = conn.prepareStatement(useDatabase);
	stmt.executeQuery(useDatabase);
	
	 //"select ItemName,Specification, ItemCount ,PurchasedPrice from Item,ItemOrder,OrderContains where ItemOrder.OrderId = IO-4E1Um06252Bz7FV25e8t and ItemOrder.OrderId=OrderContains.OrderId and OrderContains.ItemCode = Item.ItemCode";

	String qr =  "select ItemName,Specification, ItemCount ,PurchasedPrice "
			+ "from Item,ItemOrder,OrderContains "
			+ "where ItemOrder.OrderId = ? and ItemOrder.OrderId=OrderContains.OrderId and OrderContains.ItemCode = Item.ItemCode";
	
	pstmt = conn.prepareStatement(qr);
	
 	pstmt.setString(1,request.getParameter("OId"));
 	rs = pstmt.executeQuery();
 	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
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
	
	qr =  "select ShipperName, ShippingFee from ItemOrder,Shipper where ItemOrder.OrderId = ? and ItemOrder.ShipperId = Shipper.ShipperId";
	
	pstmt = conn.prepareStatement(qr);
 	pstmt.setString(1,request.getParameter("OId"));
 	System.out.println(pstmt.toString());
 	rs = pstmt.executeQuery();
 	
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
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
	
	
	
	
	out.println("<a href=\"Category.jsp\">go Category</a>");

	
%>
</html>