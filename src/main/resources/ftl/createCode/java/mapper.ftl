<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${object_name}Mapper">
	 
	
		<!-- 新增-->
	<insert id="save" parameterType="pd"  keyProperty="${PK_Name}" useGeneratedKeys="true">
		    
		insert into ${lower_table_name} (
			 <#if  fields?exists>
				    <#list fields  as field>
					    <#if (fields?size!=field_index+1)>
					         <#if  field.comment !=""  && field.name!=table.key>  
							      ${field.name},  
						    </#if>
	                    <#elseif  field.comment !=""  && field.name!=table.key>  
					          ${field.name}
				         <#else>
				     </#if>
				    </#list>
			  </#if>  
		) values (
		     <#if  fields?exists>
				    <#list fields  as field>
				           <#if (fields?size!=field_index+1)>
					           <#if  field.comment !=""  && field.name!=table.key>  
							       <#noparse>#{</#noparse>${field.name}<#noparse>}</#noparse>,  
						       </#if>
						   <#elseif  field.comment !=""  && field.name!=table.key>  
					             <#noparse>#{</#noparse>${field.name}<#noparse>}</#noparse>
				           <#else>
				           </#if>
				    </#list>
			  </#if>   
		)
		
		<selectKey resultType="java.lang.Integer" order="AFTER" keyProperty="ID">
	          SELECT LAST_INSERT_ID() AS id
	    </selectKey>
	    
	</insert>
	 
	 
    <!-- datalistPage -->
	<select id="datalistPage" parameterType="page" resultType="pd">
		 select
		 <#if  fields?exists>
			    <#list fields  as field>
			        <#if field.data_type=="date">
			             date_format(a.${field.name},'%Y-%c-%d %h:%i:%s') as ${field.name},
			        <#elseif  field.comment !=""  && field.name!=table.key>  
					      a.${field.name},  
				   <#else>
				   </#if>
			    </#list>
		  </#if> 
				a.${PK_Name}
		from 
				${lower_table_name} a
				<#noparse><if test = 'pd.search=="true"'>
				   where </#noparse>
				   ${SEARCH_COLUMN_NAME} 
				   <#noparse>like  CONCAT(CONCAT('%', #{pd.keyword, jdbcType=VARCHAR}),'%') 
				</if></#noparse>
	</select>
	
	 
	 	<!--findById -->
	<select id="findById" parameterType="pd" resultType="pd">
	
	SELECT
	      <#if  fields?exists>
			    <#list fields  as field>
			        <#if field.data_type=="date">
			             date_format(${low_object_name}.${field.name},'%Y-%c-%d %h:%i:%s') as ${field.name},
			        <#elseif  field.comment !=""  && field.name!=table.key>  
					      ${low_object_name}.${field.name},  
				   <#else>
				   </#if>
			    </#list>
		  </#if> 
				${low_object_name}.${PK_Name},
	(select PATH From tb_pictures tbpictures where tbpictures.TABLE_UID_VALUE = ${low_object_name}.${PK_Name} limit 0,1) AS PATH
FROM
	${lower_table_name} ${low_object_name}
WHERE  ${PK_Name} = <#noparse>#{</#noparse>${PK_Name}<#noparse>}</#noparse>
	 
	</select>
	
	
	<!-- �޸� -->
	<update id="edit" parameterType="pd">
		update  ${lower_table_name}
			set 
			 <#if  fields?exists>
			    <#list fields  as field>
			        <#if  field.comment !=""  && field.name!=table.key>  
					      ${field.name} = <#noparse>#{</#noparse>${field.name}<#noparse>}</#noparse>,
				   </#if>
			    </#list>
		     </#if>  
		        ${PK_Name} = <#noparse>#{</#noparse> ${PK_Name}<#noparse>}</#noparse>
		     where 
			    ${PK_Name} = <#noparse>#{</#noparse> ${PK_Name}<#noparse>}</#noparse>
				 
	</update>
	
    <!-- ɾ��-->
	<delete id="delete" parameterType="pd">
		delete from  ${lower_table_name}
		where 
			${PK_Name} = <#noparse>#{</#noparse> ${PK_Name}<#noparse>}</#noparse>
	</delete>
	
	
 
	
</mapper>