package com.shop.business.tbshopcar.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tbshopcar.dao.TbShopCarDao;
import com.shop.business.tbshopcar.service.TbShopCarService;


@Service("tbShopCarService")
public class TbShopCarServiceImpl implements TbShopCarService {

	@Autowired
	public TbShopCarDao tbShopCarDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 tbShopCarDao.save("TbShopCarMapper.save", pd);
		int F_SHOPCARDID = (int) pd.get("F_SHOPCARDID");
		return F_SHOPCARDID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbShopCarDao.delete("TbShopCarMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbShopCarDao.update("TbShopCarMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbShopCarDao.findForList("TbShopCarMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbShopCarDao.findForObject("TbShopCarMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbShopCarDao.findForList("TbShopCarMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbShopCarDao.findForObject("TbShopCarMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbShopCarDao.delete("TbShopCarMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbShopCarDao.findForList("TbShopCarMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbShopCarDao.findForList("TbShopCarMapper.findNewHot", page);
	}

	
}

