package com.shop.jopo;

import java.util.HashSet;
import java.util.Set;

/*
 *  角色
 * */
public class Chara {
	
	private Long id;
	
	private String charaName;
	
	private Set<Role> roles = new HashSet<Role>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCharaName() {
		return charaName;
	}

	public void setCharaName(String charaName) {
		this.charaName = charaName;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
 
	 
}
