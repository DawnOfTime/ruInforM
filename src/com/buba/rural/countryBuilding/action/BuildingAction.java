package com.buba.rural.countryBuilding.action;

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
import com.buba.rural.countryBuilding.service.IBuildingService;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_message;

public class BuildingAction {
	private IBuildingService buildingService;
	private Country_building countrybuilding;
	
	private String page;
	private String rows;
	//保存
	 	
	 	//查询
		/*public String searchbuilding() throws IOException{
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
			
			pageBean=buildingService.seachbuilding(countrybuilding,pageBean);
			
			Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
			jsonMap.put("total", pageBean.getTotalrecord());//total键 存放总记录数，必须的  
	        jsonMap.put("rows", pageBean.getBeanList());//rows键 存放每页记录 list 
	        response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.write(JSONObject.fromObject(jsonMap)+"");
			out.close();
			return null;
		}*/
		
		public Country_building searchbuilding() throws IOException{
			Country_building building = buildingService.searchbuilding(countrybuilding);
			HttpServletResponse response=ServletActionContext.getResponse();
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.write(JSONArray.fromObject(building)+"");
			out.close();
			return null;
		}
		//变更
		public String seachrecord() throws IOException{
			List<Country_message> list = buildingService.seachrecord(countrybuilding);
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
			        //每页的开始记录  第一页为1  第二页为number +1   
			        int start = (intPage-1)*number;  
			        
			        //拼接URL的同时解码
					PageBean_easyui pageBean = new PageBean_easyui();
					pageBean.setPagecode(intPage);
					pageBean.setPagesize(number);
					
					String pattern = "";
					String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
					pageBean.setUrl(getpar);
					
					pageBean=buildingService.seachlishi(countrybuilding,pageBean);
					
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
		public String addBuilding() throws IOException{
			String finall = buildingService.addBuilding(countrybuilding);
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
		public String saveBuilding() throws IOException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			String updated = request.getParameter("updated");
			String deleted = request.getParameter("deleted");
			JSONArray jsonArray = null;
			Country_building[] country = null;
			String finall = null;
			if(null!=deleted){
		 		jsonArray = JSONArray.fromObject(deleted);
		 		country = (Country_building[]) JSONArray.toArray(jsonArray,Country_building.class);
		 		finall = buildingService.deleted(country,countrybuilding);
		 	}
		 	if(null!=updated){
		 		jsonArray = JSONArray.fromObject(updated);
		 		country = (Country_building[]) JSONArray.toArray(jsonArray,Country_building.class);
		 		finall = buildingService.updated(country,countrybuilding);
		 	}
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.write(finall);
			out.close();
			return null;
	 	
		}
		public Country_building getCountrybuilding() {
			return countrybuilding;
		}
		public void setCountrybuilding(Country_building countrybuilding) {
			this.countrybuilding = countrybuilding;
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
		public void setBuildingService(IBuildingService buildingService) {
			this.buildingService = buildingService;
		} 
}
