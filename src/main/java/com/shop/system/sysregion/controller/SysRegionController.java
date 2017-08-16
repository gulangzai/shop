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
	private SysRegionService tbUserService;
	
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
	@RequestMapping(value="/dataList")
	@ResponseBody
	public JqGridPage dataList(JqGridPage page){
		logBefore(logger, "tbNoticeController");   
		List<PageData>	varList  = null;	
		try{  
			varList = tbUserService.list(page);	 
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
		int UserId = tbUserService.save(pd); 
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
		tbUserService.edit(pd); 
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
			tbUserService.delete(pd);
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
			pd = tbUserService.findById(pd);	//根据ID读取 
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
				tbUserService.deleteAll(ArrayDATA_IDS);
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
	
	 /**
     * 查询json
     * 
     * @param json
     * @return
     * @throws Exception
     */
    @RequestMapping(params = "checkMobile")
    @ResponseBody
    public String checkMobile(final HttpServletRequest request, HttpServletResponse response) throws Exception {
     
    	String param = request.getParameter("param");
    	String userId= request.getParameter("F_USER_ID");  
    	PageData pd = new PageData();
    	pd.put("param", param);
    	pd.put("F_USER_ID", userId);
    	
		Map<String, String> c = new HashMap<String, String>();
    	List list  = this.tbUserService.checkMobile(pd); 
		if (list.size()==0) {
				c.put("info", "该手机号可以使用！");
				c.put("status", "y");
		} else {
				c.put("info", "该手机已注册，请换一个手机号！");
				c.put("status", "n");
		} 
		JSONObject object = JSONObject.fromObject(c); 
		return object.toString();
    }
    
    /**
     * 查询json
     * 
     * @param json
     * @return
     * @throws Exception
     */
    @RequestMapping(params = "checkEmail")
    @ResponseBody
    public String checkEmail(final HttpServletRequest request, HttpServletResponse response) throws Exception {
     
    	String param = request.getParameter("param");
    	String userId= request.getParameter("F_USER_ID");  
    	PageData pd = new PageData();
    	pd.put("param", param);
    	pd.put("F_USER_ID", userId);
    	
		Map<String, String> c = new HashMap<String, String>();
    	List list  = this.tbUserService.checkEmail(pd); 
		if (list.size()==0) {
				c.put("info", "该邮箱可以使用！");
				c.put("status", "y");
		} else {
				c.put("info", "该邮箱已注册，请换一个邮箱！");
				c.put("status", "n");
		} 
		JSONObject object = JSONObject.fromObject(c); 
		return object.toString();
    }
    
    /**
     * 查询json
     * 
     * @param json
     * @return
     * @throws Exception
     */
    @RequestMapping(params = "checkName")
    @ResponseBody
    public String checkName(final HttpServletRequest request, HttpServletResponse response) throws Exception {
     
    	String param = request.getParameter("param");
    	String userId= request.getParameter("F_USER_ID");  
    	PageData pd = new PageData();
    	pd.put("param", param);
    	pd.put("F_USER_ID", userId);
    	
		Map<String, String> c = new HashMap<String, String>();
    	List list  = this.tbUserService.checkName(pd); 
		if (list.size()==0) {
				c.put("info", "该用户名可以使用！");
				c.put("status", "y");
		} else {
				c.put("info", "该用户名已注册，请换一个用户名！");
				c.put("status", "n");
		} 
		JSONObject object = JSONObject.fromObject(c); 
		return object.toString();
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
			List<PageData> varOList = tbUserService.listAll(pd);
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
	
	/**
	 * 请求登录，验证用户
	 */ 
	@RequestMapping(value="/mobileLogin" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public ResultAction login(HttpServletRequest req)throws Exception{
		 String callbackFunName =req.getParameter("callbackparam");//得到js函数名称 
		Map<String,String> map = new HashMap<String,String>();
	
		PageData pd = new PageData();
		pd = this.getPageData();   
		pd.put("F_Password", MD5.createMD5((String)pd.get("F_Password")));
		JSONPObject jp = null;
		List<PageData> varList =  tbUserService.login(pd);
		ResultAction ra = new ResultAction();
		List<PageData> isExistUser = tbUserService.hasUser(pd);
		if(isExistUser.size()==0){
			ra.setIserror(true);
			ra.setMessage("不存在该用户");
			//jp = new JSONPObject(callbackFunName, ra);
			return ra;
		}
		if(varList.size()==0){
			ra.setIserror(true);
			ra.setMessage("用户密码错误");
			jp = new JSONPObject(callbackFunName, ra); 
			return ra;
		}else{
			PageData newpd = varList.get(0);
			if(pd.get("F_Password").equals(newpd.get("F_Password"))){
				ra.setIserror(false);
				ra.setMessage("登陆成功");
				ra.setData(newpd);
				jp = new JSONPObject(callbackFunName, ra); 
			}
		} 
		return ra; 
	}
	
	/**
	 * 请求登录，验证用户
	 */ 
	@RequestMapping(value="/mobileRegister" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONPObject register(HttpServletRequest req)throws Exception{
		 String callbackFunName =req.getParameter("callbackparam");//得到js函数名称 
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();   
		pd.put("F_Password", MD5.createMD5((String)pd.get("F_Password")));
		pd.put("F_USER_ID", UUID.randomUUID().toString()); 
		pd.put("F_Deleted", "0");
		JSONPObject jp = null; 
		ResultAction ra = new ResultAction();
		List<PageData> isExistUser = tbUserService.hasUser(pd);
		if(isExistUser.size()!=0){
			ra.setIserror(true);
			ra.setMessage("存在该用户,请用别的用户名");
			jp = new JSONPObject(callbackFunName, ra);
			return jp;
		}
		List<PageData> isExistEmail = tbUserService.hasEmail(pd);
		if(isExistEmail.size()!=0){
			ra.setIserror(true);
			ra.setMessage("该邮箱已被使用");
			jp = new JSONPObject(callbackFunName, ra);
			return jp;
		}
		List<PageData> isExistMobile = tbUserService.hasMobile(pd);
		if(isExistMobile.size()!=0){
			ra.setIserror(true);
			ra.setMessage("该手机号已被使用");
			jp = new JSONPObject(callbackFunName, ra);
			return jp;
		}
		
		List<PageData> varList =  tbUserService.register(pd); 
		ra.setIserror(false);
		ra.setMessage("注册成功");
		jp = new JSONPObject(callbackFunName, ra);  
		return jp; 
	}
	
	/**
	 * 修改用户信息
	 */ 
	@RequestMapping(value="/mobileUpdateInfo" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONPObject mobileUpdateInfo(HttpServletRequest req)throws Exception{
		 String callbackFunName =req.getParameter("callbackparam");//得到js函数名称 
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();    
		JSONPObject jp = null; 
		ResultAction ra = new ResultAction(); 
		List<PageData> varList =  tbUserService.updateInfo(pd); 
		ra.setIserror(false);
		ra.setMessage("修改信息成功");
		jp = new JSONPObject(callbackFunName, ra);  
		return jp; 
	}
	
	/**
	 * 修改用户密码
	 */ 
	@RequestMapping(value="/mobileUpdatePassword" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONPObject mobileUpdatePassword(HttpServletRequest req)throws Exception{
		 String callbackFunName =req.getParameter("callbackparam");//得到js函数名称 
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();    
		JSONPObject jp = null; 
		ResultAction ra = new ResultAction(); 
		pd.put("F_Password", MD5.createMD5(pd.getString("F_Password")));
		pd.put("NEW_F_Password", MD5.createMD5(pd.getString("NEW_F_Password")));
		int result =  tbUserService.updatePassword(pd); 
		if(result==1){
			ra.setIserror(false);
			ra.setMessage("修改密码成功");
		}else{
			ra.setIserror(true);	
			ra.setMessage("修改密码失败");
		}
	
		jp = new JSONPObject(callbackFunName, ra);  
		return jp; 
	}
	
	/**
	 * 修改用户手机号
	 */ 
	@RequestMapping(value="/mobileUpdateMobile" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONPObject mobileUpdateMobile(HttpServletRequest req)throws Exception{
		 String callbackFunName =req.getParameter("callbackparam");//得到js函数名称 
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();    
		JSONPObject jp = null; 
		ResultAction ra = new ResultAction(); 
		List<PageData> varList =  tbUserService.updateMobile(pd); 
		ra.setIserror(false);
		ra.setMessage("修改密码成功");
		jp = new JSONPObject(callbackFunName, ra);  
		return jp; 
	}
	
	
	
	
	
	
	/**
	 * 通过userId获取用户信息
	 */ 
	@RequestMapping(value="/mobileGetUserById" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONPObject mobileGetUserById(HttpServletRequest req)throws Exception{
		 String callbackFunName =req.getParameter("callbackparam");//得到js函数名称 
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();    
		JSONPObject jp = null; 
		ResultAction ra = new ResultAction();
	    pd = tbUserService.findById(pd); 
		jp = new JSONPObject(callbackFunName, pd);  
		return jp; 
	}
}
