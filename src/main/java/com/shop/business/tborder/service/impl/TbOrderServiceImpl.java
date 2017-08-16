package com.shop.business.tborder.service.impl;

import java.util.Date;
import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lanbao.base.JqGridPage;
import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tborder.dao.TbOrderDao;
import com.shop.business.tborder.service.TbOrderService;
import com.shop.business.tborder.vo.TbOrder;


@Service("tbOrderService")
public class TbOrderServiceImpl implements TbOrderService {

	@Autowired
	public TbOrderDao tbOrderDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
	   // tbOrderDao.mb_save("TbOrderMapper.save", pd); 
	   //int F_ORDER_UID = (int) pd.get("F_ORDER_UID");
		TbOrder tbOrder = new TbOrder(); 
		tbOrder.setF_message(pd.getString("F_Message"));
		tbOrder.setF_buycount(Integer.parseInt(pd.getString("F_BuyCount")));
	    tbOrder.setF_orderseries((String) pd.get("F_OrderSeries"));
		tbOrder.setF_product_id(pd.getString("F_PRODUCT_ID"));
	    tbOrder.setF_status(Integer.parseInt(pd.getString("F_Status")));
	    tbOrder.setF_user_id(pd.getString("F_USER_ID"));
		tbOrder.setCreate_date(new Date());
	    int F_ORDER_UID =  (int) tbOrderDao.h_save(tbOrder);
		return F_ORDER_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbOrderDao.mb_delete("TbOrderMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbOrderDao.mb_update("TbOrderMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(JqGridPage page)throws Exception{ 
		return (List<PageData>)tbOrderDao.mb_findForList("TbOrderMapper.datalistPage", page);
	}
	
	public int datalistPageCount(JqGridPage page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbOrderDao.mb_findForObject("TbOrderMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbOrderDao.mb_findForList("TbOrderMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbOrderDao.mb_findForObject("TbOrderMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbOrderDao.mb_delete("TbOrderMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbOrderDao.mb_findForList("TbOrderMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbOrderDao.mb_findForList("TbOrderMapper.findNewHot", page);
	}

	
}

