package com.shop.system.tbrole.controller;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lanbao.controller.BaseController;
import com.lanbao.entity.User;
import com.lanbao.base.JqGridPage;
import com.lanbao.base.Page;
import com.lanbao.utils.AppUtil;
import com.lanbao.utils.ObjectExcelView;
import com.lanbao.utils.Const;
import com.lanbao.base.PageData;
import com.lanbao.base.ResultAction;
import com.lanbao.utils.Tools;

import com.shop.system.tbrole.service.TbRoleService;
import com.shop.system.tbuser.service.TbUserService;

import com.lanbao.utils.Jurisdiction;
import com.lanbao.utils.MD5; 

/** 
 * 类名称：TUserController
 * 创建人：lanbao 
 * 创建时间：2016-06-05
 */
@Controller
@RequestMapping(value="/tbrole/tbRoleController")
public class TbRoleController extends BaseController {
	
	String menuUrl = "tbRoleController/list.do"; //菜单地址(权限用)
	
	@Resource(name="tbRoleService")
	private TbRoleService tbRoleService;
	
	@RequestMapping(value="/goListView")
	public ModelAndView goListView(Page page){ 
		ModelAndView mv = this.getModelAndView();
		try{
		 	mv.setViewName("business/tbrole/tb_role_index"); 
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
			mv.setViewName("business/tbrole/tb_role_add"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	@RequestMapping(value="/goRoleMenuView")
	public ModelAndView goRoleMenuView(){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {  
			mv.setViewName("business/tbrolemenu/tb_role_menu"); 
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
		    mv.setViewName("business/tbrole/tb_role_detail"); 
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
		    mv.setViewName("business/tbrole/tb_role_edit"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	@RequestMapping(value="/toUserRole",method = RequestMethod.GET)
	public ModelAndView toUserRole(Page page){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();   
		try{  
			//List<PageData> varList = tbRoleService.listAll(pd);
			List<PageData> varList = tbRoleService.getUserRole(pd);
			mv.addObject("varList", varList);
			mv.addObject("F_USER_ID", pd.get("F_USER_ID"));
			mv.setViewName("business/tbuserrole/userrole"); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@RequestMapping(value="/toRoleUser",method = RequestMethod.GET)
	public ModelAndView toRoleUser(Page page){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();   
		try{   
			List<PageData> varList = tbRoleService.getRoleUser(pd);
			mv.addObject("varList", varList);
			mv.addObject("F_ROLE_ID", pd.get("F_ROLE_ID"));
			mv.setViewName("business/tbroleuser/roleuser"); 
		} catch(Exception e){
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
		logBefore(logger, "tbNoticeController");   
		List<PageData>	varList  = null;	
		try{  
			varList = tbRoleService.list(page);	 
			page.setData(varList);  
		} catch(Exception e){
			logger.error(e.toString(), e);
		} 
		return page;
	}
	
 
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultAction save() throws Exception{
		logBefore(logger, "新增TUserController");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		pd.put("F_CREATE_DATE", new Date());
		int UserId = tbRoleService.save(pd); 
		com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false); 
		return ra;
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/saveUserRole")
	public ModelAndView saveUserRole(HttpServletRequest req,HttpSession session) throws Exception{
		logBefore(logger, "新增TUserController"); 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		String[] roles = req.getParameterValues("F_ROLE_ID");
		String[] status_array = req.getParameterValues("F_STATUS");
		PageData source_pd = this.getPageData();
		pd.put("F_USER_ID", source_pd.get("F_USER_ID"));
		
	    if(roles!=null){
	    	for(int i=0;i<status_array.length;i++){
	    		String status = status_array[i];
	    		pd.put("F_ROLE_ID", roles[i]); 
	    		if("-1".equals(status)){
	    			 tbRoleService.deleteRoleByUser(pd);
	    		}else if("0".equals(status)){
	    			tbRoleService.saveUserRole(pd); 
	    		}   
			} 
	    } 
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 给角色添加用户
	 */
	@RequestMapping(value="/saveRoleUser")
	public ModelAndView saveRoleUser(HttpServletRequest req,HttpSession session) throws Exception{
		logBefore(logger, "新增TUserController"); 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		String[] users = req.getParameterValues("F_USER_ID");
		String[] status_array = req.getParameterValues("F_STATUS");
		PageData source_pd = this.getPageData();
		pd.put("F_ROLE_ID", source_pd.get("F_ROLE_ID"));
		
	    if(users!=null){
	    	for(int i=0;i<status_array.length;i++){
	    		String status = status_array[i];
	    		pd.put("F_USER_ID", users[i]); 
	    		if("-1".equals(status)){
	    			 tbRoleService.deleteRoleByUser(pd);
	    		}else if("0".equals(status)){
	    			tbRoleService.saveUserRole(pd); 
	    		}   
			} 
	    } 
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	
	
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public ResultAction edit() throws Exception{
		logBefore(logger, "修改TUserController");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("F_UPDATE_DATE", new Date());
		tbRoleService.edit(pd);
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
			tbRoleService.delete(pd); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return ra;
	}
	

	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(JqGridPage page){
		logBefore(logger, "列表TUserController"); 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData(); 
			page.setPd(pd);
			List<PageData>	varList = tbRoleService.list(page);	//列出TUserController列表
			mv.setViewName("system/tbrole/tbrole_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	@ResponseBody
	public PageData goEdit(){
		logBefore(logger, "去修改TUserController页面"); 
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tbRoleService.findById(pd);	//根据ID读取 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return pd;
	}	
	
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增TUserController页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("system/tbrole/tbrole_add");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
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
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				tbRoleService.deleteAll(ArrayDATA_IDS);
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
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出TRoleController到excel"); 
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>(); 
			titles.add("角色名");	//2
			titles.add("是否可用");
			titles.add("备注");	//3  
			dataMap.put("titles", titles);
			List<PageData> varOList = tbRoleService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData valuePd = varOList.get(i);
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("F_ROLE_NAME"));	//1 
				String sex="停用";
				if(valuePd!=null){
					if(valuePd.get("F_STATUS")!=null){
						int sexValue=  (int)valuePd.get("F_STATUS");
						if(sexValue==1){
							sex="可用";
					    }else if(sexValue==0){
							 sex="停用";
						} 
					} 
				} 
				vpd.put("var2", sex);	//2 
				vpd.put("var3", varOList.get(i).getString("DESCRIPTION"));	//3
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
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
