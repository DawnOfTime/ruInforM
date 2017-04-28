package com.buba.rural.release.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Article;
import com.buba.rural.pojo.Country_officer;
import com.buba.rural.release.service.IReleaseService;
import com.opensymphony.xwork2.ActionContext;

public class ReleaseAction {
	private Article article;
	private IReleaseService releaseservice;
	private String deleted;
	private String page;
	private String rows;
	private String id;
	
	
	//发布添加
	public String findadd(){
		article.setRemarks("");
		releaseservice.add(article);
		return "success";
	}
	
	public String update(){
		article.setState("1");
		releaseservice.update(article);
	 	return null;
	}
	
	public String query() throws IOException{
		HttpServletResponse response=(HttpServletResponse) ActionContext.getContext().get(ServletActionContext.HTTP_RESPONSE);
		Article query=releaseservice.findquery(id);
		 response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control","no-cache");
			PrintWriter pw=response.getWriter();
			pw=response.getWriter();
			pw.write(JSONArray.fromObject(query)+"");
			pw.close();
		return null;
	}
	//字符串出现回车符，json校验不通过
	public String findquery() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String types = request.getParameter("types");
		String state = request.getParameter("state");
		String starttime = request.getParameter("starttime");
		String overtime = request.getParameter("overtime");
		Article flow = new Article();
		if(null!=types && !types.equals("")){
			flow.setTypes(types);
		}
		if(null!=state && !state.equals("")){
			flow.setState(state);
		}
		if(null!=starttime && !starttime.equals("")){
			flow.setStarttime(starttime);
		}
		if(null!=overtime && !overtime.equals("")){
			flow.setOvertime(overtime);
		}
		
		//当前页  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //每页显示条数  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        //每页的开始记录  第一页为1  第二页为number +1   
        int start = (intPage-1)*number;  
        
        //拼接URL的同时解码
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		
		pageBean=releaseservice.query(flow,pageBean);
		
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
	
	public String findSave(){
		HttpServletResponse response=ServletActionContext.getResponse();
		JSONArray jsonArray = null;
		Article[] article = null;
		String finall = null;
		//删除
		if(deleted!=null && !"".equals(deleted)){
			jsonArray = JSONArray.fromObject(deleted);
			article = (Article[]) JSONArray.toArray(jsonArray,Article.class);
	 		finall = releaseservice.deleted(article);
		}
		return null;
	}
	public String queryExamine() throws IOException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			String name = request.getParameter("name");
			String cid = request.getParameter("cid");
			Country_officer officers = new Country_officer();
			if(null!=name && !name.equals("")){
				officers.setName(name);
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
			pageBean = releaseservice.queryExamine(pageBean);
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
		Map<String,Object> map = releaseservice.findOption();
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
	public String UpExamine(){
		releaseservice.UpExamine(article);
	 	return null;
	}
	public String updateE(){
		releaseservice.updateE(article);
	 	return null;
	}
	public Article getArticle() {
		return article;
	}
	public void setArticle(Article article) {
		this.article = article;
	}
	
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 注入
	 * @param releaseservice
	 */
	public void setReleaseservice(IReleaseService releaseservice) {
		this.releaseservice = releaseservice;
	}
}

