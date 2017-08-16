package com.shop.jopo;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class TestIbatis {

	TestIbatis(){
		Reader reader;
		List<Student> students = null; 
	 
			try {
				reader = Resources.getResourceAsReader("cn/shop/com/jopo/sqlMapConfig.xml");
				SqlMapClient smc = SqlMapClientBuilder.buildSqlMapClient(reader);
				students = smc.queryForList("TTArea.selectAllStudents",null); 
				for(Student student: students)
				    System.out.println(student.getName());
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				 e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		 
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
           new TestIbatis();
	}

}
