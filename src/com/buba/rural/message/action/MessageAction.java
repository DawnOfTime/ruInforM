package com.buba.rural.message.action;

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
import com.buba.rural.message.service.IMessageService;
import com.buba.rural.pojo.Cadres_home;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.FamilyMessage;
import com.buba.rural.pojo.Family_assets;
import com.buba.rural.pojo.Family_income;
import com.buba.rural.pojo.Family_other;
import com.buba.rural.pojo.Family_pay;
import com.buba.rural.pojo.Family_shebao;
import com.buba.rural.pojo.Family_vehicle;
import com.buba.rural.pojo.Person_message;

public class MessageAction {
	private IMessageService tMessageService;
	private FamilyMessage familyMessage;
	private Person_message person_message;
	private Country countrys;
	private String hzxm;
	//分页
	private String page;
	private String rows;
	//保存
	private String deleted;
 	private String inserted; 
 	private String updated;
 	//保存户的所有信息
 	private Family_shebao family_shebao;
 	private Family_pay family_pay;
 	private Family_other family_other;
 	private Family_income family_income;
 	private Family_assets family_assets;
 	private List<Family_vehicle> family_vehicle;
 	private List<Cadres_home> cadres_home;
 	//当前的动作【添加还是修改】
 	private String act;
	/**
	 * 显示组织机构树
	 * @return
	 * @throws IOException
	 */
	public String showCountryTree() throws IOException{
		String jsonstr = tMessageService.showCountryTree();
		HttpServletResponse response=ServletActionContext.getResponse();
 		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(jsonstr);
		out.close();
		return null;
	}
	/**
	 * 获取该村的所有户【分页】
	 * @return
	 * @throws IOException
	 */
	public String findFamilyMessages() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		//当前页  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //每页显示条数  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        //每页的开始记录  第一页为1  第二页为number +1   
//        int start = (intPage-1)*number;  
        
        //拼接URL的同时解码
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		//按户主姓名查询
		if(null!=familyMessage.getHzxm() && !familyMessage.getHzxm().equals("")){
			familyMessage.setHzxm("%"+URLDecoder.decode(familyMessage.getHzxm(), "utf-8")+"%");
		}
		pageBean = tMessageService.findFamilyMessages(familyMessage,pageBean);
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
	 * 获取该村的所有户【分页】
	 * @return
	 * @throws IOException
	 */
	public String findFamilyMessage() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		//当前页  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //每页显示条数  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        //每页的开始记录  第一页为1  第二页为number +1   
//        int start = (intPage-1)*number;  
        
        //拼接URL的同时解码
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		//按户主姓名查询
		if(null!=familyMessage.getHzxm() && !familyMessage.getHzxm().equals("")){
			familyMessage.setHzxm("%"+URLDecoder.decode(familyMessage.getHzxm(), "utf-8")+"%");
		}
		
		pageBean = tMessageService.findFamilyMessage(familyMessage,pageBean,countrys);
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
	 * 获取该户的人口列表
	 * @return
	 * @throws IOException
	 */
	public String familyPersonList() throws IOException{
		List<Person_message> list = tMessageService.familyPersonList(familyMessage);
		HttpServletResponse response=ServletActionContext.getResponse();
 		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONArray.fromObject(list)+"");
		out.close();
		return null;
	}
	/**
	 * 根据身份证号获取个人
	 * @return
	 * @throws IOException 
	 */
	public String getPersonOne() throws IOException{
		Person_message person = tMessageService.getPersonOne(person_message);
		HttpServletResponse response=ServletActionContext.getResponse();
 		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(person)+"");
		out.close();
		return null;
	}
	/**
	 * 添加、删除、修改
	 * @return
	 * @throws IOException
	 */
	public String savePerson() throws IOException{
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		inserted = request.getParameter("inserted");
		deleted = request.getParameter("deleted");
		updated = request.getParameter("updated");
		JSONArray jsonArray = null;
		Person_message[] person_message = null;
		String finall = null;
		if(null!=inserted){
			jsonArray=JSONArray.fromObject(inserted);
			person_message = (Person_message[]) JSONArray.toArray(jsonArray,Person_message.class);
			finall = tMessageService.inserted(person_message,familyMessage);
		}
		if(null!=deleted){
	 		jsonArray = JSONArray.fromObject(deleted);
	 		person_message = (Person_message[]) JSONArray.toArray(jsonArray,Person_message.class);
	 		finall = tMessageService.deleted(person_message,familyMessage);
	 	}
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		person_message = (Person_message[]) JSONArray.toArray(jsonArray,Person_message.class);
	 		finall = tMessageService.updated(person_message,familyMessage);
	 	}
	 	response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 保存新建的户（除人员信息外的所有信息）
	 * @return
	 * @throws IOException 
	 */
	public String saveFamilAllMessage() throws IOException{
		String finall = tMessageService.saveFamilAllMessage(familyMessage,
						person_message,family_vehicle,
						family_shebao,family_pay,
						family_other,family_income,
						family_assets,cadres_home);
		HttpServletResponse response=ServletActionContext.getResponse();
 		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 保存修改后的户（除人员信息外的所有信息）
	 * @return
	 * @throws IOException 
	 */
	public String saveUpdateFamilyAllMessage() throws IOException{
		String finall = tMessageService.saveUpdateFamilyAllMessage(familyMessage,
				person_message,family_vehicle,
				family_shebao,family_pay,
				family_other,family_income,
				family_assets,cadres_home);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return "ok";
	}
	/**
	 * 删除户
	 * @return
	 * @throws IOException 
	 */
	public String delFamilyAllMessage() throws IOException{
		String finall = tMessageService.delFamilyAllMessage(familyMessage);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	/**
	 * 查询户信息【机动车、经济、社保等】
	 * @return
	 * @throws IOException
	 */
	public String getFamliyMessage() throws IOException{
		Map<String,Object> map = tMessageService.getFamliyMessage(familyMessage);
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("familyMap", map);
		return "success";
	}
	/**
	 * 查询字典表获取下拉内容
	 * @return
	 * @throws IOException
	 */
	public String findOption() throws IOException{
		Map<String,Object> map = tMessageService.findOption();
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
	 * 注入service
	 * @param tMessageService
	 */
	public void settMessageService(IMessageService tMessageService) {
		this.tMessageService = tMessageService;
	}
	public FamilyMessage getFamilyMessage() {
		return familyMessage;
	}
	public void setFamilyMessage(FamilyMessage familyMessage) {
		this.familyMessage = familyMessage;
	}
	public Person_message getPerson_message() {
		return person_message;
	}
	public void setPerson_message(Person_message person_message) {
		this.person_message = person_message;
	}
	public String getHzxm() {
		return hzxm;
	}
	public void setHzxm(String hzxm) {
		this.hzxm = hzxm;
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
	public Family_shebao getFamily_shebao() {
		return family_shebao;
	}
	public void setFamily_shebao(Family_shebao family_shebao) {
		this.family_shebao = family_shebao;
	}
	public Family_pay getFamily_pay() {
		return family_pay;
	}
	public void setFamily_pay(Family_pay family_pay) {
		this.family_pay = family_pay;
	}
	public Family_other getFamily_other() {
		return family_other;
	}
	public void setFamily_other(Family_other family_other) {
		this.family_other = family_other;
	}
	public Family_income getFamily_income() {
		return family_income;
	}
	public void setFamily_income(Family_income family_income) {
		this.family_income = family_income;
	}
	public Family_assets getFamily_assets() {
		return family_assets;
	}
	public void setFamily_assets(Family_assets family_assets) {
		this.family_assets = family_assets;
	}
	public List<Family_vehicle> getFamily_vehicle() {
		return family_vehicle;
	}
	public void setFamily_vehicle(List<Family_vehicle> family_vehicle) {
		this.family_vehicle = family_vehicle;
	}
	public List<Cadres_home> getCadres_home() {
		return cadres_home;
	}
	public void setCadres_home(List<Cadres_home> cadres_home) {
		this.cadres_home = cadres_home;
	}
	public String getAct() {
		return act;
	}
	public void setAct(String act) {
		this.act = act;
	}
	public Country getCountrys() {
		return countrys;
	}
	public void setCountrys(Country countrys) {
		this.countrys = countrys;
	}
	
}
