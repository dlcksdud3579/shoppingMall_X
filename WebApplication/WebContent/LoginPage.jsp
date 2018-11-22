<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
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
	
	//로그인 쿼리
	String loginQuery = "SELECT * FROM Customer WHERE\n" + 
			"Customer.id = '" + request.getParameter("idInput") + "'\n" + 
			"AND Customer.password = '" + request.getParameter("passwordInput") + "';";
	pstmt = conn.prepareStatement(loginQuery);
	System.out.println(loginQuery);
	
	//예외 처리
	try{
		rs = pstmt.executeQuery();
	}	catch(Exception e){
		//로그인 페이지로 돌아감
       out.println("<script>");
       out.println("alert('INVALID INPUT')");
       out.println("location='loginPage.html'");
       out.println("</script>");       
		return;
	}		
	
	//ID와 Password가 일치하는 Customer가 있다면
	if(rs.next()){
		//로그인 성공 페이지로 넘어감
		String userId = rs.getString("Id");
		session.setAttribute("userId",userId);
		out.println("<script>");
	   	out.println("location='LoginSuccessfulTestPage.jsp'");
	  	out.println("</script>");
	}
	else{	//ID와 Password가 일치하는 Customer가 없는 경우
		out.println("<script>");
	   out.println("alert('ID/PASSWORD WRONG')");	//경고 메시지 출력
	   out.println("location='loginPage.html'");	//로그인 페이지로 돌아감
	   out.println("</script>");	       
	}

	
	
%>
</body>
</html>