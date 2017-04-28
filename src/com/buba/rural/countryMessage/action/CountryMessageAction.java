package com.buba.rural.countryMessage.action;

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
import com.buba.rural.countryMessage.service.ICountryMessageService;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_committee;
import com.buba.rural.pojo.Country_communication;
import com.buba.rural.pojo.Country_flow;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.Country_officer;
import com.buba.rural.pojo.Country_poverty;

public class CountryMessageAction {
	private ICountryMessageService iCountryMessageService;
	
	private Country_message country_message;
	private Country_committee country_committee;
	private Country_communication country_communication;
	private Country_flow country_flow;
	private Country_group_finance country_group_finance;
	private Country_officer country_officer;
	private Country_poverty country_poverty;
	private Country country;
	
	//分页
	private String page;
	private String rows;
	/**
	 * 查询村基本信息
	 * @return
	 * @throws IOException
	 */
	public String findCountryMessage() throws IOException{
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
		pageBean = iCountryMessageService.findCountryMessage(country,pageBean);
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
	 * 查询村所有信息
	 * @return
	 * @throws IOException 
	 */
	public String findCountryAllMessage() throws IOException{
		Map<String,Object> map = iCountryMessageService.findCountryAllMessage(country_message);
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("countryAllMessageMap", map);
		return "success";
	}
	/**
	 * 注入
	 * @param iCountryMessageService
	 */
	public void setiCountryMessageService(
			ICountryMessageService iCountryMessageService) {
		this.iCountryMessageService = iCountryMessageService;
	}
	public Country_message getCountry_message() {
		return country_message;
	}
	public void setCountry_message(Country_message country_message) {
		this.country_message = country_message;
	}
	public Country_committee getCountry_committee() {
		return country_committee;
	}
	public void setCountry_committee(Country_committee country_committee) {
		this.country_committee = country_committee;
	}
	public Country_communication getCountry_communication() {
		return country_communication;
	}
	public void setCountry_communication(Country_communication country_communication) {
		this.country_communication = country_communication;
	}
	public Country_flow getCountry_flow() {
		return country_flow;
	}
	public void setCountry_flow(Country_flow country_flow) {
		this.country_flow = country_flow;
	}
	public Country_group_finance getCountry_group_finance() {
		return country_group_finance;
	}
	public void setCountry_group_finance(Country_group_finance country_group_finance) {
		this.country_group_finance = country_group_finance;
	}
	public Country_officer getCountry_officer() {
		return country_officer;
	}
	public void setCountry_officer(Country_officer country_officer) {
		this.country_officer = country_officer;
	}
	public Country_poverty getCountry_poverty() {
		return country_poverty;
	}
	public void setCountry_poverty(Country_poverty country_poverty) {
		this.country_poverty = country_poverty;
	}
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
}
