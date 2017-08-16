package com.shop.business.pmfxy.vo; 
import java.util.Date;

import com.lanbao.base.BaseVO;

public class PmFxyVO extends BaseVO{

	public PmFxyVO(){
		this.addField("FXY_UID",OP_STRING|this.TP_PK);//
		this.addField("PROJECT_UID",OP_STRING);//
		this.addField("FXY_TYPE",OP_STRING);//风险源类型
		this.addField("QUYU",OP_STRING); //区域
		this.addField("WXYS",OP_STRING);//危险因素
		this.addField("WXYS_FL",OP_STRING);//危险因素分类
		this.addField("SHIGU",OP_STRING);//可能导致的事故
		this.addField("YIJIN_YUAN",OP_STRING);
		this.addField("CUOSHI",OP_STRING);//控制措施
		this.addField("BEGIN_DATE",OP_DATE);//开始日期
		this.addField("END_DATE",OP_DATE);//结束日期
		this.addField("XUHAO",OP_STRING);//序号
		this.addField("CREATE_USER",OP_STRING);//
		this.addField("CREATE_DATE",OP_DATE);//
		this.addField("UPDATE_DATE",OP_DATE);//
		this.setFieldDateFormat("BEGIN_DATE","yyyy-MM-dd");
		this.setFieldDateFormat("END_DATE","yyyy-MM-dd");
		this.setFieldDateFormat("CREATE_DATE","yyyy-MM-dd HH:mm:ss");
		this.setFieldDateFormat("UPDATE_DATE","yyyy-MM-dd HH:mm:ss");
		this.setVOTableName("PM_FXY");
	}
	
	String yijin_yuan;

	public void setFxy_uid(String fxy_uid){
		this.setInternal("FXY_UID",fxy_uid);
	}
	public String getFxy_uid(){ 
		return String.valueOf(this.getInternal("FXY_UID"));
	}
	public void setProject_uid(String project_uid){
		this.setInternal("PROJECT_UID",project_uid);
	}
	public String getProject_uid(){
		return (String)this.getInternal("PROJECT_UID");
	}
	public void setFxy_type(String fxy_type){
		this.setInternal("FXY_TYPE",fxy_type);
	}
	public String getFxy_type(){
		return (String)this.getInternal("FXY_TYPE");
	}
	
	public String getQuyu() {
		return (String)this.getInternal("QUYU"); 
	}
	public void setQuyu(String quyu) {
		this.setInternal("QUYU",quyu); 
	}
	
	public void setWxys(String wxys){
		this.setInternal("WXYS",wxys);
	}
	public String getWxys(){
		return (String)this.getInternal("WXYS");
	}
	public void setWxys_fl(String wxys_fl){
		this.setInternal("WXYS_FL",wxys_fl);
	}
	public String getWxys_fl(){
		return (String)this.getInternal("WXYS_FL");
	}
	public void setShigu(String shigu){
		this.setInternal("SHIGU",shigu);
	}
	public String getShigu(){
		return (String)this.getInternal("SHIGU");
	}
	public void setCuoshi(String cuoshi){
		this.setInternal("CUOSHI",cuoshi);
	}
	public String getCuoshi(){
		return (String)this.getInternal("CUOSHI");
	}
	 
	public void setYijin_yuan(String yijin_yuan) { 
		this.setInternal("YIJIN_YUAN",yijin_yuan);
	} 
	
	public String getYijin_yuan() {
		return (String)this.getInternal("YIJIN_YUAN"); 
	}
	
	public void setBegin_date(Date begin_date){
		this.setInternal("BEGIN_DATE",begin_date);
	}
	public Date getBegin_date(){
		return (Date)this.getInternal("BEGIN_DATE");
	}
	public void setEnd_date(Date end_date){
		this.setInternal("END_DATE",end_date);
	}
	public Date getEnd_date(){
		return (Date)this.getInternal("END_DATE");
	}
	public void setXuhao(String xuhao){
		this.setInternal("XUHAO",xuhao);
	}
	public String getXuhao(){
		return (String)this.getInternal("XUHAO");
	}
	public void setCreate_user(String create_user){
		this.setInternal("CREATE_USER",create_user);
	}
	public String getCreate_user(){
		return (String)this.getInternal("CREATE_USER");
	}
	public void setCreate_date(Date create_date){
		this.setInternal("CREATE_DATE",create_date);
	}
	public Date getCreate_date(){
		return (Date)this.getInternal("CREATE_DATE");
	}
	public void setUpdate_date(Date update_date){
		this.setInternal("UPDATE_DATE",update_date);
	}
	public Date getUpdate_date(){
		return (Date)this.getInternal("UPDATE_DATE");
	}
	 

	
	
	
}