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

		qr = "select OrderId, OrderDate,OrderStatus,ShipperName, SumPrice from ItemOrder,Shipper where ItemOrder.ShipperId=Shipper.ShipperId  order by OrderDate DESC";
	 	pstmt = conn.prepareStatement(qr);
	 	rs = pstmt.executeQuery();
	
		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		
		for(int i = 2;i<=cnt;i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		out.println("<th>�ڼ���</th>");
		while(rs.next()){
			out.println("<tr>");
			for(int i = 2;i<=cnt;i++)
				out.println("<td>"+rs.getString(i)+"</td>");
			out.print("<td><a href=\"details.jsp?OId="+rs.getString(1)+"\">�ڼ���</a></td>");
			out.println("</tr>");
		}
		out.println("</table>");
		out.println("<a href=\"Category.jsp\">go Category</a>");
		
	}catch(Exception e){
		e.printStackTrace();
		out.println(e.toString());
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
	}

%>
</html>