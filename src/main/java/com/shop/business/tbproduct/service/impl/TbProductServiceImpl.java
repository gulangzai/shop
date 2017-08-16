package com.shop.business.tbproduct.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.lanbao.base.Page;
import com.lanbao.base.PageData;

import com.shop.business.tbproduct.dao.TbProductDao;
import com.shop.business.tbproduct.service.TbProductService;


@Service("tbProductService")
public class TbProductServiceImpl implements TbProductService {

	@Autowired
	public TbProductDao tbProductDao;
	
	/*
	* 新增
	*/
	public int save(PageData pd)throws Exception{
		pd = (PageData) tbProductDao.mb_save("TbProductMapper.save", pd);
		int F_PRODUCT_ID = (int) pd.get("F_PRODUCT_ID");
		return F_PRODUCT_ID;
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		tbProductDao.mb_delete("TbProductMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		tbProductDao.mb_update("TbProductMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbProductDao.mb_findForList("TbProductMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbProductDao.mb_findForObject("TbProductMapper.datalistPageCount", page); 
	} 
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbProductDao.mb_findForList("TbProductMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbProductDao.mb_findForObject("TbProductMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbProductDao.mb_delete("TbProductMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbProductDao.mb_findForList("TbProductMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbProductDao.mb_findForList("TbProductMapper.findNewHot", page);
	}

	
}

