package com.shop.business.tborder.vo;
import java.util.Date;
 
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

@Entity
@Table(name="tb_order") 
public class TbOrder {
	
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)   
	 @Column(name="F_ORDER_UID")
	 public int f_order_uid = -1;
           
           public String f_user_id = null;   
           public String getF_user_id() {
			return f_user_id;
		   } 
		   public void setF_user_id(String f_user_id) {
			  this.f_user_id = f_user_id;
		   } 
        
           public String f_product_id = null;   
           public String getF_product_id() {
			return f_product_id;
		   } 
		   public void setF_product_id(String f_product_id) {
			  this.f_product_id = f_product_id;
		   } 
        
        
           public int f_buycount;   
           public int getF_buycount() {
			return f_buycount;
		   } 
		   public void setF_buycount(int f_buycount) {
			  this.f_buycount = f_buycount;
		   } 
        
        
           public String f_message = null;   
           public String getF_message() {
			return f_message;
		   } 
		   public void setF_message(String f_message) {
			  this.f_message = f_message;
		   } 
        
           public int f_status;   
           public int getF_status() {
			return f_status;
		   } 
		   public void setF_status(int f_status) {
			  this.f_status = f_status;
		   } 
        
           public String f_orderseries = null;   
           public String getF_orderseries() {
			return f_orderseries;
		   } 
		   public void setF_orderseries(String f_orderseries) {
			  this.f_orderseries = f_orderseries;
		   } 
        
           public Date create_date = null;  
           public Date getCreate_date() {
			return create_date;
		   } 
		   public void setCreate_date(Date create_date) {
			  this.create_date = create_date;
		   }
		public int getF_order_uid() {
			return f_order_uid;
		}
		public void setF_order_uid(int f_order_uid) {
			this.f_order_uid = f_order_uid;
		}
		   
		  
		   
		   
        
	 
}
