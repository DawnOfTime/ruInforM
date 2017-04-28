package com.buba.rural.menu.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.menu.service.IMenuService;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Rule;

public class MenuAction {
	private IMenuService iMenuService;
	private Menu menu;
	private String page;
	private String rows;
	private String deleted;
 	private String inserted; 
 	private String updated;
 	/**
 	 * 查询菜单树
 	 * @return
 	 * @throws Exception 
 	 */
 	public String findMenuTree() throws Exception{
 		String menutree = iMenuService.findMenuTree();
 		HttpServletResponse response=ServletActionContext.getResponse();
 		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(menutree);
		out.close();
 		return null;
 	}
	/**
	 * 分页查询【查询菜单】
	 * @return null [ajax异步加载]
	 * @throws Exception 
	 */
	public String findMenu() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
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
		
		pageBean = iMenuService.findMenu(menu,pageBean);
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
	 * 保存【修改】
	 * @return null [ajax异步加载]
	 * @throws Exception 
	 */
	public String saveMenu() throws Exception{
		HttpServletResponse response=ServletActionContext.getResponse();
		JSONArray jsonArray = null;
		Menu[] menu = null;
		String finall = null;
	 	if(null!=updated){
//	 		updated = updated.substring(1,updated.toCharArray().length-1);
	 		Map<String,String> map = JSONObject.fromObject(updated);
	 		finall = iMenuService.updated(map);
	 	}
	 	response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 添加
	 * @return
	 * @throws IOException
	 */
	public String insertMenu() throws IOException{
		JSONArray jsonArray = null;
		Menu[] menu = null;
		String finall = null;
		if(null!=inserted){
			jsonArray=JSONArray.fromObject("["+inserted+"]");
			menu = (Menu[]) JSONArray.toArray(jsonArray,Menu.class);
			finall = iMenuService.insertMenu(menu);
		}
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 删除
	 * @return
	 * @throws IOException
	 */
	public String deleteMenu() throws IOException{
		JSONArray jsonArray = null;
		Menu[] menu = null;
		String finall = null;
		if(null!=deleted){
			jsonArray=JSONArray.fromObject("["+deleted+"]");
			menu = (Menu[]) JSONArray.toArray(jsonArray,Menu.class);
			finall = iMenuService.deleteMenu(menu);
		}
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
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
	public void setiMenuService(IMenuService iMenuService) {
		this.iMenuService = iMenuService;
	}
}
