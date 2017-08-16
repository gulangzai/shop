package com.shop.business.pmfxy.controller;

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
import com.lanbao.utils.RequestUtil;
import com.lanbao.utils.Const;
import com.lanbao.base.PageData; 
import com.lanbao.utils.Tools; 
import com.lanbao.base.ResultAction;
import com.shop.business.pictures.service.PicturesService;
import com.shop.business.pmfxy.service.PmFxyService;
import com.shop.business.standard.service.StandardService;
import com.shop.business.tbproduct.service.TbProductService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.lanbao.entity.requestJson;
import com.lanbao.entity.PageManager;

import com.lanbao.utils.Jurisdiction; 

/** 
 * 绫诲悕绉帮細TProductController
 * 鍒涘缓浜猴細lanbao 
 * 鍒涘缓鏃堕棿锛�2016-06-05
 */
@Controller
@RequestMapping(value="/pmfxy/pmFxyController")
public class PmFxyController extends BaseController {
	
	String menuUrl = "tbProductController/list.do"; //鑿滃崟鍦板潃(鏉冮檺鐢�)
	
	@Resource(name="pmFxyService")
	private PmFxyService pmFxyService;
	
	@Resource(name="standardService")
	private StandardService standardService;
	
	@Resource(name="picturesService")
	private PicturesService picturesService;
	
	
	/**
	 * 去列表
	 */
	@RequestMapping(value="/toList")
	public ModelAndView toList(Page page){
		logBefore(logger, "列表TUserController"); 
		ModelAndView mv = this.getModelAndView(); 
		try{ 
			mv.setViewName("business/pmfxy/pm_fxy_index"); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(params="query")
	public  requestJson query(Page page,requestJson json){
		
		PageManager page_my = RequestUtil.getPageManager(json.getMsg());
        String condition = RequestUtil.getConditionList(json.getMsg()).getConditionWhere();
        String orderFilter = RequestUtil.getOrderFilter(json.getMsg()); 
    	PageData pd = new PageData();
    	pd.put("keyword", condition);
    	pd.put("order", orderFilter);
    	page.setPd(pd);
        page.setCurrentPage(page_my.getCurrentPage());
        page.setPageSize(page_my.getPageRows()); 
		logBefore(logger, "鍒楄〃TProductController"); 
		requestJson requestJson = new requestJson();
		
		try{
		
			List<PageData>	varList = pmFxyService.list(page);	//鍒楀嚭TProductController鍒楄〃
			JSONObject pages = new JSONObject();
			pages.put("recordsperpage", page.getShowCount());
			pages.put("currentpagenum", page.getCurrentPage());
			pages.put("countrows", page.getTotalResult());
			pages.put("totalpage", page.getTotalPage()); 
			JSONObject data = new JSONObject();
			data.put("data", varList); 
			JSONObject msg = new JSONObject();
			msg.put("response", data);
			msg.put("pages", pages); 
			requestJson.setMsg(msg.toString());
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return requestJson;
	}
	
	
	 /**
     * 保存数据json
     * 
     * @param json
     * @return
     * @throws Exception
     */
    @RequestMapping(params = "insert")
    @ResponseBody
    protected requestJson insert(final HttpServletRequest request, requestJson json) throws Exception {  
        requestJson j = new requestJson();
        int fxyUid = 0;
        PageData pd = new PageData(request);
        fxyUid  =  pmFxyService.save(json.getMsg());
        j.setMsg(pd.toString());
        return j;
    }
    
    /**
     * 修改记录.
     * 
     * @param request
     * @param json
     * @return
     * @throws Exception
     * @since v1.00
     */
    @RequestMapping(params = "update")
    @ResponseBody
    protected requestJson update(HttpServletRequest request, requestJson json) throws Exception { 
        requestJson j = new requestJson();
        String resultVO = "";
        resultVO = this.pmFxyService.update(json.getMsg());
        j.setMsg(resultVO);
        return j;
    }

    /**
     * 删除记录.
     * 
     * @param request
     * @param json
     * @return
     * @throws Exception
     * @since v1.00
     */
    @RequestMapping(params = "delete")
    @ResponseBody
    public requestJson delete(HttpServletRequest request, requestJson json) throws Exception { 
        requestJson j = new requestJson();
        String resultVO = "";
        resultVO = this.pmFxyService.delete(json.getMsg());
        j.setMsg(resultVO);
        return j;
    }
    
}
