package com.shop.business.pmfxy.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import com.lanbao.base.Page;
import com.lanbao.base.PageData;



public interface PmFxyService {

	
	/*
	* 新增
	*/
	public int save(String string)throws Exception;
	
	/*
	* 删除
	*/
	public String delete(String msg)throws Exception;
	
	/*
	* 修改
	*/
	public String update(String msg) throws Exception;
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception;
	
 
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception;
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	

	public List<PageData> findByClassId(Page page) throws Exception;

	public List<PageData> findNewHot(Page page) throws Exception;



	
}

