package com.shop.business.tbshopcard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import com.lanbao.base.Page;
import com.lanbao.base.PageData;
import com.lanbao.mybatis.MyBatisBaseDao;


@Service("shopcardService")
public class TbShopcardService {

	@Resource(name = "myBatisBaseDao")
	private MyBatisBaseDao dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("TbShopcardMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("TbShopcardMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("TbShopcardMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TbShopcardMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TbShopcardMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TbShopcardMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TbShopcardMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

