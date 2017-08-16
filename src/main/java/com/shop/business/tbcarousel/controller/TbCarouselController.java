package com.shop.business.tbcarousel.controller;

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
import com.lanbao.base.ResultAction;
import com.lanbao.utils.Tools; 

import com.shop.business.standard.service.StandardService;
import com.shop.business.tbcarousel.service.TbCarouselService; 
import net.sf.json.JSONArray;

import com.lanbao.utils.Jurisdiction; 

/** 
 * 类名称：TProductController
 * 创建人：lanbao 
 * 创建时间：2016-06-05
 */
@Controller
@RequestMapping(value="/tbcarousel/tbCarouselController")
public class TbCarouselController extends BaseController {
	
	String menuUrl = "tbCarouselController/list.do"; //菜单地址(权限用)
	
	@Resource(name="tbCarouselService")
	private TbCarouselService tbCarouselService;
	
	@Resource(name="standardService")
	private StandardService standardService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultAction save() throws Exception{
		logBefore(logger, "新增TbCarouselController"); 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String f_StandardName = pd.getString("F_StandardName");
		int productId = tbCarouselService.save(pd);
		
		HttpServletRequest request = this.getRequest();
		Map properties = request.getParameterMap();
		String[] F_StandardNames = (String[]) properties.get("F_StandardName[]"); 
		String[] F_StandardValues = (String[]) properties.get("F_StandardValue[]"); 
		String[] F_XUHAOs = (String[]) properties.get("F_XUHAO[]"); 
		if(F_StandardNames!=null){
			for(int i=0;i<F_StandardNames.length;i++){
				PageData pds = new PageData();
				pds.put("F_StandardName", F_StandardNames[i]);
				pds.put("F_StandardValue", F_StandardValues[i]);
				pds.put("F_XUHAO", F_XUHAOs[i]);
				pds.put("F_PRODUCT_ID", pd.get("id"));
				standardService.save(pds);
			} 
		}
		com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public ResultAction delete(){
		logBefore(logger, "删除TbCarouselController"); 
		ResultAction ra = new ResultAction(); 
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			tbCarouselService.delete(pd);
			ra.setIserror(false);
		} catch(Exception e){
			ra.setIserror(true);
			logger.error(e.toString(), e);
		} 
		return ra; 
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public ResultAction edit(){
		logBefore(logger, "修改TProductController"); 
		ModelAndView mv = this.getModelAndView();
		com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			tbCarouselService.edit(pd);
		    ra.setIserror(false);
		} catch (Exception e) {
			 ra.setIserror(true);
			// TODO Auto-generated catch block
			e.printStackTrace();
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
			varList = tbCarouselService.list(page);	 
			page.setData(varList);  
		} catch(Exception e){
			logger.error(e.toString(), e);
		} 
		return page;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增TProductController页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("information/tbcarousel/tbcarousel_add");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
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
		logBefore(logger, "去修改轮播页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tbCarouselService.findById(pd);	//根据ID读取 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return pd;
	}	
	
	 /**
	 * list
	 */
	@RequestMapping(value="/goListView")
	public ModelAndView goListView(Page page){
		logBefore(logger, "tbNoticeController"); 
		ModelAndView mv = this.getModelAndView();
		try{
		 	mv.setViewName("business/tbcarousel/tbcarousel_list"); 
		} catch(Exception e){
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
		    mv.setViewName("business/tbcarousel/tbcarousel_edit"); 
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
		    mv.setViewName("business/tbcarousel/tbcarousel_detail"); 
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
			mv.setViewName("business/tbcarousel/tbcarousel_add"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
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
		logBefore(logger, "批量删除TProductController");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				tbCarouselService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出TProductController到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("商品名");	//1
			titles.add("商品描述");	//2
			titles.add("商品价格");	//3
			titles.add("商品类型");	//4
			titles.add("是否特卖");	//5
			dataMap.put("titles", titles);
			List<PageData> varOList = tbCarouselService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("F_ProductName"));	//1
				vpd.put("var2", varOList.get(i).getString("F_ProductDesc"));	//2
				vpd.put("var3", varOList.get(i).get("F_Price").toString());	//3
				vpd.put("var4", String.valueOf(varOList.get(i).get("F_ClsId")));	//4
				vpd.put("var5", varOList.get(i).get("F_IsSpecial").toString());	//5
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
	
	/*------------------------mobile-------------------*/
	@RequestMapping(value="/mobileListByClassId")
	@ResponseBody
	public List<PageData>  mobileListByClassId(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
	    String callbackFunName =req.getParameter("callbackparam");//得到js函数名称  
	    
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd);
		List<PageData> varList = null;  
		try {  
			//varList = tbCarouselService.findByClassId(page); 
			JSONArray classes = JSONArray.fromObject(varList); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//列出Pictures列表
		 return  varList;    
	} 
	
	@RequestMapping(value="/mobileProductById")
	@ResponseBody
	public PageData  mobileProductById(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
	    String callbackFunName =req.getParameter("callbackparam");//得到js函数名称  
	    
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd);
		PageData tbProduct = null;  
		try {  
			tbProduct = tbCarouselService.findById(pd);  
			JSONArray classes = JSONArray.fromObject(tbProduct); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//列出Pictures列表
		 return tbProduct;    
	} 
	
	@RequestMapping(value="/mobileProductHot")
	@ResponseBody
	public List<PageData> mobileProductHot(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
	    String callbackFunName =req.getParameter("callbackparam");//得到js函数名称  
	    
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd);
		PageData tbProduct = null;  
		List<PageData> varList = null; 
		try {  
			//tbProduct = tbCarouselService.findById(pd);  
			//varList = tbCarouselService.findNewHot(page); 
			//获取热门发布的5个商品
			//List<TProductDto> tproductHots = tproductMapper.findNewHot(); 
		} catch (Exception e) { 
			e.printStackTrace();
		}	//列出Pictures列表
		 return  varList;    
	} 
}
