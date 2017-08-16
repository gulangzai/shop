package com.shop.jopo;

public class Employee {
	
	private long employee_id;
	
	private String name;

	public Employee(){}
	
	public Employee(String name) {
		// TODO Auto-generated constructor stub
	    this.name = name;
	}

	 

	public long getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(long employee_id) {
		this.employee_id = employee_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	} 
	
}
