package com.buba.rural.villageMessage.action;

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
import com.buba.rural.pojo.Country_flow;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.VersionRecord;
import com.buba.rural.villageMessage.service.IVillageService;

public class VillageAction {
	private IVillageService villageService;
	private Country_message countrymessage;
	private VersionRecord versionrecord;
	
	private String page;
	private String rows;
	//保存
		private String deleted;
	 	private String inserted; 
	 	
	 	
	 	//查询
		public String seachvillage() throws IOException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			String cdzbsj = request.getParameter("cdzbsj");
			String bpld = request.getParameter("bpld");
			String cid = request.getParameter("cid");
			Country_message flow = new Country_message();
			if(null!=cdzbsj && !cdzbsj.equals("")){
				flow.setCdzbsj(cdzbsj);
			}
			if(null!=bpld && !bpld.equals("")){
				flow.setBpld(bpld);
			}
			if(null!=cid && !cid.equals("")){
				flow.setCid(cid);
			}
			//当前页  
	        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
	        //每页显示条数  
	        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
	        
	        //拼接URL的同时解码
			PageBean_easyui pageBean = new PageBean_easyui();
			pageBean.setPagecode(intPage);
			pageBean.setPagesize(number);
			
			String pattern = "";
			String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
			pageBean.setUrl(getpar);
			pageBean = villageService.seachvillage(flow,pageBean);
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
		
		//变更
		public String seachrecord() throws IOException{
			List<Country_message> list = villageService.seachrecord(countrymessage);
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
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			//当前页  
	        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
	        //每页显示条数  
	        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
	        
	        //拼接URL的同时解码
			PageBean_easyui pageBean = new PageBean_easyui();
			pageBean.setPagecode(intPage);
			pageBean.setPagesize(number);
			
			String pattern = "";
			String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
			pageBean.setUrl(getpar);
			pageBean = villageService.seachlishi(countrymessage,pageBean);
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
		 * 基本信息添加
		 * @return
		 * @throws IOException 
		 */
		public String addVillage() throws IOException{
			String finall = villageService.addVillage(countrymessage);
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
		public String saveVillage() throws IOException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			String updated = request.getParameter("updated");
			String deleted = request.getParameter("deleted");
			JSONArray jsonArray = null;
			Country_message[] country = null;
			String finall = null;
			if(null!=deleted){
		 		jsonArray = JSONArray.fromObject(deleted);
		 		country = (Country_message[]) JSONArray.toArray(jsonArray,Country_message.class);
		 		finall = villageService.deleted(country,countrymessage);
		 	}
		 	if(null!=updated){
		 		jsonArray = JSONArray.fromObject(updated);
		 		country = (Country_message[]) JSONArray.toArray(jsonArray,Country_message.class);
		 		finall = villageService.updated(country,countrymessage);
		 	}
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.write(finall);
			out.close();
			return null;
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
		public void setVillageService(IVillageService villageService) {
			this.villageService = villageService;
		}

		public Country_message getCountrymessage() {
			return countrymessage;
		}
		public void setCountrymessage(Country_message countrymessage) {
			this.countrymessage = countrymessage;
		}
		public void setVersionrecord(VersionRecord versionrecord) {
			this.versionrecord = versionrecord;
		}
		
}
