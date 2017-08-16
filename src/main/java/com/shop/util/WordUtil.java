package com.shop.util;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

public class WordUtil {
	
	
	 //word文档
	private Dispatch doc;
	
	//word运行程序对象
	private ActiveXComponent word;
	
	//所有word文档集合
	private Dispatch documents;
	
	//选定的范围或插入点
	private Dispatch selection;
	
	private boolean saveOnExit = true;
	
	public static void main(String[] args) {
		try {
			new WordUtil(false);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public WordUtil(boolean visible)throws Exception{
		if(word==null){
			word = new  ActiveXComponent("Word.Application");
			//不可见打开word
			word.setProperty("Visible",new Variant(visible));
			//word.setProperty("AutomationSecurity", new Variant(3)); // 禁用宏 
		}
		if(documents==null)
			documents = word.getProperty("Documents").toDispatch();
		
		openDocument("E://abc.doc");	 
		setFont(true,true,true);
		closeDocument(-2);
		System.out.println("--------------"); 
	}
	
	//设置推出时参数
	public void setSaveOnExit(boolean saveOnExit){
		this.saveOnExit = saveOnExit;
	}
	
	/**
	 * 创建一个新的 word文档
	*/
	public void createNewDocument(){
		doc = Dispatch.call(documents, "Add").toDispatch();
		selection = Dispatch.get(word,"Selection").toDispatch();
	}
	
	//打开一个已存在的文档
	public void openDocument(String docPath){
		closeDocument();
		doc = Dispatch.call(documents, "Open",docPath).toDispatch();
		selection = Dispatch.get(word,"Selection").toDispatch();
	}
	
	//打开一个保护文档
	public void openDocumentOnlyRead(String docPath,String pwd){
		closeDocument();
		doc = Dispatch.callN(documents, "Open", 
           new Object[]{docPath,new Variant(false),new Variant(false),
				new Variant(true),pwd}
				).toDispatch();
	}
	
	public void openDocument(String docPath,String pwd)throws Exception{
		closeDocument();
		doc = Dispatch.callN(documents,
				"Open",
				new Object[]{docPath,new Variant(false),new Variant(false),
				new Variant(true),pwd}
				).toDispatch();
	}
	
	// 把选定的内容或插入点向上移动
	public void moveUp(int pos){
		if(selection == null){
			selection = Dispatch.get(word,"Selection").toDispatch();
			for(int i=0;i<pos;i++)
				Dispatch.call(selection, "MoveUp");
		}
	}
	
	//把选定的内容或者插入点向下移动
	public void moveDown(int pos){
		if(selection == null)
			selection = Dispatch.get(word,"Selection").toDispatch();
		for(int i=0;i<pos;i++)
			Dispatch.call(selection, "MoveDown");
	}
	
	//把选定的内容或者插入点向左移动
	public void moveLeft(int pos){
		if(selection==null){
			selection = Dispatch.get(word,"Selection").toDispatch();
		}
		for(int i=0;i<pos;i++){
			Dispatch.call(selection, "MoveLeft");
		}
	}
	
	//把选定的内容或者插入点向右移动
	public void moveRight(int pos){
		if(selection==null)
			selection = Dispatch.get(word,"Selection").toDispatch();
		for(int i=0;i<pos;i++)
			Dispatch.call(selection,"MoveRight");
	}
	
	public Dispatch getSelection(){
		if(selection==null)
			selection = Dispatch.get(word,"Selection").toDispatch();
		return selection;
	}
	
	//把插入点移动到文件首位置
	public void moveStart(){
	   selection = getSelection();
	   Dispatch.call(selection, "HomeKey",new Variant(6));
	}
	
	public void enterStart(){
		selection = getSelection();
		Dispatch.call(selection, "TypeParagraph");
	}
	
	//从选定内容或插入点开始查找文本
	public boolean find(String toFindText){
	   if(toFindText==null||toFindText.equals("")){
		   return false; 
	   }
	   Dispatch find = word.call(selection, "Find").toDispatch();
	   //设置要查找的内容
	   Dispatch.put(find,"Text",toFindText);
	   //向前查找
	   Dispatch.put(find,"Forward","True");
	   //设置格式
	   Dispatch.put(find,"Format","True");
	   //大小写匹配
	   Dispatch.put(find,"MatchCase","True");
	   //全字匹配
	   Dispatch.put(find,"MatchWholeWord","True");
	   //查找并选中
	   return Dispatch.call(find, "Execute").getBoolean();
	}
	
	//把选定内容设定为替换文本
	public boolean replaceText(String toFindText,String newText){
		if(!find(toFindText)){
			return false;
		}
		Dispatch.put(selection,"Text",newText);
		return true;
	}
	
	
	//全局替换
	public void replaceAllText(String toFindText,String newText){
		while(find(toFindText)){
			Dispatch.put(selection,"Text",newText);
			Dispatch.call(selection, "MoveRight");
		}
	}
	
	//在当前点插入字符串
	public void insertText(String newText){
		Dispatch.put(selection,"Text",newText);
	}
	
	//查找的字符串，图片路径
	public boolean replaceImage(String toFindText,String imagePath){
		if(!find(toFindText)){
			return false;
		}
		Dispatch.call(Dispatch.get(selection,"InLineShapes").toDispatch(),"AddPicture",imagePath);
		return true;
	}
	
	
	//全局替换图片
	public void replaceAllImage(String toFindText,String imagePath){
		while(find(toFindText)){
			Dispatch.call(Dispatch.get(selection,"InLineShapes").toDispatch(),
					"AddPicture",imagePath);
			Dispatch.call(selection,"MoveRight");
		}
	}
	
	//当前插入点插入图片
	public void insertImage(String imagePath){
		Dispatch.call(Dispatch.get(selection,"InLineShapes").toDispatch(),"AddPicture",imagePath);
	}
	
	//设置当前选定内容字体
	public void setFont(boolean bold,boolean italic,boolean underLine){
		Dispatch font = Dispatch.get(selection,"Font").toDispatch();
		Dispatch.put(font,"Bold",new Variant(bold));
		Dispatch.put(font,"Italic",new Variant(italic));
		Dispatch.put(font,"Underline",new Variant(underLine)); 
		//Dispatch.put(font,"Sub",new Variant(true));
	}
	
	//关闭文档    0 不保存修改，  -1 保存修改  -2 提示是否保存修改
	public void closeDocument(int val){
		Dispatch.call(doc, "Close",new Variant(val));
		doc = null;
	}
	
	//关闭全部应用
	public void close(){
		if(word!=null){
			Dispatch.call(word, "Quit");
			word = null;
		}
		selection = null;
		documents = null;
	}
	
	public void closeDocument(){
		if(doc!=null){
			Dispatch.call(doc, "Save");
			Dispatch.call(doc, "Close",new Variant(saveOnExit));
			doc = null;
		} 
	}
	
}
