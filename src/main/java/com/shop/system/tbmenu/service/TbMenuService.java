package com.shop.system.tbmenu.service;

import java.util.HashMap;
import java.util.List;

import com.lanbao.base.JqGridPage;
import com.lanbao.base.PageData;

public interface TbMenuService {

	int save(PageData pd) throws Exception;

	void deleteAll(String[] ArrayDATA_IDS) throws Exception;

	PageData findById(PageData pd) throws Exception;

	List<PageData> listAll(PageData pd) throws Exception;

	List<PageData> list(JqGridPage page) throws Exception;

	void edit(PageData pd) throws Exception;

	void delete(PageData pd) throws Exception;

	int getMax(PageData pd)throws Exception;

	String loadAllMenu(HashMap<String, String> map);

	String awardMenuToRole(HashMap<String, String> map) throws Exception;
 

}
