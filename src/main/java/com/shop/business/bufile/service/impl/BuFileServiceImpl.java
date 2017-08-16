package com.shop.business.bufile.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.bufile.dao.BuFileDao;
import com.shop.business.bufile.service.BuFileService;


@Service("buFileService")
public class BuFileServiceImpl implements BuFileService {

	@Autowired
	public BuFileDao buFileDao;
	
	
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 buFileDao.save("BuFileMapper.save", pd);
		int ID = (int) pd.get("ID");
		return ID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		buFileDao.delete("BuFileMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		buFileDao.update("BuFileMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)buFileDao.findForList("BuFileMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)buFileDao.findForObject("BuFileMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)buFileDao.findForList("BuFileMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)buFileDao.findForObject("BuFileMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		buFileDao.delete("BuFileMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)buFileDao.findForList("BuFileMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)buFileDao.findForList("BuFileMapper.findNewHot", page);
	}

	
}

