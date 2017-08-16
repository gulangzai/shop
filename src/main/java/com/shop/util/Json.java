package com.shop.util;

import net.sf.json.JSONArray;

public class Json {
	
	public static String praseObject(int size ,Object obj){
		String dd = JSONArray.fromObject(obj).toString(); 
		String str = "{\"total\":"+size+",\"rows\":"+dd+"}"; 
		return str;
	}
}
