package com.buba.rural.communication.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.communication.service.ICommunicationService;
import com.buba.rural.pojo.Country_communication;
import com.buba.rural.pojo.Country_message;

public class CommunicationAction {
	private ICommunicationService communicationService;
	private Country_communication communication;
	
	private String page;
	private String rows;
	
	private String deleted;
 	private String inserted;
 	
 	
 	public String queryCommunication() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		
		
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		pageBean = communicationService.querycommunication(communication, pageBean);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", pageBean.getTotalrecord());
        jsonMap.put("rows", pageBean.getBeanList());
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(jsonMap)+"");
		out.close();
		return null;
	}
	
	/**
	 * 添加
	 * @return
	 * @throws IOException 
	 */
	public String addCommunication() throws IOException{
		String finall = communicationService.addcommunication(communication);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	
	/**
	 * 保存修改、删除
	 * @return
	 * @throws IOException
	 */
	public String saveCommunication() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String updated = request.getParameter("updated");
		String deleted = request.getParameter("deleted");
		JSONArray jsonArray = null;
		Country_communication[] country = null;
		String finall = null;
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		country = (Country_communication[]) JSONArray.toArray(jsonArray,Country_communication.class);
	 		finall = communicationService.deleted(country,communication);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		country = (Country_communication[]) JSONArray.toArray(jsonArray,Country_communication.class);
	 		finall = communicationService.updated(country,communication);
	 	}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 查询字典表获取下拉内容
	 * @return
	 * @throws IOException
	 */
	public String findOption() throws IOException{
		Map<String,Object> map = communicationService.findOption();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		String jsonstr = JSONObject.fromObject(map)+"";
//		jsonstr = jsonstr.replaceAll("dicvalue", "valueField");
//		jsonstr = jsonstr.replaceAll("dicname", "textField");
		out.write(jsonstr);
		out.close();
		return null;
	}
	//变更
		public String seachrecord() throws IOException{
			List<Country_message> list = communicationService.seachrecord(communication);
			HttpServletResponse response=ServletActionContext.getResponse();
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.write(JSONArray.fromObject(list)+"");
			out.close();
			return null;
		}
		//历史记录
		public String seachlishi() throws IOException{
			List<Country_message> list = communicationService.seachlishi(communication);
			HttpServletResponse response=ServletActionContext.getResponse();
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.write(JSONArray.fromObject(list)+"");
			out.close();
			return null;
		}
 	
	public Country_communication getCommunication() {
		return communication;
	}
	public void setCommunication(Country_communication communication) {
		this.communication = communication;
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
	public void setCommunicationService(ICommunicationService communicationService) {
		this.communicationService = communicationService;
	}
 	
}
