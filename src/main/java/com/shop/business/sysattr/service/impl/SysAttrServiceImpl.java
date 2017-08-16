package com.shop.business.sysattr.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.sysattr.dao.SysAttrDao;
import com.shop.business.sysattr.service.SysAttrService;


@Service("sysAttrService")
public class SysAttrServiceImpl implements SysAttrService {

	@Autowired
	public SysAttrDao sysAttrDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 sysAttrDao.save("SysAttrMapper.save", pd); 
		 int F_ATTR_UID = (int) pd.get("F_ATTR_UID");
		return F_ATTR_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		sysAttrDao.delete("SysAttrMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		sysAttrDao.update("SysAttrMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)sysAttrDao.findForList("SysAttrMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)sysAttrDao.findForObject("SysAttrMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)sysAttrDao.findForList("SysAttrMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)sysAttrDao.findForObject("SysAttrMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		sysAttrDao.delete("SysAttrMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)sysAttrDao.findForList("SysAttrMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)sysAttrDao.findForList("SysAttrMapper.findNewHot", page);
	}

	
}

