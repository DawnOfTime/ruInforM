package com.buba.rural.organization.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.CountryTreeUtil;
import com.buba.rural.comm.TreeUtil;
import com.buba.rural.organization.service.IOrgService;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Menu;

public class OrgAction {

	private IOrgService orgService;
	private Country country;
	
	
	public String findCountryTree() throws IOException{
		List<Country> list = orgService.findCountryTree();
		HttpServletResponse response=ServletActionContext.getResponse();
 		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		CountryTreeUtil treeuitl=new CountryTreeUtil();
		String json=treeuitl.backComboTreeTreeRole(list);
		out.write(json);
		out.close();
		return null;
	}
	//添加
	public String addcountry(){
		orgService.addcountry(country);
		return null;
	}
	//删除
	public String deletecounty(){
		orgService.deletecounty(country);
		return null;
	}
	
	//修改
		public String updatecounty(){
			orgService.updatecounty(country);
			return null;
		}
	
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	public void setOrgService(IOrgService orgService) {
		this.orgService = orgService;
	}
	
	
}
