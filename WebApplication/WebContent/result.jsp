<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.text.*,java.sql.*,java.util.Date,test.RandStr" %>  
<%@page import="test.DBConn" %>  

   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>구매 페이지</title>
</head>
<body>
<%
	/*
	구현해야할기능 
	1. 바스켓컨테인 모드 지우기
	2. 아이템 갯수 줄이기(갯수 모자란거는 걸러주기)
	3. 오더컨테인 추가하기
	*/
	PreparedStatement pstmt = null;
	Connection conn = null;
	RandStr random = new RandStr();

		
	conn =DBConn.getMySqlConnection();  
	out.println("db conn : " + conn);
			
		
	ResultSet rs = null;
	String useDatabase = "USE ShoppingMallDB";	
	pstmt = conn.prepareStatement(useDatabase);	
	pstmt.executeQuery();
	
	String userId = (String) session.getAttribute("userId");

	
	
	// 아이템 오더를 새로 추가해준다.
	java.util.Date utilDate = new java.util.Date();
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	String OrderId = "IO-";
	OrderId += random.getString(20);
	 	
	pstmt = conn.prepareStatement("insert into ItemOrder values(?,?,?,?,?,?,?)");
	 	
	pstmt.setString(1,OrderId); // 오더아이디
	pstmt.setInt(2, 0); // 섬프라이스 
	pstmt.setDate(3,sqlDate); // 데이트
	pstmt.setString(4,"Waiting for payment"); // 오더 스테이터스
	pstmt.setString(5,userId); // 구매 고객
	pstmt.setString(6,"SL808"); // 고객의집
	pstmt.setString(7,(String)request.getParameter("shipper")); // 배달해줄사람
	//out.println(pstmt.toString());
	pstmt.executeUpdate();
	
	
	 	
	String baseketId = (String)request.getParameter("BasketId");;
	String qr = "";
	
	qr = "select Item.ItemCode, Item.ItemName,  Item.Specification, BasketContains.ItemCount, Item.ItemPrice*BasketContains.ItemCount from Item, Customer, ShoppingBasket, BasketContains "
	+" where  Customer.id = ? and ShoppingBasket.CustomerId = Customer.id "
	+" and BasketContains.CustomerId = Customer.id "
	+" and BasketContains.ShoppingBasketId = ShoppingBasket.ShoppingBasketId "
	+" and BasketContains.ItemCode = Item.ItemCode ";
		
	 pstmt = conn.prepareStatement(qr);
	 pstmt.setString(1,userId);
	 rs = pstmt.executeQuery();
	 // 주문추가하기
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	int price = 0;
		
	for(int i = 2;i<=cnt;i++)
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		out.println("<th>결과</th>");
	while(rs.next()){
		out.println("<tr>");
		for(int i = 2;i<=cnt;i++)
			out.println("<td>"+rs.getString(i)+"</td>");
		
		
		
		// 아이템의 갯수를 줄인다.솔트 카운터를 올린다.
		String itemCode = rs.getString(1);
		int count = rs.getInt("ItemCount");
		pstmt =conn.prepareStatement("select Stock from Item where ItemCode=?");
		pstmt.setString(1,itemCode);
		ResultSet rs2 = pstmt.executeQuery();
		rs2.next();
		 	

		 	
		if(rs2.getInt("Stock")> count)
		{
		price += Integer.parseInt(rs.getString(cnt)) * count;  // 구매 된거만 추가
		
		
		pstmt = conn.prepareStatement("update Item set Stock = Stock - ?,SoldCount = SoldCount + ?  where Itemcode = ?");
		pstmt.setInt(1,count);
		pstmt.setInt(2,count);
		pstmt.setString(3,itemCode);
		pstmt.executeUpdate();
			
		pstmt = conn.prepareStatement("delete from BasketContains where Itemcode = ?");
		pstmt.setString(1,itemCode);
		pstmt.executeUpdate();			
			
		pstmt = conn.prepareStatement("insert into OrderContains values(?,?,?,?)");
		pstmt.setString(1,itemCode); // 아이템 코드
		pstmt.setString(2,OrderId);  // 오더 아이디
		pstmt.setInt(3,rs.getInt(5));  // 구매가격
		pstmt.setInt(4,rs.getInt(4));  // 아이템 카운트
		pstmt.executeUpdate();
			
		out.println("<td>구매완료</td>");
		 }
		 else
		 {
		 	out.println("<td>재고부족</td>");
		 }
		out.println("</tr>");
	}
	out.println("</table>");
	out.println("배송정보:");
	out.println("<table border=\"1\">");
	if(price>0)
	{
		pstmt = conn.prepareStatement("select * from shipper where ShipperId=?");
		pstmt.setString(1,(String)request.getParameter("shipper"));
		rs = pstmt.executeQuery();
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		for(int i = 2;i<=cnt;i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
			out.println("<th>결과</th>");
		while(rs.next()){
			out.println("<tr>");
			for(int i = 2;i<=cnt;i++)
				out.println("<td>"+rs.getString(i)+"</td>");
			out.println("<td>배송준비중</td>");
			price+=rs.getInt(4);
		}
		pstmt = conn.prepareStatement("update ItemOrder set  SumPrice=? where OrderId = ?");
		pstmt.setInt(1,price);
		pstmt.setString(2,OrderId);
		pstmt.executeUpdate();
	}
	else
	{
		pstmt = conn.prepareStatement("delete from ItemOrder where ItemOrder.OrderId = ?");
		pstmt.setString(1,OrderId); // 오더아이디
		pstmt.executeUpdate();
		out.println("<th>배송할 물건이 없어서 배송 할수 없습니다.</th>");
	}
	out.println("</table>");
	
	out.println("<table border=\"1\">");
	out.println("<td>SumPrice:"+price+"</td>");
	out.println("<td>");
	out.print("<form action= \"Category.jsp\" method = \"POST\">");
	out.print("<input type = \"submit\" value = \"확인\">");
	out.println("</form>");
	out.println("</table>");
	out.println("</td>");
	
%>
</html>