package com.shop.util;

import java.io.File;
import java.util.Iterator;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class XmlUtil {
	
	private String fileName = null;
	
	public XmlUtil(String fileName){
		this.fileName = fileName;
	}
	  
	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public void parseXML(){  
        File myXML = new File(fileName);  
        SAXReader sr = new SAXReader();  
       try {  
           Document doc  =  sr.read(myXML);  
           Element root = doc.getRootElement(); 
           System.out.println(root.getName());

           for (Iterator fathers = root.elementIterator();fathers.hasNext();) {  
               Element father = (Element) fathers.next();  
               System.out.println(father.getName());
               for (Iterator childs = father.elementIterator();childs.hasNext();) {  
                   Element child = (Element) childs.next();  
                   System.out.println(child.getName()+"值"+child.getText());
               }  
           }  
       } catch (DocumentException e) {  
           e.printStackTrace();  
       }  
   } 
}
