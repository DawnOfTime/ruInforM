package com.buba.rural.countypoverty.action;

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
import com.buba.rural.countypoverty.service.IPovertyService;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.Country_poverty;

public class PovertyAction {
	
	private IPovertyService povertyService;
	private Country_poverty countrypoverty;
	
	private String page;
	private String rows;
	
	
	
	//查询
	/*public String seachPoverty() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String is_pkc = request.getParameter("is_pkc");
		String cid = request.getParameter("cid");
		Country_poverty flow = new Country_poverty();
		if(null!=is_pkc && !is_pkc.equals("")){
			flow.setIs_pkc(is_pkc);
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
		pageBean = povertyService.seachPoverty(flow,pageBean);
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
	public Country_poverty seachPoverty() throws IOException{
		List<Country_building> building = povertyService.seachPoverty(countrypoverty);
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
				List<Country_message> list = povertyService.seachrecord(countrypoverty);
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
						pageBean = povertyService.seachlishi(countrypoverty,pageBean);
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
	public String addPoverty() throws IOException{
		String finall = povertyService.addPoverty(countrypoverty);
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
	public String savePoverty() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String updated = request.getParameter("updated");
		String deleted = request.getParameter("deleted");
		JSONArray jsonArray = null;
		Country_poverty[] country = null;
		String finall = null;
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		country = (Country_poverty[]) JSONArray.toArray(jsonArray,Country_poverty.class);
	 		finall = povertyService.deleted(country,countrypoverty);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		country = (Country_poverty[]) JSONArray.toArray(jsonArray,Country_poverty.class);
	 		finall = povertyService.updated(country,countrypoverty);
	 	}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	
	
	
	public Country_poverty getCountrypoverty() {
		return countrypoverty;
	}
	public void setCountrypoverty(Country_poverty countrypoverty) {
		this.countrypoverty = countrypoverty;
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
	public void setPovertyService(IPovertyService povertyService) {
		this.povertyService = povertyService;
	}
}	
