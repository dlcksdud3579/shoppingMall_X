package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConn {
	public static Connection getMySqlConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver"); // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
			
			String url = "jdbc:mysql://localhost:3306/ShoppingMallDB";
			String id = "knu";                                                    // ����� ����
			String pw = "comp322";                                                  // ����� ������ �н�����
			
			conn=DriverManager.getConnection(url,id,pw);              // DriverManager ��ü�κ��� Connection ��ü�� ���´�.
			
		}
		catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
			
		return conn;
	}

}
