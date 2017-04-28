package com.buba.rural.dictionary.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.dictionary.service.IDictionaryService;
import com.buba.rural.pojo.Dictionary;
import com.buba.rural.pojo.Person_message;

public class DictionaryAction {
		
	private IDictionaryService idictionaryservice;
	private Dictionary dictionary;
	private String page;
	private String rows;
	//保存
		private String deleted;
	 	private String inserted; 
	 	private String updated;
	
	//查询
	public String seachDic() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		//当前页  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //每页显示条数  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        //每页的开始记录  第一页为1  第二页为number +1   
        int start = (intPage-1)*number;  
        
        //拼接URL的同时解码
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		
		pageBean=idictionaryservice.seachDic(dictionary,pageBean);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
		jsonMap.put("total", pageBean.getTotalrecord());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pageBean.getBeanList());//rows键 存放每页记录 list 
        response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(jsonMap)+"");
		out.close();
		return null;
	}

	/**
	 * 添加、删除、修改
	 * @return
	 * @throws IOException
	 */
	public String savePerson() throws IOException{
		
		HttpServletResponse response=ServletActionContext.getResponse();
		inserted = ServletActionContext.getRequest().getParameter("inserted");
		updated = ServletActionContext.getRequest().getParameter("updated");
		deleted = ServletActionContext.getRequest().getParameter("deleted");
		JSONArray jsonArray = null;
		Dictionary[] diction = null;
		String finall = null;
		if(null!=inserted){
			jsonArray=JSONArray.fromObject(inserted);
			diction = (Dictionary[]) JSONArray.toArray(jsonArray,Dictionary.class);
			finall = idictionaryservice.inserted(diction,dictionary);
		}
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		diction = (Dictionary[]) JSONArray.toArray(jsonArray,Dictionary.class);
	 		finall = idictionaryservice.deleted(diction,dictionary);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		diction = (Dictionary[]) JSONArray.toArray(jsonArray,Dictionary.class);
	 		finall = idictionaryservice.updated(diction,dictionary);
	 	}
	 	response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	
	public Dictionary getDictionary() {
		return dictionary;
	}
	public void setDictionary(Dictionary dictionary) {
		this.dictionary = dictionary;
	}
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getRows() {
		return rows;
	}
	public void setRows(String rows) {
		this.rows = rows;
	}
	public void setIdictionaryservice(IDictionaryService idictionaryservice) {
		this.idictionaryservice = idictionaryservice;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getInserted() {
		return inserted;
	}

	public void setInserted(String inserted) {
		this.inserted = inserted;
	}

	public String getUpdated() {
		return updated;
	}

	public void setUpdated(String updated) {
		this.updated = updated;
	}
	
}
