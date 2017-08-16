package com.shop.jopo;

import java.util.HashSet;
import java.util.Set;

public class Department {
	
	private long department_id;
	
	public long getDepartment_id() {
		return department_id;
	}

	public void setDepartment_id(long department_id) {
		this.department_id = department_id;
	}

	private String name = null;
	
	private Set<Employee> employees = new HashSet<Employee>();
   
    public Department(){}
    
	public Department(String name) {
		// TODO Auto-generated constructor stub
		this.name= name;
	}
 

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set getEmployees() {
		return employees;
	}

	public void setEmployees(Set employees) {
		this.employees = employees;
	}
	
	
}
