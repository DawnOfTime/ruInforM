package com.buba.rural.officer.action;

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
import com.buba.rural.officer.service.IOfficerService;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.Country_officer;

public class OfficerAction {
	private IOfficerService officerService;
	private Country_officer countryofficer;
	private String page;
	private String rows;
	
	private String deleted;
 	private String inserted; 
	
	public String showTree() throws IOException{
		String jsonstr  = officerService.showTree();
		HttpServletResponse response=ServletActionContext.getResponse();
 		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(jsonstr);
		out.close();
		return null;
	}
	
	public String queryofficer() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String name = request.getParameter("name");
		String cid = request.getParameter("cid");
		Country_officer officers = new Country_officer();
		if(null!=name && !name.equals("")){
			officers.setName("%"+URLDecoder.decode(name, "utf-8")+"%");
		}
		if(null!=cid && !cid.equals("")){
			officers.setCid(cid);
		}
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		pageBean = officerService.queryofficer(officers, pageBean);
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
	public String addOfficer() throws IOException{
		String finall = officerService.addofficer(countryofficer);
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
	public String saveOfficer() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String updated = request.getParameter("updated");
		String deleted = request.getParameter("deleted");
		JSONArray jsonArray = null;
		Country_officer[] country = null;
		String finall = null;
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		country = (Country_officer[]) JSONArray.toArray(jsonArray,Country_officer.class);
	 		finall = officerService.deleted(country,countryofficer);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		country = (Country_officer[]) JSONArray.toArray(jsonArray,Country_officer.class);
	 		finall = officerService.updated(country,countryofficer);
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
		Map<String,Object> map = officerService.findOption();
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
		List<Country_message> list = officerService.seachrecord(countryofficer);
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
		List<Country_message> list = officerService.seachlishi(countryofficer);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
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

	public Country_officer getCountryofficer() {
		return countryofficer;
	}

	public void setCountryofficer(Country_officer countryofficer) {
		this.countryofficer = countryofficer;
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

	public void setOfficerService(IOfficerService officerService) {
		this.officerService = officerService;
	}
}
