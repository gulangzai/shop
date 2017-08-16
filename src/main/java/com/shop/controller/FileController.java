package com.shop.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.shop.service.FileService;

public class FileController extends MultiActionController {
	
	private String uploadPath="E:\\addnetFile\\";//要上传文件的目录
    
	private File tempPath=new File("E:\\tempFile\\");//存放上传的文件的目录
    
	FileService fileService = null;
	 
	public FileService getFileService() {
		return fileService;
	}



	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}



	public void upload(HttpServletRequest req,HttpServletResponse res){ 
        PrintWriter out = null;
		try {
			out = res.getWriter();
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
        System.out.println("请求内容的长度为："+req.getContentLength()+" "+req.getParameter("userId"));
        System.out.println("请求内容的类型为："+req.getContentType());
         
        DiskFileItemFactory factory=new DiskFileItemFactory();
       /* factory.setRepository(tempPath);
        factory.setSizeThreshold(4096);*/
         
        ServletFileUpload upload=new ServletFileUpload(factory);
        upload.setSizeMax(1000000);
        List<?> fileitems=null;
        try{
            fileitems=upload.parseRequest(req);
            FileItemIterator fileitemss = upload.getItemIterator(req);// 解析request请求
            System.out.println("大小："+fileitems.size());
            Iterator<?> iterator=fileitems.iterator();
            String regex=".+\\\\(.+)$";
            String[] errortype={".exe",".com",".cgi",".asp"};
            Pattern p=Pattern.compile(regex);
            
            while(iterator.hasNext()){ 
                FileItem item=(FileItem) iterator.next();
                if(!item.isFormField()){
                    String name=item.getName();
                    System.out.println("-----"+name);
                    long size=item.getSize();
                    if(name==null||name.equals("")&&size==0)
                        continue;
                  //  Matcher m=p.matcher(name);
                   // if(m.find()){
                        for(int temp=0;temp<errortype.length;temp++){
                           // if(m.group(1).endsWith(errortype[temp]))
                        	if(name.endsWith(errortype[temp])){ 
                                throw new IOException(name+":wrong type");
                        	} 
                        } 
                            item.write(new File(tempPath,name));
                            System.out.println(name+"  "+size+"<br/>");
                            out.println("{\"message\":\"上传成功\"}");   
                  /*  }
                    else{ 
                        throw new IOException("fail to upload");
                    }*/
                         
                }
            }
        }catch(IOException e){ 
        	e.printStackTrace();
        	out.println("{\"message\":\""+e.getMessage()+"\"}");  
        }
        catch(FileUploadException e1){
            e1.printStackTrace();
            System.out.println("111"+e1);
        	out.println("{\"message\":\""+e1.getMessage()+"\"}");  
        }catch(Exception e){
        	 e.printStackTrace();
        	 out.println("{\"message\":\"上传失败"+e.getMessage()+"\"}");
        	 out.close();
        }
	}
}
