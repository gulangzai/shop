package com.shop.business.tbapp.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tbapp.dao.TbAppDao;
import com.shop.business.tbapp.service.TbAppService;


@Service("tbAppService")
public class TbAppServiceImpl implements TbAppService {

	@Autowired
	public TbAppDao tbAppDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 tbAppDao.mb_save("TbAppMapper.save", pd);
		int F_APP_UID = (int) pd.get("F_APP_UID");
		return F_APP_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbAppDao.mb_delete("TbAppMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbAppDao.mb_update("TbAppMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbAppDao.mb_findForList("TbAppMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbAppDao.mb_findForObject("TbAppMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbAppDao.mb_findForList("TbAppMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbAppDao.mb_findForObject("TbAppMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbAppDao.mb_delete("TbAppMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbAppDao.mb_findForList("TbAppMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbAppDao.mb_findForList("TbAppMapper.findNewHot", page);
	}

	
}

