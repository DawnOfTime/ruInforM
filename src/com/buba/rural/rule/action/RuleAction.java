package com.buba.rural.rule.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Rule;
import com.buba.rural.rule.service.IRuleService;

public class RuleAction {
	private IRuleService iRuleService;
	private Rule rule;
	private String page;
	private String rows;
	private String deleted;
 	private String inserted; 
 	private String updated;
	/**
	 * 分页查询【角色】
	 * @return
	 * @throws Exception 
	 */
	public String findRuel() throws Exception{
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
		
		pageBean = iRuleService.findMenu(rule,pageBean);
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
	 * 保存【添加、修改、删除】
	 * @return
	 * @throws Exception 
	 */
	public String saveRule() throws Exception{
		inserted = ServletActionContext.getRequest().getParameter("inserted");
		deleted = ServletActionContext.getRequest().getParameter("deleted");
		updated = ServletActionContext.getRequest().getParameter("updated");
		HttpServletResponse response=ServletActionContext.getResponse();
		JSONArray jsonArray = null;
		Rule[] rule = null;
		String finall = null;
		if(null!=inserted){
			jsonArray=JSONArray.fromObject(inserted);
			rule = (Rule[]) JSONArray.toArray(jsonArray,Rule.class);
			finall = iRuleService.inserted(rule);
		}
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		rule = (Rule[]) JSONArray.toArray(jsonArray,Rule.class);
	 		finall = iRuleService.deleted(rule);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		rule = (Rule[]) JSONArray.toArray(jsonArray,Rule.class);
	 		finall = iRuleService.updated(rule);
	 	}
	 	response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 获取菜单列表，当前角色拥有的选中
	 * @return
	 * @throws IOException
	 */
	public String getTree() throws IOException{
		String treeJsonStr = iRuleService.getTree(rule);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(treeJsonStr);
		out.close();
		return null;
	}
	/**
	 * 保存该角色对应的菜单code字符串
	 * @return
	 * @throws IOException
	 */
	public String saveTreeMenu() throws IOException{
		String finall = iRuleService.saveTreeMenu(rule);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	public Rule getRule() {
		return rule;
	}
	public void setRule(Rule rule) {
		this.rule = rule;
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
	public String getUpdated() {
		return updated;
	}
	public void setUpdated(String updated) {
		this.updated = updated;
	}
	//注入
	public void setiRuleService(IRuleService iRuleService) {
		this.iRuleService = iRuleService;
	}
}
