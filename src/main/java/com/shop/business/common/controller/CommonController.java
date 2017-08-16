package com.shop.business.common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lanbao.controller.BaseController;
import com.lanbao.base.Page;
import com.lanbao.utils.Const;
import com.lanbao.base.PageData;
 
@Controller
@RequestMapping(value="/common")
public class CommonController  extends BaseController {
	 
	
	@RequestMapping(value="/userrole")
	public ModelAndView list(Page page){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{ 
			
			mv.setViewName("system/tbuserrole/userrole"); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
}
