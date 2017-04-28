package com.buba.rural.flow.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.flow.service.IFlowService;
import com.buba.rural.pojo.Country_flow;

public class FlowAction {
	private IFlowService iFlowService;
	//分页
	private String page;
	private String rows;
	private Country_flow country_flow;
	public String findFlowPerson() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String name = request.getParameter("name");
		String id_card = request.getParameter("id_card");
		String cid = request.getParameter("cid");
		Country_flow flow = new Country_flow();
		if(null!=name && !name.equals("")){
			flow.setName("%"+name+"%");
		}
		if(null!=id_card && !id_card.equals("")){
			flow.setId_card("%"+id_card+"%");
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
		pageBean = iFlowService.findFlowPerson(flow,pageBean);
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
	 * 添加流动人口
	 * @return
	 * @throws IOException 
	 */
	public String addFlowPerson() throws IOException{
		String finall = iFlowService.addFlowPerson(country_flow);
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
	public String saveFlowPerson() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String updated = request.getParameter("updated");
		String deleted = request.getParameter("deleted");
		JSONArray jsonArray = null;
		Country_flow[] flow = null;
		String finall = null;
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		flow = (Country_flow[]) JSONArray.toArray(jsonArray,Country_flow.class);
	 		finall = iFlowService.savedeleted(flow);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		flow = (Country_flow[]) JSONArray.toArray(jsonArray,Country_flow.class);
	 		finall = iFlowService.saveupdated(flow);
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
		Map<String,Object> map = iFlowService.findOption();
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
	/**
	 * 注入
	 * @param iFlowService
	 */
	public void setiFlowService(IFlowService iFlowService) {
		this.iFlowService = iFlowService;
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
	public IFlowService getiFlowService() {
		return iFlowService;
	}
	public Country_flow getCountry_flow() {
		return country_flow;
	}
	public void setCountry_flow(Country_flow country_flow) {
		this.country_flow = country_flow;
	}
}
