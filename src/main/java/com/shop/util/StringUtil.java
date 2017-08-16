package com.shop.util;

public class StringUtil {
	
	public static boolean isEmpty(Object obj){
		
		if(obj==null||obj.toString().trim().equals("")){
			return true;
		}
		return false;
	}
}
