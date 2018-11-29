<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.text.*,java.sql.*" %>  
<%@page import="test.DBConn" %>  

   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>main Page</title>
</head>
<body>	
<%
	Connection conn = DBConn.getMySqlConnection(); 
	out.print("db 연결정보 : " + conn);
		
	Statement stmt = conn.createStatement();
	
	
	ResultSet rs = null;
	String useDatabase = "USE ShoppingMallDB";	
	stmt = conn.prepareStatement(useDatabase);	
	stmt.executeQuery(useDatabase);

 	rs = stmt.executeQuery("select distinct MainCategoryName from Category");

    
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = 0;
	String[] mainCName = new String[3];
	String middleCName = "";
	String smallCName = "";
	String Cid = "";
	
	if(rs.next())
	{
		do{
			out.print("<th>");
			mainCName[cnt++] = rs.getString("MainCategoryName");
			out.print(mainCName[cnt-1]);
			out.print("</th>");
		}while(rs.next());
	} else{
		out.print("검색 결과가 없습니다.");
	}
	
	out.println("<tr>");
	
 	for(int i= 0; i < cnt;i++)
	{
		out.println("<td>");
		out.println("<table border=\"1\">");
		rs = stmt.executeQuery("select * from Category where  MainCategoryName=\""+mainCName[i]+"\"");
		if(rs.next())
		{
			do{
				if(middleCName.equals(rs.getString("MiddleCategoryName")) == false)
				{
					out.println("<tr>");
					out.print("<th>");
					middleCName = rs.getString("MiddleCategoryName");
					
					out.print(middleCName);
					out.print("</th>");
					out.print("</tr>");
				}
				out.println("<tr>");
				out.print("<th>");
				smallCName = rs.getString("SmallCategoryName");
				Cid = rs.getString("CategoryId");
				out.print("<a href=\"Item.jsp?Cid="+Cid+"\">" +smallCName+"</a>");
				out.print("</th>");
				out.print("</tr>");
				

			}while(rs.next());
		} else{
			out.print("검색 결과가 없습니다.");
		}
		out.print("</table>");
		out.println("</td>");
	} 
	
	out.println("</tr>");
	
	out.print("</table>");
	out.print("<form action= \"Item2.jsp\" method = \"POST\">");
	out.print("search: <input type = \"text\" name =\"ItemName\">");
	out.print("<input type = \"submit\" value = \"Submit\"/>");
	out.print("</form>");
	out.println("<a href=\"history.jsp\">go purchase history</a>");
	out.println("<a href=\"basket.jsp?count=0\">go basket</a>");
	
%>




</html>