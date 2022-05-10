package model2_shop.com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ShopConnection {
	static Connection conn=null;
	static PreparedStatement ps=null;
	static ResultSet rs=null;
	static String url="jdbc:mysql://localhost:3306/spring_shop";
	static String user="root"; 
	static String pw="mysql";
	static String driver="com.mysql.cj.jdbc.Driver";
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName(driver);
		conn=DriverManager.getConnection(url,user,pw);
		
		return conn;
	}
	// 접속 테스트할 때만 사용하세요.
//	public static void main(String[] args) {
//		try {
//			System.out.println(ShopConnection.getConnection());
//		} catch (ClassNotFoundException | SQLException e) {
//			e.printStackTrace();
//		}
//	}
}
