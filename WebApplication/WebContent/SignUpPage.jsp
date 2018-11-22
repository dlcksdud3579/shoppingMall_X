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
	//로그인 쿼리
	String SignUpQuery = "INSERT INTO Customer VALUES(" + Id + ","+Password +"," + HomeAddress + "," + PhoneNumber + "," + Sex + ","+ name +"," + age + "," +Job +"," + type + ");";
	pstmt = conn.prepareStatement(SignUpQuery);
	System.out.println("query : " + SignUpQuery);
	
	//예외 처리
	try{
		pstmt.executeUpdate();
	}	catch(Exception e){
		//회원가입 페이지러 돌아감
       out.println("<script>");
       out.println("alert('Sign up Failed')" );
       out.println("location='SignupPage.html'");
       out.println("</script>");       
		return;
	}		
	
		out.println("<script>");
	   out.println("alert('Sign up Success')");	//경고 메시지 출력
	   out.println("location='loginPage.html'");	//로그인 페이지로 돌아감
	   out.println("</script>");	       

	
	
%>
</body>
</html>