package com.buba.rural.floating.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.floating.service.IFloatingService;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_flow;

public class FloatingAction {
	private IFloatingService floatingService;
	private Country country;
	
	//分页
	private String page;
	private String rows;
	private Country_flow country_flow;
	public String findFlowPerson() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String name = request.getParameter("name");
		String id_card = request.getParameter("id_card");
		String state = request.getParameter("state");
		Country_flow flow = new Country_flow();
		if(null!=name && !name.equals("")){
			flow.setName(name);
		}
		if(null!=id_card && !id_card.equals("")){
			flow.setId_card(id_card);
		}
		if(null!=state && !state.equals("")){
			flow.setState(state);
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
		pageBean = floatingService.findFlowPerson(country,flow,pageBean);
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
	public Country_flow getCountry_flow() {
		return country_flow;
	}
	public void setCountry_flow(Country_flow country_flow) {
		this.country_flow = country_flow;
	}
	public void setFloatingService(IFloatingService floatingService) {
		this.floatingService = floatingService;
	}
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
}
