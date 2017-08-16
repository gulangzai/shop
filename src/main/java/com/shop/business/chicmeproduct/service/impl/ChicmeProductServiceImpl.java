package com.shop.business.chicmeproduct.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.chicmeproduct.dao.ChicmeProductDao;
import com.shop.business.chicmeproduct.service.ChicmeProductService;


@Service("chicmeProductService")
public class ChicmeProductServiceImpl implements ChicmeProductService {

	@Autowired
	public ChicmeProductDao chicmeProductDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 chicmeProductDao.save("ChicmeProductMapper.save", pd);
		int ID = (int) pd.get("ID");
		return ID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		chicmeProductDao.delete("ChicmeProductMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		chicmeProductDao.update("ChicmeProductMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)chicmeProductDao.findForList("ChicmeProductMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)chicmeProductDao.findForObject("ChicmeProductMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)chicmeProductDao.findForList("ChicmeProductMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)chicmeProductDao.findForObject("ChicmeProductMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		chicmeProductDao.delete("ChicmeProductMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)chicmeProductDao.findForList("ChicmeProductMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)chicmeProductDao.findForList("ChicmeProductMapper.findNewHot", page);
	}

	
}

