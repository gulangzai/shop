package com.shop.system.sysregion.controller;

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
import com.shop.system.sysregion.service.SysRegionService;
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
@RequestMapping(value="/sysregion/sysRegionController")
public class SysRegionController extends BaseController {
	
	String menuUrl = "tbUserController/list.do"; //菜单地址(权限用)
	
	@Resource(name="sysRegionService")
	private SysRegionService sysRegionService;
	
	@RequestMapping(value="/goListView")
	public ModelAndView goListView(Page page){
		logBefore(logger, "tbuserController"); 
		ModelAndView mv = this.getModelAndView();
		try{
		 	mv.setViewName("business/tbuser/tb_user_index"); 
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
			mv.setViewName("business/tbuser/tb_user_add"); 
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
		    mv.setViewName("business/tbuser/tb_user_detail"); 
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
		    mv.setViewName("business/tbuser/tb_user_edit"); 
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
	@RequestMapping(value="/getInfoByRegionCode")
	@ResponseBody
	public ResultAction getInfoByRegionCode(String REGION_CODE){
		logBefore(logger, "tbNoticeController");   
		List<PageData>	varList  = null;	
		ResultAction ra = new ResultAction(); 
		PageData pd = new PageData();
		try{ 
			if("".equals(REGION_CODE)){
				pd.put("REGION_CODE", null);
			}else{
				pd.put("REGION_CODE", REGION_CODE);
			}
			varList = sysRegionService.getInfoByRegionCode(pd);	 
			ra.setData(varList);  
		} catch(Exception e){
			logger.error(e.toString(), e);
		} 
		return ra;
	}
	
    
	
	/**
	 * dataList
	 */
	@RequestMapping(value="/dataList")
	@ResponseBody
	public JqGridPage dataList(JqGridPage page){
		logBefore(logger, "tbNoticeController");   
		List<PageData>	varList  = null;	
		try{  
			varList = sysRegionService.list(page);	 
			page.setData(varList);  
		} catch(Exception e){
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
		pd.put("F_USER_ID", this.get32UUID());	//主键
		pd.put("F_Password", MD5.createMD5(pd.getString("F_RealPassword")));
		pd.put("F_CREATE_DATE", new Date());
		int UserId = sysRegionService.save(pd); 
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
		pd.put("F_Password", MD5.createMD5(pd.getString("F_RealPassword")));
		pd.put("F_UPDATE_DATE", new Date());
		sysRegionService.edit(pd); 
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
			sysRegionService.delete(pd);
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
			pd = sysRegionService.findById(pd);	//根据ID读取 
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
				sysRegionService.deleteAll(ArrayDATA_IDS);
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
	
	 
}
