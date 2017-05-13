package com.buba.rural.countycommittee.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
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
import com.buba.rural.countycommittee.service.ICommitteeSercvice;
import com.buba.rural.pojo.Country_committee;
import com.buba.rural.pojo.Country_message;

public class CommitteeAction {
	 
	private ICommitteeSercvice committeeService;
	private Country_committee countrycommittee;
	
	private String page;
	private String rows;
	
	
	//查询
			public String seachCommittee() throws IOException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpServletResponse response=ServletActionContext.getResponse();
				String name = request.getParameter("name");
				String cid = request.getParameter("cid");
				Country_committee flow = new Country_committee();
				if(null!=name && !name.equals("")){
					flow.setName("%"+URLDecoder.decode(name, "utf-8")+"%");
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
				pageBean = committeeService.seachCommittee(flow,pageBean);
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
				List<Country_message> list = committeeService.seachrecord(countrycommittee);
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
				pageBean = committeeService.seachlishi(countrycommittee,pageBean);
				Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map 
				jsonMap.put("total", pageBean.getTotalrecord());//total键 存放总记录数，必须的  
		        jsonMap.put("rows", pageBean.getBeanList());//rows键 存放每页记录 list  
				response.setContentType("text/html;charset=utf-8");
				response.setHeader("Cache-Control", "no-cache");
				PrintWriter out = response.getWriter();
				out.write(JSONObject.fromObject(jsonMap)+"");
				out.close();
				
//				List<Country_message> list = committeeService.seachlishi(countrycommittee);
//				HttpServletResponse response=ServletActionContext.getResponse();
//				response.setContentType("text/html;charset=utf-8");
//				response.setHeader("Cache-Control", "no-cache");
//				PrintWriter out = response.getWriter();
//				out.write(JSONArray.fromObject(list)+"");
//				out.close();
				return null;
			}
			
			
			
			/**
			 * 基本信息添加
			 * @return
			 * @throws IOException 
			 */
			public String addCommittee() throws IOException{
				String finall = committeeService.addCommittee(countrycommittee);
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
			public String saveCommittee() throws IOException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpServletResponse response=ServletActionContext.getResponse();
				String updated = request.getParameter("updated");
				String deleted = request.getParameter("deleted");
				JSONArray jsonArray = null;
				Country_committee[] country = null;
				String finall = null;
				if(null!=deleted){
			 		jsonArray = JSONArray.fromObject(deleted);
			 		country = (Country_committee[]) JSONArray.toArray(jsonArray,Country_committee.class);
			 		finall = committeeService.deleted(country,countrycommittee);
			 	}
			 	if(null!=updated){
			 		jsonArray = JSONArray.fromObject(updated);
			 		country = (Country_committee[]) JSONArray.toArray(jsonArray,Country_committee.class);
			 		finall = committeeService.updated(country,countrycommittee);
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
				Map<String,Object> map = committeeService.findOption();
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
	
	public void setCommitteeService(ICommitteeSercvice committeeService) {
		this.committeeService = committeeService;
	}
	public Country_committee getCountrycommittee() {
		return countrycommittee;
	}
	public void setCountrycommittee(Country_committee countrycommittee) {
		this.countrycommittee = countrycommittee;
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
}
