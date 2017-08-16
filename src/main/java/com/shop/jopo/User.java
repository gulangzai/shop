package com.shop.jopo;

import java.util.Date;

public class User {
	
	private int id;
	
	private String name = null;
	
	private String username = null;
	
	private String password = null;
	
	private String email = null;
	
	private String phone = null;
	
	private int age = 0;
	
	private Date birthday; 
	
	private String sex;
	
	private Date createTime;
    
	public User(){}
	
	public User(String name, int age) {
		// TODO Auto-generated constructor stu
		this.name = name;
		this.age = age;
	}
	
 

	public User(String name, int age, String sex) {
		// TODO Auto-generated constructor stub
		this.name = name;
		this.age = age;
		this.sex =sex;
		
	}

	public User(String name, int age, String sex, Date birthday) {
		// TODO Auto-generated constructor stub
		this(name,age,sex);
		this.birthday = birthday;
	}
	
 

	public User(int id, String name, int age, String sex) {
		// TODO Auto-generated constructor stub
		this.id = id;
		this.name = name;
		this.age = age;
		this.sex = sex;
	}
	
	public User(String name, int age, String sex, Date birthday,Date createTime) {
		// TODO Auto-generated constructor stub 
		this(name,age,sex,birthday);
		this.createTime = createTime;
	}
	

	public User(int id) {
		// TODO Auto-generated constructor stub
		this.id = id;
	}

	public User(int id,String username, String password, String name, String email, String phone) {
		// TODO Auto-generated constructor stub
	   this.id=id;
	   this.username = username;
	   this.name = name;
	   this.password = password;
	   this.email = email;
	   this.phone = phone;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	} 
	
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	  
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String toString(){
		return "["+name+"],["+age+"]";
	}
	
}
