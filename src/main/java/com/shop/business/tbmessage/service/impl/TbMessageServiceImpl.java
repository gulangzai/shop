package com.shop.business.tbmessage.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tbmessage.dao.TbMessageDao;
import com.shop.business.tbmessage.service.TbMessageService;


@Service("tbMessageService")
public class TbMessageServiceImpl implements TbMessageService {

	@Autowired
	public TbMessageDao tbMessageDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 tbMessageDao.save("TbMessageMapper.save", pd);
		int F_MESSAGE_UID = (int) pd.get("F_MESSAGE_UID");
		return F_MESSAGE_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbMessageDao.delete("TbMessageMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbMessageDao.update("TbMessageMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbMessageDao.findForList("TbMessageMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbMessageDao.findForObject("TbMessageMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbMessageDao.findForList("TbMessageMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbMessageDao.findForObject("TbMessageMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbMessageDao.delete("TbMessageMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbMessageDao.findForList("TbMessageMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbMessageDao.findForList("TbMessageMapper.findNewHot", page);
	}

	
}

