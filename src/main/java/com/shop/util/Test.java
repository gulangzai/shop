package com.shop.util;

public class Test {

	Test(){
		 String path="D:\\南京证券#130000001285(2015.6.9).htm";
		 String replace = path.replace("#", "");
		 System.out.println(replace);
		 String replaceAll2 = replace.replaceAll("//(", "");
		 System.out.println(replaceAll2);
		 String replaceAll3 = replaceAll2.replaceAll("//)", "");
		 System.out.println(replaceAll3);
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
         new Test();
	}

}
