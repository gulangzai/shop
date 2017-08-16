package com.shop.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbUtil {
	
	DbUtil(){
	   try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","liyi", "123");
        CallableStatement cs = conn.prepareCall("{call sp_student(?,?)}");
        cs.setInt(1, 10);
        cs.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);
        cs.execute();
        
        ResultSet rs = (ResultSet) cs.getObject(2);
        while(rs.next()){
        	System.out.println("编号："+rs.getString(1)+"  姓名："+rs.getString(2));
        }
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
	}
	
	public static void main(String[] args) {
		new DbUtil();
	}
}
