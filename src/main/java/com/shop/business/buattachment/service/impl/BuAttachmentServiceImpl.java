package com.shop.business.buattachment.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.buattachment.dao.BuAttachmentDao;
import com.shop.business.buattachment.service.BuAttachmentService;


@Service("buAttachmentService")
public class BuAttachmentServiceImpl implements BuAttachmentService {

	@Autowired
	public BuAttachmentDao buAttachmentDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 buAttachmentDao.save("BuAttachmentMapper.save", pd);
		int ID = (int) pd.get("ID");
		return ID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		buAttachmentDao.delete("BuAttachmentMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		buAttachmentDao.update("BuAttachmentMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)buAttachmentDao.findForList("BuAttachmentMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)buAttachmentDao.findForObject("BuAttachmentMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)buAttachmentDao.findForList("BuAttachmentMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)buAttachmentDao.findForObject("BuAttachmentMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		buAttachmentDao.delete("BuAttachmentMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)buAttachmentDao.findForList("BuAttachmentMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)buAttachmentDao.findForList("BuAttachmentMapper.findNewHot", page);
	}

	
}

