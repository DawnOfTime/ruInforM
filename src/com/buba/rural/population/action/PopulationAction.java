package com.buba.rural.population.action;

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
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Person_message;
import com.buba.rural.population.service.IPopulationService;

public class PopulationAction {
	private IPopulationService populationService;
	private Person_message person_message;
	private Country country;
	
	private String page;
	private String rows;
	
	public String queryPopulation() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String xm = request.getParameter("xm");
		String sfzhm = request.getParameter("sfzhm");
		Person_message person_message = new Person_message();
		if(null!=xm && !xm.equals("")){
			person_message.setXm("%"+URLDecoder.decode(xm, "utf-8")+"%");
		}
		if(null!=sfzhm && !sfzhm.equals("")){
			person_message.setSfzhm(sfzhm);
		}
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		pageBean = populationService.querypopulation(country, pageBean,person_message);
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
	 * 查询字典表获取下拉内容
	 * @return
	 * @throws IOException
	 */
	public String findOption() throws IOException{
		Map<String,Object> map = populationService.findOption();
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
	
	public Person_message getPerson_message() {
		return person_message;
	}

	public void setPerson_message(Person_message person_message) {
		this.person_message = person_message;
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
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	public void setPopulationService(IPopulationService populationService) {
		this.populationService = populationService;
	}
	
}
