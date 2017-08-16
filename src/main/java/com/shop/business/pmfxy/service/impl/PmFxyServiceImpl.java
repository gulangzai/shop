package com.shop.business.pmfxy.service.impl;

import java.sql.Connection;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.lanbao.base.Page;
import com.lanbao.base.PageData;
import com.shop.business.pmfxy.dao.PmFxyDao;
import com.shop.business.pmfxy.service.PmFxyService;
import com.shop.business.pmfxy.vo.PmFxyVO;
import com.shop.business.pmfxy.dao.PmFxyDao;
import com.shop.business.tbproduct.service.TbProductService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Service("pmFxyService")
public class PmFxyServiceImpl implements PmFxyService {

	@Autowired
	public PmFxyDao pmFxyDao;
	
	/*
	* 新增
	*/
	public int save(String json)throws Exception{ 
		PmFxyVO vo = new PmFxyVO(); 
    	JSONArray list = vo.doInitJson(json); 
    	vo.setValueFromJson((JSONObject) list.get(0));  
    	vo.setCreate_date(new Date());   
		vo =  (PmFxyVO) pmFxyDao.mb_save("PmFxyMapper.save", vo);
		int id = Integer.parseInt(vo.getFxy_uid()); 
		return id;  
	}
	
	/*
	* 删除
	*/
	public String delete(String json)throws Exception{
		String resultVo = null;
		PmFxyVO vo = new PmFxyVO();
		JSONArray list = vo.doInitJson(json);
		JSONObject jsonObj = (JSONObject) list.get(0); 
		vo.setValueFromJson(jsonObj); 
		//删除   根据据主键 
		pmFxyDao.mb_delete("PmFxyMapper.delete", vo);
		resultVo = vo.getRowJson(); 
		return resultVo;
	}
	
	/*
	* 修改
	*/
	public String update(String json)throws Exception{ 
	        String resultVO = null;
	        PmFxyVO vo = new PmFxyVO(); 
        	JSONArray list = vo.doInitJson(json);
        	JSONObject obj  = (JSONObject) list.get(0);
        	vo.setUpdate_date(new Date());  
            vo.setValueFromJson((JSONObject) list.get(0)); 
            // 修改 
		    pmFxyDao.mb_update("PmFxyMapper.update", vo);
		    resultVO = vo.getRowJson();
		    return resultVO;
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)pmFxyDao.mb_findForList("PmFxyMapper.datalistPage", page);
	}
	
	public int datalistPageCount(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (int)pmFxyDao.mb_findForObject("PmFxyMapper.datalistPageCount", page); 
	} 
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)pmFxyDao.mb_findForList("TbProductMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)pmFxyDao.mb_findForObject("TbProductMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		pmFxyDao.mb_delete("TbProductMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> findByClassId(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)pmFxyDao.mb_findForList("TbProductMapper.findByClassId", page);
	}

	public List<PageData> findNewHot(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)pmFxyDao.mb_findForList("TbProductMapper.findNewHot", page);
	}

	 
}

