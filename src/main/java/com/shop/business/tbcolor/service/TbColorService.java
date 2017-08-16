package com.shop.business.tbcolor.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import com.lanbao.base.Page;
import com.lanbao.base.PageData;



public interface TbColorService {

	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception;
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception;
	
	/*
	* edit
	*/
	public void edit(PageData pd)throws Exception;
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception;
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/*
	* ͨ��id��ȡ����
	*/
	public PageData findById(PageData pd)throws Exception;
	
	/*
	* deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	  

	
}

