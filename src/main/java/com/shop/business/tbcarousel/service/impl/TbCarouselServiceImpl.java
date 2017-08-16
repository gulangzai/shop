package com.shop.business.tbcarousel.service.impl;

import java.util.Date;
import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lanbao.base.JqGridPage;
import com.lanbao.base.Page;
import com.lanbao.base.PageData;
import com.shop.business.tbcarousel.dao.TbCarouselDao;
import com.shop.business.tbcarousel.service.TbCarouselService;
import com.shop.business.tbcarousel.dao.TbCarouselDao; 
import com.shop.business.tbnotice.vo.TbNotice;
import com.shop.business.tborder.service.TbOrderService;
import com.shop.business.tborder.vo.TbOrder;


@Service("tbCarouselService")
public class TbCarouselServiceImpl implements TbCarouselService {

	@Autowired
	public TbCarouselDao tbCarouselDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
	   // tbCarouselDao.mb_save("TbOrderMapper.save", pd); 
	     tbCarouselDao.mb_save("TbCarouselMapper.save",pd);
	    int F_Id =  (int) pd.get("F_Id");
		return F_Id;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbCarouselDao.mb_delete("TbCarouselMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbCarouselDao.mb_update("TbCarouselMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(JqGridPage page)throws Exception{ 
		return (List<PageData>)tbCarouselDao.mb_findForList("TbCarouselMapper.datalistPage", page);
	}
	
	public int datalistPageCount(JqGridPage page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbCarouselDao.mb_findForObject("TbCarouselMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbCarouselDao.mb_findForList("TbCarouselMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbCarouselDao.mb_findForObject("TbCarouselMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbCarouselDao.mb_delete("TbCarouselMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbCarouselDao.mb_findForList("TbCarouselMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbCarouselDao.mb_findForList("TbCarouselMapper.findNewHot", page);
	}

	
}

