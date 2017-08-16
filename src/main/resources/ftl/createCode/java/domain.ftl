package com.shop.business.${package}.vo;
import java.util.Date;
public class ${object_name} {
	
<#if  dbFields?exists>
    <#list dbFields  as field> 
        <#if field.data_type=="BIGINT "||field.data_type=="INT">
           public int ${field.name};   
           public int get${field.name?capitalize}() {
			return ${field.name};
		   } 
		   public void set${field.name?capitalize}(int ${field.name}) {
			  this.${field.name} = ${field.name};
		   } 
        <#elseif field.data_type=="VARCHAR">
           public String ${field.name} = null;   
           public String get${field.name?capitalize}() {
			return ${field.name};
		   } 
		   public void set${field.name?capitalize}(String ${field.name}) {
			  this.${field.name} = ${field.name};
		   } 
         <#elseif field.data_type=="DATETIME">
           public Date ${field.name} = null;  
           public Date get${field.name?capitalize}() {
			return ${field.name};
		   } 
		   public void set${field.name?capitalize}(Date ${field.name}) {
			  this.${field.name} = ${field.name};
		   } 
         <#else> 
        </#if> 
        
    </#list>
</#if>
	 
}
	