package com.buba.rural.acc.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.acc.service.IAccService;
import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Rule;

public class AccAction {
	private IAccService accService;
	private Acc acc;
	
	private String page;
	private String rows;
	//保存
		private String deleted;
	 	private String inserted; 
	 	private String updated;
	
	//查询
	public String seachacc() throws IOException{
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
		
		String username = request.getParameter("username");
		String acccode = request.getParameter("acccode");
		acc = new Acc();
		if(null!=username && !username.equals("")){
			acc.setUsername("%"+URLDecoder.decode(username, "utf-8")+"%");
		}
		if(null!=acccode && !acccode.equals("")){
			acc.setAcccode("%"+URLDecoder.decode(acccode, "utf-8")+"%");
		}
		pageBean=accService.seachacc(acc,pageBean);
		
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
	 * 添加、删除、修改
	 * @return
	 * @throws IOException
	 */
	public String saveAcc() throws IOException{
		
		HttpServletResponse response=ServletActionContext.getResponse();
		JSONArray jsonArray = null;
		Acc[] ac = null;
		String finall = null;
		if(null!=inserted){
			jsonArray=JSONArray.fromObject(inserted);
			ac = (Acc[]) JSONArray.toArray(jsonArray,Acc.class);
			finall = accService.inserted(ac,acc);
		}
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		ac = (Acc[]) JSONArray.toArray(jsonArray,Acc.class);
	 		finall = accService.deleted(ac,acc);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		ac = (Acc[]) JSONArray.toArray(jsonArray,Acc.class);
	 		finall = accService.updated(ac,acc);
	 	}
	 	response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	//重置密码
	public String uppsw(){
		accService.uppsw(acc);
		return null;
	}
	/**
	 * 获取角色下拉框
	 * @return
	 * @throws IOException
	 */
	public String getRule() throws IOException{
		List<Rule> list = accService.getRule();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 添加账号
	 * @return
	 * @throws IOException 
	 */
	public String addAcc() throws IOException{
		String finall = accService.addAcc(acc);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 获取组织机构树【显示分配情况】
	 * @return
	 * @throws IOException
	 */
	public String getCountryTree() throws IOException{
		String treeStr = accService.getCountryTree(acc);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(treeStr);
		out.close();
		return null;
	}
	/**
	 * 保存辖区分配
	 * @return
	 * @throws IOException
	 */
	public String saveAcc_Country() throws IOException{
		String finall = accService.saveAcc_Country(acc);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	public Acc getAcc() {
		return acc;
	}
	public void setAcc(Acc acc) {
		this.acc = acc;
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
	public void setAccService(IAccService accService) {
		this.accService = accService;
	}
}
