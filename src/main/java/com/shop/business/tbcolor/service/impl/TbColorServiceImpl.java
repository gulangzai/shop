package com.shop.business.tbcolor.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tbcolor.dao.TbColorDao;
import com.shop.business.tbcolor.service.TbColorService;


@Service("tbColorService")
public class TbColorServiceImpl implements TbColorService {

	@Autowired
	public TbColorDao tbColorDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 tbColorDao.save("TbColorMapper.save", pd);
		int F_COLOR_UID = (int) pd.get("F_COLOR_UID");
		return F_COLOR_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbColorDao.delete("TbColorMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbColorDao.update("TbColorMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbColorDao.findForList("TbColorMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbColorDao.findForObject("TbColorMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbColorDao.findForList("TbColorMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbColorDao.findForObject("TbColorMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbColorDao.delete("TbColorMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbColorDao.findForList("TbColorMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbColorDao.findForList("TbColorMapper.findNewHot", page);
	}

	
}

