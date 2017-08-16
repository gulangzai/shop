package com.shop.business.tbclass.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import com.lanbao.base.Page;
import com.lanbao.base.PageData;
import com.lanbao.mybatis.MyBatisBaseDao;


@Service("classService")
public class ClassService {

	@Resource(name = "myBatisBaseDao")
	private MyBatisBaseDao dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("PicturesMapper.save", pd);
	}
	
	/*
	* 新增
	*/
	public void add(PageData pd)throws Exception{
		dao.save("ClassMapper.add", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("ClassMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("ClassMapper.edit", pd);
	}
	
 
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		
		List<PageData> list = new ArrayList();
		pd.put("F_PClsId", null);
		getClass(list,pd); 
		return list; //(List<PageData>)dao.findForList("ClassMapper.listAll",pd);
	}
	
	public void getClass(List<PageData> allList,PageData pd) throws Exception{
		List<PageData> result = (List<PageData>)dao.findForList("ClassMapper.listAllByParent",pd);
		for (PageData pageData : result) {
			PageData pdson = new PageData();
			pdson.put("F_PClsId", pageData.get("id")); 
			allList.add(pageData);
			getClass(allList,pdson);
		}
	}
	
	public List<PageData> list(Page page) throws Exception{
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("ClassMapper.datalistPage",page);
	}
	
	 
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ClassMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PicturesMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/*
	* 批量获取
	*/
	public List<PageData> getAllById(String[] ArrayDATA_IDS)throws Exception{
		return (List<PageData>)dao.findForList("PicturesMapper.getAllById", ArrayDATA_IDS);
	}
	
	/*
	* 删除图片
	*/
	public void delTp(PageData pd)throws Exception{
		dao.update("PicturesMapper.delTp", pd);
	}

	
	
}

