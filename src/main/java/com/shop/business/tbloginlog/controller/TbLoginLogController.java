package com.shop.business.tbloginlog.controller; 
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
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lanbao.controller.BaseController;
import com.lanbao.base.JqGridPage;
import com.lanbao.base.Page;
import com.lanbao.utils.AppUtil;
import com.lanbao.utils.ObjectExcelView;
import com.lanbao.utils.Const;
import com.lanbao.base.PageData;
import com.lanbao.utils.Tools;

import com.lanbao.base.ResultAction;
import com.shop.business.pictures.service.PicturesService;
import com.shop.business.standard.service.StandardService;
import com.shop.business.tbloginlog.service.TbLoginLogService;
import com.shop.business.tbnotice.service.TbNoticeService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject; 

/** 
 *  tbLoginLogController
 * 
 */
@Controller
@RequestMapping(value="/tbloginlog/tbLoginLogController")
public class TbLoginLogController extends BaseController {
	
	String menuUrl = "tbloginlog/tbLoginLogController/list.do";  
	
	@Resource(name="tbLoginLogService")
	private TbLoginLogService tbLoginLogService;
	
	@Resource(name="picturesService")
	private PicturesService picturesService;
	 
	 
	/**
	 * save
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultAction save() throws Exception{
		logBefore(logger, "tbLoginLogController");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();     
		int F_ORDER_UID = tbLoginLogService.save(pd); 
		HttpServletRequest request = this.getRequest();
		String[] PICTURES_IDs = request.getParameterValues("PICTURES_ID");
		if(!"".equals(PICTURES_IDs)&&null!=PICTURES_IDs){
			for(int i=0;i<PICTURES_IDs.length;i++){
				//存图片
				pd.put("PICTURES_ID", PICTURES_IDs[i]);
				PageData picture = picturesService.findById(pd); 
				picture.put("TABLE_NAME", "TB_ORDER");			 
				picture.put("TABLE_UID_VALUE",F_ORDER_UID);						  
				picturesService.update(picture);
			} 
		}
	    com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	/**
	 * delete
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public ResultAction delete(){
		logBefore(logger, "tbLoginLogController");
		ResultAction ra = new ResultAction(); 
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			tbLoginLogService.delete(pd); 
			ra.setIserror(false);
		} catch(Exception e){
			ra.setIserror(true);
			logger.error(e.toString(), e);
		} 
		return ra;
	}
	
	/**
	 * edit
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public ResultAction edit(HttpServletRequest request) throws Exception{
	    ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		tbLoginLogService.edit(pd); 
	     String[] PICTURES_IDs = request.getParameterValues("PICTURES_ID");
		if(!"".equals(PICTURES_IDs)&&PICTURES_IDs!=null){
			for(int i=0;i<PICTURES_IDs.length;i++){
				//存图片
				pd.put("PICTURES_ID", PICTURES_IDs[i]);
				PageData picture = picturesService.findById(pd); 
				picture.put("TABLE_NAME", "TB_ORDER");			 
				picture.put("TABLE_UID_VALUE",pd.getString("F_ORDER_UID"));						  
				picturesService.update(picture);
			} 
		}
		
		com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	 /**
	 * list
	 */
	@RequestMapping(value="/goListView")
	public ModelAndView goListView(Page page){
		logBefore(logger, "tbLoginLogController"); 
		ModelAndView mv = this.getModelAndView();
		try{
		 	mv.setViewName("business/tbloginlog/tb_login_log_index"); 
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
		logBefore(logger, "tbLoginLogController");   
		List<PageData>	varList  = null;	
		try{  
			varList = tbLoginLogService.list(page);	 
			page.setData(varList);  
		} catch(Exception e){
			logger.error(e.toString(), e);
		} 
		return page;
	}
	
	/**
	 * goAdd
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("business/tbloginlog/tb_login_log_add");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * goEdit
	 */
	@RequestMapping(value="/goEdit")
	@ResponseBody
	public PageData goEdit(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tbLoginLogService.findById(pd);	 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return pd;
	}	
	
	@RequestMapping(value="/goEditView")
	public ModelAndView goEditView(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
		    mv.setViewName("business/tbloginlog/tb_login_log_edit"); 
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
		    mv.setViewName("business/tbloginlog/tb_login_log_detail"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
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
			mv.setViewName("business/tbloginlog/tb_login_log_add"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	
	
	
	/**
	 * deleteAll
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() { 
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				tbLoginLogService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出TUserController到excel"); 
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("登录日志编号");	//1
			titles.add("用户账号");	//2
			titles.add("用户名");	    //3
			titles.add("登录时间");	//4
			titles.add("登出时间");	//5 
			dataMap.put("titles", titles);
			List<PageData> varOList = tbLoginLogService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData valuePd = varOList.get(i);
				if(valuePd!=null){
					PageData vpd = new PageData();
					vpd.put("var1", String.valueOf(valuePd.get("F_LOGIN_LOG_UID")));	//1
					vpd.put("var2", valuePd.getString("userId"));	//2 
					vpd.put("var3", valuePd.getString("F_UserName"));	//3  
				    vpd.put("var4", valuePd.getString("loginTime"));	//4
					vpd.put("var5", valuePd.getString("loginOut"));	//5
					varList.add(vpd);
				} 
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
