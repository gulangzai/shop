package com.shop.business.tbnotice.vo;

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
@Table(name = "tb_notice", catalog = "shop")
public class TbNotice implements java.io.Serializable {

	// Fields

	private Integer FNoticeUid;
	private String FNoticeTitle;
	private String FNoticeContent;
	private String FCreateUid;
	private Date FCreateDate;
	private String FNoticeType;
	private Integer FNoticeLevel;
	private Date FUpdateDate;
	private Integer FUpdateUser;

	// Constructors

	/** default constructor */
	public TbNotice() {
	}

	/** full constructor */
	public TbNotice(String FNoticeTitle, String FNoticeContent,
			String FCreateUid, Timestamp FCreateDate, String FNoticeType,
			Integer FNoticeLevel, Timestamp FUpdateDate, Integer FUpdateUser) {
		this.FNoticeTitle = FNoticeTitle;
		this.FNoticeContent = FNoticeContent;
		this.FCreateUid = FCreateUid;
		this.FCreateDate = FCreateDate;
		this.FNoticeType = FNoticeType;
		this.FNoticeLevel = FNoticeLevel;
		this.FUpdateDate = FUpdateDate;
		this.FUpdateUser = FUpdateUser;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "F_NOTICE_UID", unique = true, nullable = false)
	public Integer getFNoticeUid() {
		return this.FNoticeUid;
	}

	public void setFNoticeUid(Integer FNoticeUid) {
		this.FNoticeUid = FNoticeUid;
	}

	@Column(name = "F_NOTICE_TITLE", length = 44)
	public String getFNoticeTitle() {
		return this.FNoticeTitle;
	}

	public void setFNoticeTitle(String FNoticeTitle) {
		this.FNoticeTitle = FNoticeTitle;
	}

	@Column(name = "F_NOTICE_CONTENT", length = 2000)
	public String getFNoticeContent() {
		return this.FNoticeContent;
	}

	public void setFNoticeContent(String FNoticeContent) {
		this.FNoticeContent = FNoticeContent;
	}

	@Column(name = "F_CREATE_UID", length = 44)
	public String getFCreateUid() {
		return this.FCreateUid;
	}

	public void setFCreateUid(String FCreateUid) {
		this.FCreateUid = FCreateUid;
	}

	@Column(name = "F_CREATE_DATE", length = 19)
	public Date getFCreateDate() {
		return this.FCreateDate;
	}

	public void setFCreateDate(Date FCreateDate) {
		this.FCreateDate = FCreateDate;
	}

	@Column(name = "F_NOTICE_TYPE", length = 44)
	public String getFNoticeType() {
		return this.FNoticeType;
	}

	public void setFNoticeType(String FNoticeType) {
		this.FNoticeType = FNoticeType;
	}

	@Column(name = "F_NOTICE_LEVEL")
	public Integer getFNoticeLevel() {
		return this.FNoticeLevel;
	}

	public void setFNoticeLevel(Integer FNoticeLevel) {
		this.FNoticeLevel = FNoticeLevel;
	}

	@Column(name = "F_UPDATE_DATE", length = 19)
	public Date getFUpdateDate() {
		return this.FUpdateDate;
	}

	public void setFUpdateDate(Date FUpdateDate) {
		this.FUpdateDate = FUpdateDate;
	}

	@Column(name = "F_UPDATE_USER")
	public Integer getFUpdateUser() {
		return this.FUpdateUser;
	}

	public void setFUpdateUser(Integer FUpdateUser) {
		this.FUpdateUser = FUpdateUser;
	}

}