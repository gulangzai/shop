package com.shop.system.tbmenu.vo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class TbMenu implements Comparable{
	
	public String f_menu_id;
	public String f_menu_parent;
	public String f_menu_name;
	public String f_menu_url;
	public String f_menu_icon;
	public int f_menu_serial;
	public String f_status; 
	
	List<TbMenu> tbMenus = new ArrayList<TbMenu>();

	

	public String getF_menu_id() {
		return f_menu_id;
	}

	public void setF_menu_id(String f_menu_id) {
		this.f_menu_id = f_menu_id;
	}


	public String getF_menu_parent() {
		return f_menu_parent;
	}

	public void setF_menu_parent(String f_menu_parent) {
		this.f_menu_parent = f_menu_parent;
	}

	public String getF_menu_name() {
		return f_menu_name;
	}

	public void setF_menu_name(String f_menu_name) {
		this.f_menu_name = f_menu_name;
	}

	public String getF_menu_url() {
		return f_menu_url;
	}

	public void setF_menu_url(String f_menu_url) {
		this.f_menu_url = f_menu_url;
	}

	public String getF_menu_icon() {
		return f_menu_icon;
	}

	public void setF_menu_icon(String f_menu_icon) {
		this.f_menu_icon = f_menu_icon;
	}

   

	public Integer getF_menu_serial() {
		return f_menu_serial;
	}

	public void setF_menu_serial(int f_menu_serial) {
		this.f_menu_serial = f_menu_serial;
	}

	public String getF_status() {
		return f_status;
	}

	public void setF_status(String f_status) {
		this.f_status = f_status;
	}

	public List<TbMenu> getTbMenus() {
		return tbMenus;
	}

	public void setTbMenus(List<TbMenu> tbMenus) {
		this.tbMenus = tbMenus;
	}
	
 
	
	@Override
	public int compareTo(Object o)
	 { 
       TbMenu sdto = (TbMenu)o; 
       int otherAge = sdto.getF_menu_serial();  
       return this.getF_menu_serial().compareTo(otherAge);
	 }

}
