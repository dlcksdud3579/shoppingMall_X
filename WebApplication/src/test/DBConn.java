package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConn {
	public static Connection getMySqlConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
			
			String url = "jdbc:mysql://localhost:3306/ShoppingMallDB";
			String id = "knu";                                                    // 사용자 계정
			String pw = "comp322";                                                  // 사용자 계정의 패스워드
			
			conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
			
		}
		catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
			
		return conn;
	}

}
