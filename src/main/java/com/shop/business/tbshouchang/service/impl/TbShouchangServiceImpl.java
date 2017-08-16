package com.shop.business.tbshouchang.service.impl;

import java.io.Serializable;
import java.util.List; 
import javax.annotation.Resource; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 

import com.lanbao.base.Page;
import com.lanbao.base.PageData; 
import com.shop.business.tbshouchang.dao.TbShouchangDao;
import com.shop.business.tbshouchang.service.TbShouchangService;
import com.shop.business.tbshouchang.vo.TbShouchang;


@Service("tbShouchangService")
public class TbShouchangServiceImpl implements TbShouchangService {

	@Autowired
	public TbShouchangDao tbShouchangDao;
	
	/*
	* save
	*/
	public int save(PageData pd)throws Exception{
		 tbShouchangDao.mb_save("TbShouchangMapper.save", pd);
		int F_SHOUCHANG_UID = (int) pd.get("F_SHOUCHANG_UID");
		return F_SHOUCHANG_UID;
	}
	
	@Override
	public int save(TbShouchang tbShouchang)throws Exception{
		Serializable serial =  (Serializable) tbShouchangDao.h_save(tbShouchang); 
		return (int) serial;
	}
	
	
	/*
	* delete
	*/
	public void delete(PageData pd)throws Exception{
		tbShouchangDao.mb_delete("TbShouchangMapper.delete", pd);
	}
	
	/*
	*edit
	*/
	public void edit(PageData pd)throws Exception{
		tbShouchangDao.mb_update("TbShouchangMapper.edit", pd);
	}
	
	/*
	*list
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)tbShouchangDao.mb_findForList("TbShouchangMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)tbShouchangDao.mb_findForObject("TbShouchangMapper.datalistPageCount", page); 
	} 
	
	/*
	*listAll
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbShouchangDao.mb_findForList("TbShouchangMapper.listAll", pd);
	}
	
	/*
	*findById
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbShouchangDao.mb_findForObject("TbShouchangMapper.findById", pd);
	}
	
	/*
	*deleteAll
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbShouchangDao.mb_delete("TbShouchangMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbShouchangDao.mb_findForList("TbShouchangMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)tbShouchangDao.mb_findForList("TbShouchangMapper.findNewHot", page);
	}

	
}

