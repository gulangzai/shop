package com.shop.business.tbloginlog.vo;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TbNotice entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_login_log", catalog = "shop")
public class TbLoginLog implements java.io.Serializable {
	
	private String userId;
	
	private Date loginTime;
	
	private Date loginOut;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	public Date getLoginOut() {
		return loginOut;
	}

	public void setLoginOut(Date loginOut) {
		this.loginOut = loginOut;
	}
	
	

}