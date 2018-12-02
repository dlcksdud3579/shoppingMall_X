<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Successful Page</title>
</head>
<body>
<%@ page language="java" import="java.text.*,java.sql.*" %>
connected user : 
	<form action = "EditMembershipInfoPage.html" method = "POST">
           <input type="submit" value="EditButton" name = "EditButton"> 	
   	</form>     
<%
	String userId = (String) session.getAttribute("userId");
	out.println(userId);
%>
</body>
</html>