package com.buba.rural.land_industry.action;

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
import com.buba.rural.land_industry.service.ILand_industryService;
import com.buba.rural.pojo.Land_industry;
import com.buba.rural.pojo.VersionRecord;

public class Land_industryAction {
	private ILand_industryService land_industryService;
	private Land_industry land_industry;
	
	private String page;
	private String rows;
	
	private String deleted;
 	private String inserted;
 	
 	public String queryland_industry() throws Exception{
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
		pageBean = land_industryService.queryland_industry(land_industry, pageBean);
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
	public String addland_industry() throws IOException{
		String finall = land_industryService.addland_industry(land_industry);
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
	public String saveland_industry() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String updated = request.getParameter("updated");
		String deleted = request.getParameter("deleted");
		JSONArray jsonArray = null;
		Land_industry[] land = null;
		String finall = null;
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		land = (Land_industry[]) JSONArray.toArray(jsonArray,Land_industry.class);
	 		finall = land_industryService.deleted(land,land_industry);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		land = (Land_industry[]) JSONArray.toArray(jsonArray,Land_industry.class);
	 		finall = land_industryService.updated(land,land_industry);
	 	}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 查询单条记录
	 * @return
	 * @throws IOException 
	 */
	public String searchLand_industry() throws IOException{
		Land_industry land = land_industryService.searchLand_industry(land_industry);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(land)+"");
		out.close();
		return null;
	}
	/**
	 * 查询历史记录
	 * @return
	 * @throws IOException 
	 */
	public String searchHistory() throws IOException{
		List<String> list = land_industryService.searchHistory(land_industry);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	public Land_industry getLand_industry() {
		return land_industry;
	}

	public void setLand_industry(Land_industry land_industry) {
		this.land_industry = land_industry;
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

	public void setLand_industryService(ILand_industryService land_industryService) {
		this.land_industryService = land_industryService;
	}
	
}
