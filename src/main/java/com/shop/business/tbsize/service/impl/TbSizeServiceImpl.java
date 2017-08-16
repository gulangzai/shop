package com.shop.business.tbsize.service.impl;

import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;  
import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tbsize.dao.TbSizeDao;
import com.shop.business.tbsize.service.TbSizeService;


@Service("tbSizeService")
public class TbSizeServiceImpl implements TbSizeService {

	@Autowired
	public TbSizeDao tbSizeDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 tbSizeDao.save("TbSizeMapper.save", pd);
		int F_SIZE_UID = (int) pd.get("F_SIZE_UID");
		return F_SIZE_UID;
	}
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbSizeDao.delete("TbSizeMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbSizeDao.update("TbSizeMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbSizeDao.findForList("TbSizeMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbSizeDao.findForObject("TbSizeMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbSizeDao.findForList("TbSizeMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbSizeDao.findForObject("TbSizeMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbSizeDao.delete("TbSizeMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbSizeDao.findForList("TbSizeMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbSizeDao.findForList("TbSizeMapper.findNewHot", page);
	}

	
}

