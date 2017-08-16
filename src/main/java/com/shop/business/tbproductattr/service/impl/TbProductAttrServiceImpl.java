package com.shop.business.tbproductattr.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tbproductattr.dao.TbProductAttrDao;
import com.shop.business.tbproductattr.service.TbProductAttrService;


@Service("tbProductAttrService")
public class TbProductAttrServiceImpl implements TbProductAttrService {

	@Autowired
	public TbProductAttrDao tbProductAttrDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 tbProductAttrDao.save("TbProductAttrMapper.save", pd);
		int F_PRODUCT_ATTR_UID = (int) pd.get("F_PRODUCT_ATTR_UID");
		return F_PRODUCT_ATTR_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbProductAttrDao.delete("TbProductAttrMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbProductAttrDao.update("TbProductAttrMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbProductAttrDao.findForList("TbProductAttrMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbProductAttrDao.findForObject("TbProductAttrMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbProductAttrDao.findForList("TbProductAttrMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbProductAttrDao.findForObject("TbProductAttrMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbProductAttrDao.delete("TbProductAttrMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbProductAttrDao.findForList("TbProductAttrMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbProductAttrDao.findForList("TbProductAttrMapper.findNewHot", page);
	}

	
}

