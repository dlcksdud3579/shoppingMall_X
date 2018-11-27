<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.text.*,java.sql.*"%>  
<%@page import="test.DBConn" %>  

   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>main Page</title>
</head>
<body>	
<%

	PreparedStatement pstmt = null;
	Connection conn = null;
	try{
		
		conn =DBConn.getMySqlConnection();  
		//out.println("db conn : " + conn);
		
		ResultSet rs = null;
		String useDatabase = "USE ShoppingMallDB";	
		pstmt = conn.prepareStatement(useDatabase);	
		pstmt.executeQuery();
	
	 	String userId = (String) session.getAttribute("userId");
	 	userId = "Ozrcsjorayzjuqx10";
	 	
		String baseketId = "";
		String itemCode = "";
		String qr = "";
		int itemCount=0;
		pstmt = conn.prepareStatement("select ShoppingBasketId from ShoppingBasket where CustomerId=\""+userId+"\"");
		rs = pstmt.executeQuery();
		
		rs.next();
		baseketId = (String)rs.getString("ShoppingBasketId");
		
		itemCode = (String)request.getParameter("code");
		itemCount  = Integer.parseInt(request.getParameter("count"));
		
		
		if(itemCount>0)
		{
			//qr = "insert into BasketContains values(\""+userId+"\", \""+baseketId+"\", \""+itemCode+"\", "+itemCount+")";
			qr = "insert into BasketContains values(?,?,?,?)";
			pstmt = conn.prepareStatement(qr);
			pstmt.setString(1,userId);
			pstmt.setString(2,baseketId);
			pstmt.setString(3,itemCode);
			pstmt.setInt(4,itemCount);  // 아이템의 갯수
			pstmt.executeUpdate();
		}
		
		
		qr = "select Item.ItemName,  Item.Specification, BasketContains.ItemCount,  Item.ItemPrice*ItemCount from Item, Customer, ShoppingBasket, BasketContains "
		+" where  Customer.id = ? and ShoppingBasket.CustomerId = Customer.id "
		+" and BasketContains.CustomerId = Customer.id "
		+" and BasketContains.ShoppingBasketId = ShoppingBasket.ShoppingBasketId "
		+" and BasketContains.ItemCode = Item.ItemCode ";
		
	 	pstmt = conn.prepareStatement(qr);
	 	pstmt.setString(1,userId);
	 	rs = pstmt.executeQuery();
	 	
	
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
		out.println("<td>sumPrice: "+price+"</td>");
		out.println("<td>");
		out.print("<form action= \"result.jsp\" method = \"POST\">");
		out.println("<input type=\"hidden\" name=BasketId value=\""+baseketId+"\" >");
		out.println("<input type=\"hidden\" name=price value=\""+price+"\" >");
		out.print("<input type = \"radio\" name= \"shipper\" value = \"SH166\">7일[2000]");
		out.print("<input type = \"radio\" name= \"shipper\" value = \"SH167\" checked=\"checked\">2~3일[3000]");
		out.print("<input type = \"radio\" name= \"shipper\" value = \"SH168\">당일[5000]");
		out.print("<input type = \"submit\" value = \"submit\">");
		out.println("</form>");
		out.println("</table>");
		out.println("</td>");
	}catch(Exception e){
		e.printStackTrace();
		out.println("이미 바구니에 담으신 제품입니다.");
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
	}

%>
</html>