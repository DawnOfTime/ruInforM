package com.buba.rural.updatepws.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.HttpUtil;
import com.buba.rural.comm.Md5;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.updatepws.service.IUpdatepwsService;

public class UpdatepwsAction {
	private Acc acc;
	private IUpdatepwsService updateService;
	
	private String page;
	private String rows;
	//����
	 	private String updated;
	
	//��ѯ
	public String seachacc() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		//��ǰҳ  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //ÿҳ��ʾ����  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        //ÿҳ�Ŀ�ʼ��¼  ��һҳΪ1  �ڶ�ҳΪnumber +1   
        int start = (intPage-1)*number;  
        
        //ƴ��URL��ͬʱ����
		PageBean_easyui pageBean = new PageBean_easyui();
		pageBean.setPagecode(intPage);
		pageBean.setPagesize(number);
		
		String pattern = "";
		String getpar = HttpUtil.getParameterUrl(request.getParameterMap(),request,pattern);
		pageBean.setUrl(getpar);
		
		pageBean=updateService.seachacc(acc,pageBean);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();//����map 
		jsonMap.put("total", pageBean.getTotalrecord());//total�� ����ܼ�¼���������  
        jsonMap.put("rows", pageBean.getBeanList());//rows�� ���ÿҳ��¼ list 
        response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(JSONObject.fromObject(jsonMap)+"");
		out.close();
		return null;
	}
	
	/**
	 * �޸�
	 * @return
	 * @throws IOException
	 */
	public String saveAcc() throws IOException{
		
		HttpServletResponse response=ServletActionContext.getResponse();
		JSONArray jsonArray = null;
		Acc[] ac = null;
		String finall = null;
	 	if(null!=updated){
	 		jsonArray = JSONArray.fromObject(updated);
	 		ac = (Acc[]) JSONArray.toArray(jsonArray,Acc.class);
	 		finall = updateService.updated(ac,acc);
	 	}
	 	response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	public String ispwd() throws IOException, NoSuchAlgorithmException{
		HttpServletResponse response=ServletActionContext.getResponse();
		Md5 md = new Md5();
		String password = updateService.ispwd();
		String finall = "";
		if(password.equals(md.toMd5(acc.getPassword()))){
			finall = "ok";
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(finall);
		out.close();
		return null;
	}
	public String savepwd() throws NoSuchAlgorithmException, IOException{
		HttpServletResponse response=ServletActionContext.getResponse();
		Md5 md = new Md5();
		String finall = updateService.savepwd(md.toMd5(acc.getPassword()));
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

	public String getUpdated() {
		return updated;
	}

	public void setUpdated(String updated) {
		this.updated = updated;
	}

	public void setUpdateService(IUpdatepwsService updateService) {
		this.updateService = updateService;
	}
}
