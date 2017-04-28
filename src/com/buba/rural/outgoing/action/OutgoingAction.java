package com.buba.rural.outgoing.action;

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
import com.buba.rural.outgoing.service.IOutgoingService;
import com.buba.rural.pojo.County_outgoing;

public class OutgoingAction {
	
	private IOutgoingService outgoingService;
	private County_outgoing countyoutgoing;

	private String page;
	private String rows;
	
	
	//查询
			public String seachOutgoing() throws IOException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpServletResponse response=ServletActionContext.getResponse();
				String name = request.getParameter("name");
				String cid = request.getParameter("cid");
				County_outgoing flow = new County_outgoing();
				if(null!=name && !name.equals("")){
					flow.setName(name);
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
				pageBean = outgoingService.seachOutgoing(flow,pageBean);
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
			public String addOutgoing() throws IOException{
				String finall = outgoingService.addOutgoing(countyoutgoing);
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
			public String saveOutgoing() throws IOException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpServletResponse response=ServletActionContext.getResponse();
				String updated = request.getParameter("updated");
				String deleted = request.getParameter("deleted");
				JSONArray jsonArray = null;
				County_outgoing[] country = null;
				String finall = null;
				if(null!=deleted){
			 		jsonArray = JSONArray.fromObject(deleted);
			 		country = (County_outgoing[]) JSONArray.toArray(jsonArray,County_outgoing.class);
			 		finall = outgoingService.deleted(country,countyoutgoing);
			 	}
			 	if(null!=updated){
			 		jsonArray = JSONArray.fromObject(updated);
			 		country = (County_outgoing[]) JSONArray.toArray(jsonArray,County_outgoing.class);
			 		finall = outgoingService.updated(country,countyoutgoing);
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
				Map<String,Object> map = outgoingService.findOption();
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
	/**
	 * 查询单条记录
	 * @return
	 * @throws IOException
	 */
	public String seachOne() throws IOException{
		County_outgoing cog = outgoingService.seachOne(countyoutgoing);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(cog)+"");
		out.close();
		return null;
	}
	/**
	 * 查询历史记录
	 * @return
	 * @throws IOException
	 */
	public String seachHistory() throws IOException{
		List<String> list = outgoingService.seachHistory(countyoutgoing);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	public County_outgoing getCountyoutgoing() {
		return countyoutgoing;
	}
	public void setCountyoutgoing(County_outgoing countyoutgoing) {
		this.countyoutgoing = countyoutgoing;
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
	public void setOutgoingService(IOutgoingService outgoingService) {
		this.outgoingService = outgoingService;
	}
}
