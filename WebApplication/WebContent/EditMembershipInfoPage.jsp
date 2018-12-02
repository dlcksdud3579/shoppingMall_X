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
	

	conn = DriverManager.getConnection(url,dbUser,dbPassword);
	

	String useDatabase = "USE ShoppingMallDB;";	
	pstmt = conn.prepareStatement(useDatabase);	
	pstmt.executeQuery();
	
	String readCommitted = "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;";
	String commit = "COMMIT";
	pstmt.executeQuery(readCommitted);
	
	String Id = (String) session.getAttribute("userId");
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
	String updateQuery = "UPDATE Customer SET Password=" + Password +",HomeAddress=" + HomeAddress + ",PhoneNumber=" + PhoneNumber + ",Sex=" + Sex + ",Name="+ name +",AGE=" + age + ",JOB=" +Job +",Type=" + type + " WHERE Id ="+ Id +";";
	pstmt = conn.prepareStatement(updateQuery);
	System.out.println("query : " + updateQuery);
	
	
	
	//예외 처리
	try{
		pstmt.executeUpdate();
		pstmt.executeQuery(commit);
	}	catch(Exception e){
		//회원가입 페이지로 돌아감
		pstmt.executeQuery(commit);
       out.println("<script>");
       out.println("alert('Edit  Failed')" );	//경고 메시지
       out.println("location='EditMembership.html'");	//정보수정 페이지로 돌아감
       out.println("</script>");       
		return;
	}
	
		out.println("<script>");
	   out.println("alert('Edit Success')");	//성공했다고 출력
	   out.println("location='Category.jsp'");	//로그인 성공 페이지로 돌아감
	   out.println("</script>");	       

	
	
%>
</body>
</html>