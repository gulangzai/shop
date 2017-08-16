package com.shop.business.tbproduct.controller;

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
import com.lanbao.base.Page;
import com.lanbao.utils.AppUtil;
import com.lanbao.utils.ObjectExcelView;
import com.lanbao.utils.Const;
import com.lanbao.base.PageData;
import com.lanbao.utils.Tools;

import com.lanbao.base.ResultAction;
import com.shop.business.pictures.service.PicturesService;
import com.shop.business.standard.service.StandardService;
import com.shop.business.tbproduct.service.TbProductService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.lanbao.utils.Jurisdiction; 

/** 
 * TProductController
 * lanbao 
 * 2016-06-05
 */
@Controller
@RequestMapping(value="/tbProductController")
public class TbProductController extends BaseController {
	
	String menuUrl = "tbProductController/list.do"; //鑿滃崟鍦板潃(鏉冮檺鐢�)
	
	@Resource(name="tbProductService")
	private TbProductService tbProductService;
	
	@Resource(name="standardService")
	private StandardService standardService;
	
	@Resource(name="picturesService")
	private PicturesService picturesService;
	
	
	/**
	 * 鍒楄〃
	 */
	@RequestMapping(value="/goListView")
	public ModelAndView list(Page page){
		logBefore(logger, "鍒楄〃TProductController");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //鏍￠獙鏉冮檺
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			mv.setViewName("business/tbproduct/tbproduct_list");  
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	
	/**
	 * 鍒楄〃
	 */
	@RequestMapping(value="/dataList")
	@ResponseBody
	public Page dataList(){
		logBefore(logger, "鍒楄〃TProductController");  
		Page page =  new Page(); 
		PageData pd = this.getPageData();
		List<PageData>	varList  = null;
		try{ 
			page.setPd(pd);  
			varList = tbProductService.list(page);	//鍒楀嚭TProductController鍒楄〃 
			page.setData(varList);  
		} catch(Exception e){
			logger.error(e.toString(), e);
		} 
		return page;
	}
	
	
	@RequestMapping(value="/goAddView")
	public ModelAndView goAddView(){
		logBefore(logger, "鍘讳慨鏀筎ProductController椤甸潰");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
			mv.setViewName("business/tbproduct/tbproduct_add");
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	
	/**
	 * 鏂板
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultAction save() throws Exception{
		logBefore(logger, "鏂板TProductController");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //鏍￠獙鏉冮檺
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//pd.put("TPRODUCTCONTROLLER_ID", this.get32UUID());	//涓婚敭
		String f_StandardName = pd.getString("F_StandardName");
		pd.put("F_ProductTime", new Date());
		int productId = tbProductService.save(pd);
		
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
				pds.put("F_PRODUCT_ID",productId);
				standardService.save(pds);
			} 
		}
		
		String[] PICTURES_IDs = request.getParameterValues("PICTURES_ID");
		if(!"".equals(PICTURES_IDs)&&PICTURES_IDs!=null){
			for(int i=0;i<PICTURES_IDs.length;i++){
				//存图片
				pd.put("PICTURES_ID", PICTURES_IDs[i]);
				PageData picture = picturesService.findById(pd); 
				picture.put("TABLE_NAME", "TB_PRODUCT");			 
				picture.put("TABLE_UID_VALUE",productId);						  
				picturesService.update(picture);
			} 
		}
	    
		com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	/**
	 * 鍒犻櫎
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public ResultAction delete(){
		logBefore(logger, "TProductController"); 
		ResultAction ra = new ResultAction(); 
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			tbProductService.delete(pd); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		ra.setIserror(false);
		return ra;
	}
	
	

	
	/**
	 * 鍘绘柊澧為〉闈�
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "鍘绘柊澧濼ProductController椤甸潰");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("business/tbproduct/tbproduct_add");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 鍘讳慨鏀归〉闈�
	 */
	@RequestMapping(value="/goEdit")
	@ResponseBody
	public PageData goEdit(){
		logBefore(logger, "鍘讳慨鏀筎ProductController椤甸潰");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tbProductService.findById(pd);	//鏍规嵁ID璇诲彇 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return pd;
	}	
	
	@RequestMapping(value="/goEditView")
	public ModelAndView goEditView(){
		logBefore(logger, "鍘讳慨鏀筎ProductController椤甸潰");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
			mv.setViewName("business/tbproduct/tbproduct_edit");
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 淇敼
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public ResultAction edit(HttpServletRequest request) throws Exception{
		logBefore(logger, "淇敼TProductController");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //鏍￠獙鏉冮檺
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String PICTURES_ID = pd.getString("PICTURES_ID");
		String F_PRODUCT_ID = pd.getString("F_PRODUCT_ID"); 
		String[] PICTURES_IDs = request.getParameterValues("PICTURES_ID"); 
		if(PICTURES_IDs!=null&&!"".equals(PICTURES_IDs)){
			for(int i=0;i<PICTURES_IDs.length;i++){
				//存图片
				pd.put("PICTURES_ID", PICTURES_IDs[i]);
				PageData picture = picturesService.findById(pd); 
				picture.put("TABLE_NAME", "TB_PRODUCT");			 
				picture.put("TABLE_UID_VALUE",F_PRODUCT_ID);						  
				picturesService.update(picture);
			} 
		}
		 
		tbProductService.edit(pd); 
		com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	
	
	
	
	
	/**
	 * 鎵归噺鍒犻櫎
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public PageData deleteAll() {
		logBefore(logger, "鎵归噺鍒犻櫎TProductController");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //鏍￠獙鏉冮檺
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				tbProductService.deleteAll(ArrayDATA_IDS);
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
	 * 瀵煎嚭鍒癳xcel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "瀵煎嚭TProductController鍒癳xcel"); 
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("鍟嗗搧鍚�");	//1
			titles.add("鍟嗗搧鎻忚堪");	//2
			titles.add("鍟嗗搧浠锋牸");	//3
			titles.add("鍟嗗搧绫诲瀷");	//4
			titles.add("鏄惁鐗瑰崠");	//5
			dataMap.put("titles", titles);
			List<PageData> varOList = tbProductService.listAll(pd);
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
	
	/* ===============================鏉冮檺================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro绠＄悊鐨剆ession
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================鏉冮檺================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	/*------------------------mobile-------------------*/
	@RequestMapping(value="/mobileListByClassId")
	@ResponseBody
	public JSONPObject  mobileListByClassId(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
	    String callbackFunName =req.getParameter("callbackparam");//寰楀埌js鍑芥暟鍚嶇О  
	    
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd);
		List<PageData> varList = null;  
		try {  
			varList = tbProductService.findByClassId(page); 
			JSONArray classes = JSONArray.fromObject(varList); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃
		 return new JSONPObject(callbackFunName, varList);    
	} 
	
	@RequestMapping(value="/mobileProductById")
	@ResponseBody
	public PageData  mobileProductById(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
	    String callbackFunName =req.getParameter("callbackparam");//寰楀埌js鍑芥暟鍚嶇О  
	    
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd);
		PageData tbProduct = null;  
		try {  
			tbProduct = tbProductService.findById(pd);  
			JSONArray classes = JSONArray.fromObject(tbProduct); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃
		 return   tbProduct;    
	} 
	
	@RequestMapping(value="/mobileProductHot")
	@ResponseBody
	public List<PageData>  mobileProductHot(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
	    String callbackFunName =req.getParameter("callbackparam");//寰楀埌js鍑芥暟鍚嶇О  
	    
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd);
		PageData tbProduct = null;  
		List<PageData> varList = null; 
		try {  
			//tbProduct = tbProductService.findById(pd);  
			varList = tbProductService.findNewHot(page); 
			//鑾峰彇鐑棬鍙戝竷鐨�5涓晢鍝�
			//List<TProductDto> tproductHots = tproductMapper.findNewHot(); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃
		 return  varList;    
	} 
}
