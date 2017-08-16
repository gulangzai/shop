package com.shop.system.tbmenu.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lanbao.base.JqGridPage;
import com.lanbao.base.PageData;
import com.shop.system.tbmenu.dao.TbMenuDao;
import com.shop.system.tbmenu.service.TbMenuService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject; 

@Service("tbMenuService")
public class TbMenuServiceImpl implements TbMenuService{
	
	@Autowired
	public TbMenuDao tbMenuDao;
 
	
	/*
	* 新增
	*/
	@Override
	public int save(PageData pd)throws Exception{
		return (Integer) tbMenuDao.save("TbMenuMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	@Override
	public void delete(PageData pd)throws Exception{
		tbMenuDao.delete("TbMenuMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	@Override
	public void edit(PageData pd)throws Exception{
		tbMenuDao.update("TbMenuMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	@Override
	public List<PageData> list(JqGridPage page)throws Exception{
		List<PageData> pageDatas = new ArrayList<PageData>();
		PageData paraData = new PageData();
		paraData.put("keyword", page.getKeyword());
		digui(pageDatas,paraData); 
		return pageDatas;
	}
	
	public void digui(List<PageData> pageDatas,PageData para_pageData) throws Exception{
		List<PageData> pds = (List<PageData>)tbMenuDao.findForList("TbMenuMapper.datalistDigui", para_pageData);
		for (PageData pageData : pds) {
			if("#".equals(pageData.get("F_MENU_URL"))){
			    pageData.put("expanded", false);
			}
			pageDatas.add(pageData);
			digui(pageDatas,pageData);
		}
	}
	
	/*
	*列表(全部)
	*/
	@Override
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)tbMenuDao.findForList("TbMenuMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)tbMenuDao.findForObject("TbMenuMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		tbMenuDao.delete("TbMenuMapper.deleteAll", ArrayDATA_IDS);
	}
	
	public String awardMenuToRole(HashMap<String, String> map)throws Exception { 
		StringBuffer sql  = new StringBuffer();
        PageData pd = new PageData();
        String F_ROLE_ID = map.get("F_ROLE_ID");
        String codes = map.get("codes");
        pd.put("codes", codes);
        pd.put("F_ROLE_ID", F_ROLE_ID); 
	 
		String[] codes_array = codes.split(",");
		for(int i=0;i<codes_array.length;i++){
		   PageData query_pd = new PageData();
		   query_pd.put("F_MENU_ID", codes_array[i]);
		   query_pd.put("F_ROLE_ID", F_ROLE_ID);
		   PageData resultPd = (PageData) tbMenuDao.findForObject("TbRoleMenuMapper.findByRoleMenu", query_pd);
		   if(resultPd==null){
			   tbMenuDao.findForObject("TbRoleMenuMapper.save", query_pd);
		   }
		}
		 PageData delete_pd = new PageData();
		 delete_pd.put("array", codes_array);
		 delete_pd.put("F_ROLE_ID", F_ROLE_ID);
		 tbMenuDao.findForObject("TbRoleMenuMapper.deleteNot", delete_pd);
	 
		return null;
	}
	

	@Override
	public int getMax(PageData pd)throws Exception {
		// TODO Auto-generated method stub
		pd = (PageData) tbMenuDao.findForObject("TbMenuMapper.getMax", pd);
		return (int) pd.get("maxFMenuSerial");
	}

	public String loadAllMenu(HashMap<String, String> map) { 
		StringBuffer sql  = new StringBuffer();
        PageData pd = new PageData();
        String F_ROLE_ID = map.get("F_ROLE_ID");
        pd.put("F_ROLE_ID", F_ROLE_ID);
        
		if ("user".equals(map.get("type"))) {
			//查出用户拥有的权限 
		}else if("role".equals(map.get("type"))){ 
			  
		}
		JSONArray jsonArr = new JSONArray();
		try { 
			List<PageData> rsList =  (List<PageData>)tbMenuDao.findForList("TbMenuMapper.listAllRoleMenu", pd);
			if("user".equals(map.get("type"))){
				//用户
				/*for (int i = 0; i < rsList.size(); i++) {
					Map<String, String> rsMap = rsList.get(i);
					JSONObject json = new JSONObject();
					json.put("id", rsMap.get("AUTHORITY_UID"));
					if (rsMap.get("AUTHORITY_UID").equals(rsMap.get("AUTHORITY_UID1"))) {
						json.put("checked", "true");
						json.put("open", "true");
					}
					json.put("parentId", rsMap.get("P_AUTHORITY_UID"));
					json.put("name", rsMap.get("AUTHORITY_NAME"));
					json.put("code", rsMap.get("AUTHORITY_UID"));
					jsonArr.add(json);
				}*/
			}else if("role".equals(map.get("type"))){
				//角色
				for (int i = 0; i < rsList.size(); i++) {
					PageData rsMap = rsList.get(i);
					JSONObject json = new JSONObject();
					json.put("id", String.valueOf(rsMap.get("F_MENU_ID")));
					if (rsMap.get("F_MENU_ID").equals(rsMap.get("F_MENU_ID1"))) {
						json.put("checked", "true");
						json.put("open", "true");
					}
					json.put("parentId", rsMap.get("F_MENU_PARENT"));
					json.put("name", rsMap.get("F_MENU_NAME"));
					json.put("code", rsMap.get("F_MENU_ID"));
					jsonArr.add(json);
			     }
				
 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { 
		}
		return jsonArr.toString();
	}
	
}
