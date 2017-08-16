package com.shop.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class TranscodUtil {
	
	public static Date stringToDate(HttpServletRequest req, String time) throws ParseException{ 
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//小写的mm表示的是分钟   
		 Date date = null; 
		 date = sdf.parse(time); 
		req.setAttribute(time, date);
		return date;
	}
	
	public static Date stringToDate(String time) throws ParseException{ 
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟   
		Date date = sdf.parse(time);  
		return date;
	}
	
	public static Date stringToDate1(String time) throws ParseException{ 
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//小写的mm表示的是分钟   
		Date date = sdf.parse(time);  
		return date;
	}
	
}
