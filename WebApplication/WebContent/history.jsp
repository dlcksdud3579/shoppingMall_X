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
	String readCommitted = "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;";
	String commit = "COMMIT";
	try{
		
		conn =DBConn.getMySqlConnection();  
		//out.println("db conn : " + conn);
		
		ResultSet rs = null;
		String useDatabase = "USE ShoppingMallDB";	
		pstmt = conn.prepareStatement(useDatabase);	
		pstmt.executeQuery();
		pstmt.executeQuery(readCommitted);
	
	 	String userId = (String) session.getAttribute("userId");
	 	
		String baseketId = "";
		String itemCode = "";
		String qr = "";

		qr = "select OrderId, OrderDate,OrderStatus,ShipperName, SumPrice from ItemOrder,Shipper where PurchasedCustomerId = ? and ItemOrder.ShipperId=Shipper.ShipperId  order by OrderDate DESC";
	 	pstmt = conn.prepareStatement(qr);
	 	pstmt.setString(1,userId);
	 	rs = pstmt.executeQuery();
	
		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData(); 
		int cnt = rsmd.getColumnCount();
		
		for(int i = 2;i<=cnt;i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		out.println("<th>자세히</th>");
		while(rs.next()){
			out.println("<tr>");
			for(int i = 2;i<=cnt;i++)
				out.println("<td>"+rs.getString(i)+"</td>");
			out.print("<td><a href=\"details.jsp?OId="+rs.getString(1)+"\">자세히</a></td>");
			out.println("</tr>");
		}
		out.println("</table>");
		out.println("<a href=\"Category.jsp\">go Category</a>");
		
	}catch(Exception e){
		e.printStackTrace();
		out.println(e.toString());
		out.println("<br><a href=\"Category.jsp\">go Category</a>");
	}finally{
		pstmt.executeQuery(commit);
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		
	}

%>
</html>