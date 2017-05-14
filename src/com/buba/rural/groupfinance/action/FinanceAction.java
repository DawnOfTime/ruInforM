package com.buba.rural.groupfinance.action;

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
import com.buba.rural.groupfinance.service.IFinanceService;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.pojo.Country_message;

public class FinanceAction {
	
	private IFinanceService financeSercie;
	private Country_group_finance groupfinance;
	
	private String page;
	private String rows;
	
	
	//查询
			/*public String seachFinance() throws IOException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpServletResponse response=ServletActionContext.getResponse();
				String type = request.getParameter("type");
				String cid = request.getParameter("cid");
				Country_group_finance flow = new Country_group_finance();
				if(null!=type && !type.equals("")){
					flow.setType(type);
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
				pageBean = financeSercie.seachFinance(flow,pageBean);
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
			public Country_group_finance seachFinance() throws IOException{
				List<Country_group_finance> building = financeSercie.seachFinance(groupfinance);
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
				List<Country_message> list = financeSercie.seachrecord(groupfinance);
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
						pageBean = financeSercie.seachlishi(groupfinance,pageBean);
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
			public String addFinance() throws IOException{
				String finall = financeSercie.addFinance(groupfinance);
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
			public String saveFinance() throws IOException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpServletResponse response=ServletActionContext.getResponse();
				String updated = request.getParameter("updated");
				String deleted = request.getParameter("deleted");
				JSONArray jsonArray = null;
				Country_group_finance[] country = null;
				String finall = null;
				if(null!=deleted){
			 		jsonArray = JSONArray.fromObject(deleted);
			 		country = (Country_group_finance[]) JSONArray.toArray(jsonArray,Country_group_finance.class);
			 		finall = financeSercie.deleted(country,groupfinance);
			 	}
			 	if(null!=updated){
			 		jsonArray = JSONArray.fromObject(updated);
			 		country = (Country_group_finance[]) JSONArray.toArray(jsonArray,Country_group_finance.class);
			 		finall = financeSercie.updated(country,groupfinance);
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
				Map<String,Object> map = financeSercie.findOption();
				HttpServletResponse response=ServletActionContext.getResponse();
				response.setContentType("text/html;charset=utf-8");
				response.setHeader("Cache-Control", "no-cache");
				PrintWriter out = response.getWriter();
				String jsonstr = JSONObject.fromObject(map)+"";
//				jsonstr = jsonstr.replaceAll("dicvalue", "valueField");
//				jsonstr = jsonstr.replaceAll("dicname", "textField");
				out.write(jsonstr);
				out.close();
				return null;
			}
	
	
	public Country_group_finance getGroupfinance() {
		return groupfinance;
	}
	public void setGroupfinance(Country_group_finance groupfinance) {
		this.groupfinance = groupfinance;
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
	public void setFinanceSercie(IFinanceService financeSercie) {
		this.financeSercie = financeSercie;
	}
}
