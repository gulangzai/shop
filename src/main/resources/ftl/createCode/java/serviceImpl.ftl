package com.shop.business.${package}.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 
import com.lanbao.dao.DaoSupport;
import com.lanbao.entity.Page;
import com.lanbao.util.PageData; 
import com.shop.business.${package}.dao.${object_name}Dao;
import com.shop.business.${package}.service.${object_name}Service;


@Service("${low_object_name}Service")
public class ${object_name}ServiceImpl implements ${object_name}Service {

	@Autowired
	public ${object_name}Dao ${low_object_name}Dao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 ${low_object_name}Dao.save("${object_name}Mapper.save", pd);
		int ${PK_Name} = (int) pd.get("${PK_Name}");
		return ${PK_Name};
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		${low_object_name}Dao.delete("${object_name}Mapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		${low_object_name}Dao.update("${object_name}Mapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)${low_object_name}Dao.findForList("${object_name}Mapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)${low_object_name}Dao.findForObject("${object_name}Mapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)${low_object_name}Dao.findForList("${object_name}Mapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)${low_object_name}Dao.findForObject("${object_name}Mapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		${low_object_name}Dao.delete("${object_name}Mapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)${low_object_name}Dao.findForList("${object_name}Mapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)${low_object_name}Dao.findForList("${object_name}Mapper.findNewHot", page);
	}

	
}

