package com.shop.jopo;

import java.util.HashSet;
import java.util.Set;

/*
 * 权限
 * */
public class Role {
	
	private Long roleId;
	
	private String roleName;
	
	private int checked;
	
	private String icon;
	
	private String url;
	
	private int pid;
	
	private Set<Chara> characters = new HashSet<Chara>();
	
	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Set<Chara> getCharacters() {
		return characters;
	}

	public void setCharacters(Set<Chara> characters) {
		this.characters = characters;
	}

	public int getChecked() {
		return checked;
	}

	public void setChecked(int checked) {
		this.checked = checked;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}
	 
}
