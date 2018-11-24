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

	String userId = (String) session.getAttribute("userId");
	userId = "Ozrcsjorayzjuqx10";
	String baseketId = "";
	String itemCode = "";
	int itemCount=0;
	
	rs = stmt.executeQuery("select ShoppingBasketId from ShoppingBasket where CustomerId=\"Ozrcsjorayzjuqx10\"");
	rs.next();
	baseketId = (String)rs.getString("ShoppingBasketId");
	
	itemCode = (String)request.getParameter("code");
	itemCount  = Integer.parseInt(request.getParameter("count"));
	
	
	
	String qr = "insert into BasketContains values (\""+userId+"\",\""+baseketId+"\",\""+itemCode+"\",\""+itemCount+"\")";
	out.println(qr);
	stmt.executeQuery(qr);
	
	/*
 	
	qr = "select Item.ItemName,  Item.Specification, BasketContains.ItemCount,  Item.ItemPrice*ItemCount ";
	qr+= "from Item, Customer, ShoppingBasket, BasketContains";
	qr+= "where  Customer.id = \""+userId+"\" and ShoppingBasket.CustomerId = Customer.id ";
	qr+= "and BasketContains.CustomerId = Customer.id ";
	qr+= "and BasketContains.ShoppingBasketId = ShoppingBasket.ShoppingBasketId ";
	qr+=" and BasketContains.ItemCode = Item.ItemCode";
			
 	rs = stmt.executeQuery(qr);

	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	int price = 0;
	
	for(int i = 1;i<=cnt;i++)
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	
	while(rs.next()){
		out.println("<tr>");
		for(int i = 1;i<=cnt;i++)
			out.println("<td>"+rs.getString(i)+"</td>");
		price += Integer.parseInt(rs.getString(cnt));
		out.println("</tr>");
	}
	out.println("</table>");
	
	out.println("<table border=\"1\">");
	out.println("<td>"+price+"</td>");
	out.print("<form action= \"basket.jsp\" method = \"POST\">");
	out.println("<butten type=\"submit\">구매하기</button>");
	out.println("</form>");
	out.println("</table>"); */
%>
</html>