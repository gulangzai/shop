package com.shop.dto;

import java.util.HashMap;
import java.util.Map;

public class TreeNode {
	
	private String id;
	
	private String text;
	
	private String state;
	
	private int checked;
	
	private int parent_id;
	
	private Map<String,Object> attributes = new HashMap<String,Object>();
	

	public String getId() {
		return id;  
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getChecked() {
		return checked;
	}

	public void setChecked(int checked) {
		this.checked = checked;
	}

	public int getParent_id() {
		return parent_id;
	}

	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}

	public Map<String, Object> getAttributes() {
		return attributes;
	}

	public void setAttributes(Map<String, Object> attributes) {
		this.attributes = attributes;
	} 
	
}
