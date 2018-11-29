<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.text.*,java.sql.*,java.util.Date,test.RandStr" %>  
<%@page import="test.DBConn" %>  

   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������</title>
</head>
<body>
<%
	/*
	�����ؾ��ұ�� 
	1. �ٽ��������� ��� �����
	2. ������ ���� ���̱�(���� ���ڶ��Ŵ� �ɷ��ֱ�)
	3. ���������� �߰��ϱ�
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

	
	
	// ������ ������ ���� �߰����ش�.
	java.util.Date utilDate = new java.util.Date();
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	String OrderId = "IO-";
	OrderId += random.getString(20);
	 	
	pstmt = conn.prepareStatement("insert into ItemOrder values(?,?,?,?,?,?,?)");
	 	
	pstmt.setString(1,OrderId); // �������̵�
	pstmt.setInt(2, 0); // �������̽� 
	pstmt.setDate(3,sqlDate); // ����Ʈ
	pstmt.setString(4,"Waiting for payment"); // ���� �������ͽ�
	pstmt.setString(5,userId); // ���� ��
	pstmt.setString(6,"SL808"); // ������
	pstmt.setString(7,(String)request.getParameter("shipper")); // ������ٻ��
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
	 // �ֹ��߰��ϱ�
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	int price = 0;
		
	for(int i = 2;i<=cnt;i++)
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		out.println("<th>���</th>");
	while(rs.next()){
		out.println("<tr>");
		for(int i = 2;i<=cnt;i++)
			out.println("<td>"+rs.getString(i)+"</td>");
		
		
		
		// �������� ������ ���δ�.��Ʈ ī���͸� �ø���.
		String itemCode = rs.getString(1);
		int count = rs.getInt("ItemCount");
		pstmt =conn.prepareStatement("select Stock from Item where ItemCode=?");
		pstmt.setString(1,itemCode);
		ResultSet rs2 = pstmt.executeQuery();
		rs2.next();
		 	

		 	
		if(rs2.getInt("Stock")> count)
		{
		price += Integer.parseInt(rs.getString(cnt)) * count;  // ���� �ȰŸ� �߰�
		
		
		pstmt = conn.prepareStatement("update Item set Stock = Stock - ?,SoldCount = SoldCount + ?  where Itemcode = ?");
		pstmt.setInt(1,count);
		pstmt.setInt(2,count);
		pstmt.setString(3,itemCode);
		pstmt.executeUpdate();
			
		pstmt = conn.prepareStatement("delete from BasketContains where Itemcode = ?");
		pstmt.setString(1,itemCode);
		pstmt.executeUpdate();			
			
		pstmt = conn.prepareStatement("insert into OrderContains values(?,?,?,?)");
		pstmt.setString(1,itemCode); // ������ �ڵ�
		pstmt.setString(2,OrderId);  // ���� ���̵�
		pstmt.setInt(3,rs.getInt(5));  // ���Ű���
		pstmt.setInt(4,rs.getInt(4));  // ������ ī��Ʈ
		pstmt.executeUpdate();
			
		out.println("<td>���ſϷ�</td>");
		 }
		 else
		 {
		 	out.println("<td>������</td>");
		 }
		out.println("</tr>");
	}
	out.println("</table>");
	out.println("�������:");
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
			out.println("<th>���</th>");
		while(rs.next()){
			out.println("<tr>");
			for(int i = 2;i<=cnt;i++)
				out.println("<td>"+rs.getString(i)+"</td>");
			out.println("<td>����غ���</td>");
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
		pstmt.setString(1,OrderId); // �������̵�
		pstmt.executeUpdate();
		out.println("<th>����� ������ ��� ��� �Ҽ� �����ϴ�.</th>");
	}
	out.println("</table>");
	
	out.println("<table border=\"1\">");
	out.println("<td>SumPrice:"+price+"</td>");
	out.println("<td>");
	out.print("<form action= \"Category.jsp\" method = \"POST\">");
	out.print("<input type = \"submit\" value = \"Ȯ��\">");
	out.println("</form>");
	out.println("</table>");
	out.println("</td>");
	
%>
</html>