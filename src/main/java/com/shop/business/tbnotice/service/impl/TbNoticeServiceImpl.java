package com.shop.business.tbnotice.service.impl;

import java.util.Date;
import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lanbao.base.JqGridPage;
import com.lanbao.base.Page;
import com.lanbao.base.PageData;
import com.shop.business.tbnotice.dao.TbNoticeDao;
import com.shop.business.tbnotice.service.TbNoticeService;
import com.shop.business.tbnotice.vo.TbNotice;
import com.shop.business.tborder.service.TbOrderService;
import com.shop.business.tborder.vo.TbOrder;


@Service("tbNoticeService")
public class TbNoticeServiceImpl implements TbNoticeService {

	@Autowired
	public TbNoticeDao tbNoticeDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
	   // tbNoticeDao.mb_save("TbOrderMapper.save", pd); 
	   //int F_ORDER_UID = (int) pd.get("F_ORDER_UID");
		TbNotice tbNotice = new TbNotice(); 
		tbNotice.setFNoticeTitle(pd.getString("F_NOTICE_TITLE"));
		tbNotice.setFNoticeContent(pd.getString("F_NOTICE_CONTENT"));
		tbNotice.setFCreateDate(new Date()); 
		tbNotice.setFNoticeType(pd.getString("F_NOTICE_TYPE"));
		tbNotice.setFNoticeLevel(Integer.parseInt(pd.getString("F_NOTICE_LEVEL")));
		tbNotice.setFCreateUid(pd.getString("F_USER_ID")); 
	    pd.put("F_CREATE_DATE", new Date()); 
		tbNoticeDao.mb_save("TbNoticeMapper.save",pd);
	    int F_NOTICE_UID =  (int) pd.get("F_NOTICE_UID");
		return F_NOTICE_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbNoticeDao.mb_delete("TbNoticeMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbNoticeDao.mb_update("TbNoticeMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(JqGridPage page)throws Exception{ 
		return (List<PageData>)tbNoticeDao.mb_findForList("TbNoticeMapper.datalistPage", page);
	}
	
	public int datalistPageCount(JqGridPage page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbNoticeDao.mb_findForObject("TbNoticeMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbNoticeDao.mb_findForList("TbNoticeMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbNoticeDao.mb_findForObject("TbNoticeMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbNoticeDao.mb_delete("TbNoticeMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbNoticeDao.mb_findForList("TbNoticeMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbNoticeDao.mb_findForList("TbNoticeMapper.findNewHot", page);
	}

	
}

