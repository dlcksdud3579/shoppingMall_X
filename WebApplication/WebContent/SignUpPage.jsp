<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%

	Class.forName("com.mysql.jdbc.Driver");	
	String serverIP = "localhost";
	String portNum = "3306";
	String url = "jdbc:mysql://localhost:" + portNum;
	String dbUser= "knu";
	String dbPassword = "comp322";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//DB와 연결
	conn = DriverManager.getConnection(url,dbUser,dbPassword);
	
	//우리가 만든 DB를 USE 하라고 쿼리를 보냄
	String useDatabase = "USE ShoppingMallDB;";	
	pstmt = conn.prepareStatement(useDatabase);	
	pstmt.executeQuery();
	
	String serializableCommitted = "SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;";
	String commit = "COMMIT";
	pstmt.executeQuery(serializableCommitted);
	
	String Id = request.getParameter("idInput");
	Id = "'" + Id + "'";
	String Password = request.getParameter("passwordInput");
	Password = "'" + Password + "'";
	String HomeAddress =request.getParameter("HomeAddressInput");
	if(HomeAddress != null)
		HomeAddress = "'" + HomeAddress + "'";
	else
		HomeAddress = "NULL";
	String PhoneNumber = request.getParameter("PhoneNumberInput");
	if(PhoneNumber != null)
		PhoneNumber = "'" + PhoneNumber + "'";
	else
		PhoneNumber = "NULL";
	String Sex = request.getParameter("SexSelect");
	Sex = "'" + Sex + "'";
	String Job = request.getParameter("JOBInput");
	if(Job != null)
		Job = "'" + Job + "'";
	else
		Job = "NULL";
	String name = request.getParameter("NameInput");
	if(name != null)
		name = "'" + name + "'";
	else
		name = "NULL";
	int age = Integer.parseInt(request.getParameter("AgeInput"));
	String type = request.getParameter("TypeSelect");
	if(type.compareTo("NULL") != 0)
		type = "'" + type + "'";
	
	//회원 추가
	String SignUpQuery = "INSERT INTO Customer VALUES(" + Id + ","+Password +"," + HomeAddress + "," + PhoneNumber + "," + Sex + ","+ name +"," + age + "," +Job +"," + type + ");";
	pstmt = conn.prepareStatement(SignUpQuery);
	System.out.println("query : " + SignUpQuery);
	
	//예외 처리
	try{
		pstmt.executeUpdate();
	}	catch(Exception e){
		//회원가입 페이지러 돌아감
       out.println("<script>");
       out.println("alert('Sign up Failed')" );	//실패했다고 출력
       out.println("location='SignupPage.html'");	//회원가입 페이지로 돌아감
       out.println("</script>");       
		return;
	}
	
	//장바구니 추가
	String createBasketQuery = "INSERT INTO ShoppingBasket VALUES(" + "\"basket\"," + "0," + Id + ");";
	
	pstmt = conn.prepareStatement(createBasketQuery);
	System.out.println("query : " + createBasketQuery);
	
	//예외 처리
	try{
		pstmt.executeUpdate();
		pstmt.executeQuery(commit);
	}	catch(Exception e){
		pstmt.executeQuery(commit);
		//회원가입 페이지러 돌아감
       out.println("<script>");
       out.println("alert('basket making Failed')" );	//실패했다고 출력
       out.println("location='SignupPage.html'");	//회원가입 페이지로 돌아감
       out.println("</script>");       
		return;
	}
	session.setAttribute("userId",Id);
		out.println("<script>");
	   out.println("alert('Sign up Success')");	//성공했다고 출력
	   out.println("location='recommend.jsp'");	//로그인 페이지로 돌아감
	   out.println("</script>");	       

	
	
%>
</body>
</html>