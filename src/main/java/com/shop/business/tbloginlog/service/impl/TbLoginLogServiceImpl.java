package com.shop.business.tbloginlog.service.impl;

import java.util.Date;
import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lanbao.base.JqGridPage;
import com.lanbao.base.Page;
import com.lanbao.base.PageData;
import com.shop.business.tbloginlog.dao.TbLoginLogDao;
import com.shop.business.tbloginlog.service.TbLoginLogService;
import com.shop.business.tbnotice.dao.TbNoticeDao;
import com.shop.business.tbnotice.service.TbNoticeService;
import com.shop.business.tbnotice.vo.TbNotice;
import com.shop.business.tborder.service.TbOrderService;
import com.shop.business.tborder.vo.TbOrder;


@Service("tbLoginLogService")
public class TbLoginLogServiceImpl implements TbLoginLogService {

	@Autowired
	public TbLoginLogDao tbLoginLogDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{ 
	    pd.put("F_CREATE_DATE", new Date()); 
	    tbLoginLogDao.mb_save("TbLoginLogMapper.save",pd);
	    int F_NOTICE_UID =  (int) pd.get("F_NOTICE_UID");
		return F_NOTICE_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbLoginLogDao.mb_delete("TbLoginLogMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbLoginLogDao.mb_update("TbLoginLogMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(JqGridPage page)throws Exception{ 
		return (List<PageData>)tbLoginLogDao.mb_findForList("TbLoginLogMapper.datalistPage", page);
	}
	
	public int datalistPageCount(JqGridPage page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbLoginLogDao.mb_findForObject("TbLoginLogMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbLoginLogDao.mb_findForList("TbLoginLogMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbLoginLogDao.mb_findForObject("TbLoginLogMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbLoginLogDao.mb_delete("TbLoginLogMapper.deleteAll", ArrayDATA_IDS);
	}
 

	
}

