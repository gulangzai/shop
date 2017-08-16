package com.shop.business.tbclass.controller;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.lanbao.controller.BaseController;
import com.lanbao.base.Page;  
import com.lanbao.utils.AppUtil;
import com.lanbao.utils.Const;
import com.lanbao.utils.DateUtil;
import com.lanbao.utils.DelAllFile;
import com.lanbao.utils.FileUpload; 
import com.lanbao.utils.ObjectExcelView;
import com.lanbao.base.PageData;
import com.lanbao.utils.PathUtil;
import com.lanbao.utils.Tools;
import com.lanbao.utils.Watermark;

import com.lanbao.base.ResultAction;
import com.shop.business.pictures.service.PicturesService;
import com.shop.business.tbclass.service.ClassService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/** 
 * 绫诲悕绉帮細PicturesController
 * 鍒涘缓浜猴細lanbao 
 * 鍒涘缓鏃堕棿锛�2015-03-21
 */
@Controller
@RequestMapping(value="/goodClass")
public class GoodClassController extends BaseController {
	
	String menuUrl = "goodClass/list.do"; //鑿滃崟鍦板潃(鏉冮檺鐢�)
	@Resource(name="picturesService")
	private PicturesService picturesService;
	 
	@Resource(name="classService")
	private ClassService classService;
	/**
	 * 鏂板
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public Object save(
			@RequestParam(required=false) MultipartFile file
			) throws Exception{
		logBefore(logger, "鏂板Pictures");
		Map<String,String> map = new HashMap<String,String>();
		String  ffile = DateUtil.getDays(), fileName = "";
		PageData pd = new PageData(); 
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//鏂囦欢涓婁紶璺緞
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//鎵ц涓婁紶
			}else{
				System.out.println("涓婁紶澶辫触");
			}
			
			pd.put("PICTURES_ID", this.get32UUID());			//涓婚敭
			pd.put("TITLE", "鍥剧墖");								//鏍囬
			pd.put("NAME", fileName);							//鏂囦欢鍚�
			pd.put("PATH", ffile + "/" + fileName);				//璺緞
			pd.put("CREATETIME", Tools.date2Str(new Date()));	//鍒涘缓鏃堕棿
			pd.put("MASTER_ID", "1");							//闄勫睘涓�
			pd.put("BZ", "鍥剧墖绠＄悊澶勪笂浼�");						//澶囨敞
			//鍔犳按鍗�
			Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);
			picturesService.save(pd); 
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}
	

	/**
	 * 鍒犻櫎鍟嗗搧绫诲瀷
	 */
	@RequestMapping(value="/deleteClass")
	public void deleteU(PrintWriter out){
		PageData pd = new PageData();
		try{
			pd = this.getPageData(); 
			classService.delete(pd); 
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		} 
	}
	
	/**
	 * 淇敼
	 */
/*	@RequestMapping(value="/edit")
	public ModelAndView edit(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="tpz",required=false) String tpz,
			@RequestParam(value="PICTURES_ID",required=false) String PICTURES_ID,
			@RequestParam(value="TITLE",required=false) String TITLE,
			@RequestParam(value="MASTER_ID",required=false) String MASTER_ID,
			@RequestParam(value="BZ",required=false) String BZ
			) throws Exception{
		logBefore(logger, "淇敼Pictures");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("PICTURES_ID", PICTURES_ID);		//鍥剧墖ID
			pd.put("TITLE", TITLE);					//鏍囬
			pd.put("MASTER_ID", MASTER_ID);			//灞炰簬ID
			pd.put("BZ", BZ);						//澶囨敞
			
			if(null == tpz){tpz = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//鏂囦欢涓婁紶璺緞
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//鎵ц涓婁紶
				pd.put("PATH", ffile + "/" + fileName);				//璺緞
				pd.put("NAME", fileName);
			}else{
				pd.put("PATH", tpz);
			}
			Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//鍔犳按鍗�
			picturesService.edit(pd);				//鎵ц淇敼鏁版嵁搴�
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}*/
	
	/**
	 * 淇敼
	 */
 	@RequestMapping(value="/edit")
	@ResponseBody
	public Object edit(
			HttpServletRequest request,
			@RequestParam(value="F_ClsId",required=true) String F_ClsId,
			@RequestParam(value="F_ClsName",required=false) String F_ClsName,
			@RequestParam(value="F_Status",required=false) String F_Status,
			@RequestParam(value="F_Order",required=false) String F_Order,
			@RequestParam(value="F_PClsId",required=false) String F_PClsId
			) throws Exception{ 
 		HashMap map = new HashMap();
 		ModelAndView mv = this.getModelAndView();
 		PageData pd = new PageData();
 		pd = this.getPageData();
		classService.edit(pd);		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map); 
	}
	
	/**
	 * 鍒楄〃
	 */
 	@RequestMapping(value="/listAll")
	public ModelAndView listAll(Page page,Model model){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("id",null);
		page.setPd(pd);
		List<PageData> varList;
		List<PageData> classList;
		try {  
			varList = classService.listAll(pd); 
			JSONArray classes = JSONArray.fromObject(varList);
			mv.setViewName("business/goodClass/goodClass_list");
			mv.addObject("classes", classes.toString());
			mv.addObject("pd", pd); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃
 
		return mv; 
	} 
	
	/**
	 * 鍒楄〃
	 */
	@RequestMapping(value="/classTree")
	public ModelAndView classTree(Page page,Model model){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("id",null);
		page.setPd(pd);
		List<PageData> varList;
		List<PageData> classList;
		try {  
			varList = classService.listAll(pd); 
			JSONArray classes = JSONArray.fromObject(varList);
			mv.setViewName("business/goodClass/class_tree");
			mv.addObject("classes", classes.toString());
			mv.addObject("pd", pd); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃
 
		return mv; 
	}
	
	
	@RequestMapping(value="/list")
	public ModelAndView listClass(Page page,Model model){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd); 
		List<PageData> classList;
		try {  
			classList = classService.list(page);  
			List<PageData> varList = classService.listAll(pd); 
			JSONArray classes = JSONArray.fromObject(varList);
			
			mv.setViewName("business/goodClass/class_list");  
			mv.addObject("varList",classList);
			mv.addObject("pd",pd); 
			mv.addObject("classes", classes.toString());
			
			model.addAttribute("F_ClsId", pd.get("F_ClsId"));
			model.addAttribute("classList",classList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃 
		return mv; 
	}
	
	@RequestMapping(value="/dataList")
	@ResponseBody
	public Page dataList(Page page,Model model){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd); 
		List<PageData> classList;
		try {    
			List<PageData> varList = classService.list(page); 
			page.setData(varList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	 
		return page; 
	}
	
	
	
	
	/**
	 * 鍘绘柊澧為〉闈�
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(@RequestParam(value="F_PClsId",required=true) String F_PClsId){
		logBefore(logger, "鍘绘柊澧炵被椤甸潰");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {  
			mv.setViewName("business/goodClass/tbclass_add");
			mv.addObject("pd", pd);
			mv.addObject("F_PClsId",F_PClsId);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	@RequestMapping(value="/goEditView")
	public ModelAndView goEditView(){
		logBefore(logger, "鍘讳慨鏀筭oodClass椤甸潰");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
			mv.setViewName("business/goodClass/tbclass_edit");
			mv.addObject("msg", "edit");
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
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = classService.findById(pd);	//鏍规嵁ID璇诲彇 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return pd;
	}	
	
	/**
	 * 鏂板
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST) 
	@ResponseBody
	public Object add(String F_PClsId,HttpServletRequest request) throws Exception{
		logBefore(logger, "鏂板goodClass");
		Map<String,String> map = new HashMap<String,String>(); 
		PageData pd = new PageData();
		pd = this.getPageData();
		classService.add(pd);
		map.put("result", "ok");
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg","success"); 
		//mv.setViewName("save_result");
		JSONObject obj = new JSONObject();
		obj.put("F_PClsId", F_PClsId);
		map.put("result", "ok");
		map.put("F_ClsId", F_PClsId);
		request.setAttribute("F_ClsId", F_PClsId);
		return AppUtil.returnObject(pd, map);
		//return obj.toString();
	}
	
	/**
	 * 鎵归噺鍒犻櫎
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "鎵归噺鍒犻櫎Pictures");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData(); 
				List<PageData> pdList = new ArrayList<PageData>();
				List<PageData> pathList = new ArrayList<PageData>();
				String DATA_IDS = pd.getString("DATA_IDS");
				if(null != DATA_IDS && !"".equals(DATA_IDS)){
					String ArrayDATA_IDS[] = DATA_IDS.split(",");
					pathList = picturesService.getAllById(ArrayDATA_IDS);
					//鍒犻櫎鍥剧墖
					for(int i=0;i<pathList.size();i++){
						DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pathList.get(i).getString("PATH"));
					}
					picturesService.deleteAll(ArrayDATA_IDS);
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
		return AppUtil.returnObject(pd, map);
	}
	
	/*
	 * 瀵煎嚭鍒癳xcel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "瀵煎嚭Pictures鍒癳xcel");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("鏍囬");	//1
			titles.add("鏂囦欢鍚�");	//2
			titles.add("璺緞");	//3
			titles.add("鍒涘缓鏃堕棿");	//4
			titles.add("灞炰簬");	//5
			titles.add("澶囨敞");	//6
			dataMap.put("titles", titles);
			List<PageData> varOList = picturesService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("TITLE"));	//1
				vpd.put("var2", varOList.get(i).getString("NAME"));	//2
				vpd.put("var3", varOList.get(i).getString("PATH"));	//3
				vpd.put("var4", varOList.get(i).getString("CREATETIME"));	//4
				vpd.put("var5", varOList.get(i).getString("MASTER_ID"));	//5
				vpd.put("var6", varOList.get(i).getString("BZ"));	//6
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
	
	
	//鍒犻櫎鍥剧墖
	@RequestMapping(value="/deltp")
	public void deltp(PrintWriter out) {
		logBefore(logger, "鍒犻櫎鍥剧墖");
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String PATH = pd.getString("PATH");													 		//鍥剧墖璺緞
			DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("PATH")); 	//鍒犻櫎鍥剧墖
			if(PATH != null){
				picturesService.delTp(pd);																//鍒犻櫎鏁版嵁涓浘鐗囨暟鎹�
			}	
			out.write("success");
			out.close();
		}catch(Exception e){
			logger.error(e.toString(), e);
		}
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
	
	/*--------------------------------缁欑Щ鍔ㄧ鎺ュ彛-------------------------*/
	
	@RequestMapping(value="/mobileListAll")
	@ResponseBody
	public List<PageData>  mobileListAll(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
	    String callbackFunName =req.getParameter("callbackparam");//寰楀埌js鍑芥暟鍚嶇О  
	    
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("id",null);
		page.setPd(pd);
		List<PageData> varList = null;
		List<PageData> classList;
		ResultAction resultAction = new ResultAction();
		try {  
			varList = classService.listAll(pd); 
			JSONArray classes = JSONArray.fromObject(varList);
			resultAction.setData("dd");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃
		 return  varList;    
	} 
	
	@RequestMapping(value="/mobileListSon")
	@ResponseBody
	public JSONArray  mobileListSon(Page page,Model model,HttpServletRequest req,HttpServletResponse response){
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
		page.setPd(pd);
		List<PageData> varList = null;  
		JSONArray classes = new JSONArray();
		try {  
			varList = classService.list(page); 
			classes = JSONArray.fromObject(varList); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	//鍒楀嚭Pictures鍒楄〃
		 return  classes;    
	} 
	
	
}
