package com.shop.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import com.shop.jopo.User;

/*
 * 编写人：李益
 * */
public class CommonUtil {
	
	public CommonUtil(){
/*		 User user = (User)CommonUtil.objectFromReq(User.class,null);
		 System.out.println("---"+user.getName());*/
	}

	public static <T> Object objectFromReq(Class<T> myclass, HttpServletRequest req)throws Exception {
		// TODO Auto-generated method stub
	
		String classname = myclass.getName();
		Object sourceObj = Class.forName(classname).newInstance();
		  	Field[] attributes = myclass.getDeclaredFields();
		   	for(Field field : attributes){
		   		String fieldName = field.getName();
		   		Class<?> fieldType = field.getType();
		   		String fieldTypeName = field.getType().getName();
		   		
		   		String methodName = "set"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1);
		   		Method method = myclass.getDeclaredMethod(methodName,fieldType); 
		   		String value = req.getParameter(fieldName);
		   		Object valueObj = value;
		   		//Class<?> myType = Class.forName(fieldTypeName);
		   		System.out.println("字段名"+field.getName()+"字段类型:"+fieldTypeName+"方法名："+methodName+"插入值："+valueObj);

		   		
		   		if(!StringUtil.isEmpty(value)){
		   			System.out.println("value:"+value);
		   			if(fieldTypeName.equals("int")){
		   				valueObj=Integer.parseInt(value); 
		   			}else if(fieldTypeName.equals("java.util.Date")){
		   				valueObj = TranscodUtil.stringToDate(value);
		   			} else if(fieldTypeName.equals("java.lang.Long")){
		   				valueObj = Long.valueOf(value);
		   			}
		   			method.invoke(sourceObj,valueObj); 
			   		
		   		} 
		   	} 
		   	System.out.println("对象的类型："+classname);
 
		return sourceObj;
	}
	
	
	public static <E> void test(Class<E> obj){
 
	
	}
	
	//获取对象的类型
	public static void getMyType(){
		User user = new User(); 
		//System.out.println("对象的类型："+new Integer(ii).getClass().getName());
	}
	
	
	public static void main(String[] args) {
		//CommonUtil.test(User.class);
		//CommonUtil.getMyType();
		new CommonUtil();
	}

}
