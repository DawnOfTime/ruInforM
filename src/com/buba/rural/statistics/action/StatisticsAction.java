package com.buba.rural.statistics.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.pojo.Country_poverty;
import com.buba.rural.pojo.Land_industry;
import com.buba.rural.statistics.service.IStatisticsService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 绘制统计图
 * @author liy
 *
 */
public class StatisticsAction {
	private IStatisticsService iStatisticsService;
	private String cid;
	private String type;
	
	private Country country;
	private String chart;
	/**
	 * 获取村建筑物
	 * @return
	 * @throws IOException
	 */
	public String getCountrybuilding() throws IOException{
		List<Country_building> list = iStatisticsService.getCountrybuilding(cid);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 获取村贫困户情况
	 * @return
	 * @throws IOException
	 */
	public String getCountryPoverty() throws IOException{
		List<Country_poverty> list = iStatisticsService.getCountryPoverty(cid);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 获取集体收支情况
	 * @return
	 * @throws IOException
	 */
	public String getCountryGroupFinance() throws IOException{
		List<Country_group_finance> list = iStatisticsService.getCountryGroupFinance(cid,type);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 土地和产业
	 * @return
	 * @throws IOException
	 */
	public String getCountryLand_industry() throws IOException{
		List<Land_industry> list = iStatisticsService.getCountryLand_industry(cid);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 道路硬化、建筑物【饼图】
	 * @return
	 * @throws IOException 
	 */
	public String pie_countryBuilding() throws IOException{
		Country_building list = iStatisticsService.pie_countryBuilding(country);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 贫困户分配【饼图】
	 * @return
	 * @throws IOException 
	 */
	public String pie_countryPoverty() throws IOException{
		Country_poverty list = iStatisticsService.pie_countryPoverty(country);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 土地、服务业【饼图】
	 * @return
	 * @throws IOException 
	 */
	public String pie_countryLand() throws IOException{
		Land_industry list = iStatisticsService.pie_countryLand(country);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(list)+"");
		out.close();
		return null;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	public String getChart() {
		return chart;
	}
	public void setChart(String chart) {
		this.chart = chart;
	}
	/**
	 * 注入
	 * @param iStatisticsService
	 */
	public void setiStatisticsService(IStatisticsService iStatisticsService) {
		this.iStatisticsService = iStatisticsService;
	}
}
