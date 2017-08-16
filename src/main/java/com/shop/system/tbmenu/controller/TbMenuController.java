package com.shop.system.tbmenu.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lanbao.controller.BaseController;
import com.lanbao.base.JqGridPage;
import com.lanbao.base.Page;
import com.lanbao.entity.User;
import com.lanbao.utils.AppUtil;
import com.lanbao.utils.ObjectExcelView;
import com.lanbao.utils.Const;
import com.lanbao.utils.DateUtil;
import com.lanbao.base.PageData;
import com.lanbao.utils.Tools;

import com.lanbao.base.ResultAction;
import com.shop.system.tbmenu.service.TbMenuService;
import com.shop.system.tbuser.service.TbUserService;

import net.sf.json.JSONObject;

import com.lanbao.utils.Jurisdiction;
import com.lanbao.utils.MD5; 

/** 
 * 类名称：TUserController
 * 创建人：lanbao 
 * 创建时间：2016-06-05
 */
@Controller
@RequestMapping(value="/tbmenu/tbMenuController")
public class TbMenuController extends BaseController {
	
	String menuUrl = "tbUserController/list.do"; //菜单地址(权限用)
	
	@Resource(name="tbMenuService")
	private TbMenuService tbMenuService;
	
	@RequestMapping(value="/goListView")
	public ModelAndView goListView(Page page){
		logBefore(logger, "tbuserController"); 
		ModelAndView mv = this.getModelAndView();
		try{
		 	mv.setViewName("business/tbmenu/tb_menu_index"); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	@RequestMapping(value="/goAddView")
	public ModelAndView goAddView(){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {  
			pd = tbMenuService.findById(pd);	//根据ID读取
			mv.setViewName("business/tbmenu/tb_menu_add"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	
    @RequestMapping(value="/goDetailView")
	public ModelAndView goDetailView(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
		    mv.setViewName("business/tbmenu/tb_menu_detail"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
    
	@RequestMapping(value="/goEditView")
	public ModelAndView goEditView(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
		    mv.setViewName("business/tbmenu/tb_menu_edit"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
    
	
	/**
	 * dataList
	 */
	@RequestMapping(value="/dataList")
	@ResponseBody
	public JqGridPage dataList(JqGridPage page){
		logBefore(logger, "tbMenuController");   
		List<PageData>	varList  = null;	
		try{  
			varList = tbMenuService.list(page);	  
			page.setData(varList);  
			page.setRecords(varList.size());
		} catch(Exception e){
			e.printStackTrace();
			logger.error(e.toString(), e);
		} 
		return page;
	}
	
	
	/**
	 * 新增 动作
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultAction save() throws Exception{
		logBefore(logger, "新增TUserController"); 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
	    pd.put("F_CREATE_DATE", new Date());
	    
	    int max = tbMenuService.getMax(pd);
	    pd.put("F_MENU_SERIAL", max);
		int UserId = tbMenuService.save(pd); 
		
		
	    com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public ResultAction edit() throws Exception{
		logBefore(logger, "修改TUserController");
	    ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		tbMenuService.edit(pd); 
		ResultAction ra = new ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public ResultAction delete(){
		logBefore(logger, "删除TUserController");
		ResultAction ra = new ResultAction(); 
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			tbMenuService.delete(pd);
			ra.setIserror(false);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return ra;
	}
	

 
	
 
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	@ResponseBody
	public PageData goEdit(){
		logBefore(logger, "去修改TUserController页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tbMenuService.findById(pd);	//根据ID读取 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return pd;
		
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除TUserController");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("USER_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				tbMenuService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return pd;
	}
	
	
	@ResponseBody
	@RequestMapping(params="loadAllMenu")
	public void loadAllMenu(HttpServletRequest request, HttpServletResponse response) {
		String type = request.getParameter("type");
		String F_ROLE_ID = request.getParameter("F_ROLE_ID"); 
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("type", type);
		map.put("F_ROLE_ID", F_ROLE_ID); 
		String menuJson = tbMenuService.loadAllMenu(map);
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(menuJson);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(params="awardMenuToRole")
	public ResultAction awardMenuToRole(HttpServletRequest request, HttpServletResponse response) {
		ResultAction ra = new ResultAction();
		String codes = request.getParameter("codes");
		String F_ROLE_ID = request.getParameter("F_ROLE_ID"); 
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("codes", codes);
		map.put("F_ROLE_ID", F_ROLE_ID); 
		try {
			 tbMenuService.awardMenuToRole(map);
			 ra.setIserror(false);
		} catch (Exception e1) {
			e1.printStackTrace();
			ra.setIserror(true);
		} 
		return ra;
	}
	
	
	
	
	 
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出TUserController到excel"); 
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("用户ID");	//1
			titles.add("用户名");	//2
			titles.add("性别");	//3
			titles.add("邮箱");	//4
			titles.add("手机号");	//5
			dataMap.put("titles", titles);
			List<PageData> varOList = tbMenuService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData valuePd = varOList.get(i);
				
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("F_USER_ID"));	//1
				vpd.put("var2", varOList.get(i).getString("F_UserName"));	//2
				String sex="未知"; 
				if(valuePd!=null){
					if(valuePd.get("F_Sex")!=null){
						int sexValue=  (int)valuePd.get("F_Sex");
						if(sexValue==1){
							 sex="女";
					    }else if(sexValue==0){
							 sex="男";
						} 
					} 
				}
				
				vpd.put("var3", sex);	//3
				String fEmailValue = varOList.get(i).getString("F_Email");
				if(fEmailValue==null){
					fEmailValue="未知";
				}
				vpd.put("var4", fEmailValue);	//4
				vpd.put("var5", varOList.get(i).getString("F_Mobile"));	//5
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
 
}
