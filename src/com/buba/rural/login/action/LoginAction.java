package com.buba.rural.login.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.buba.rural.comm.Md5;
import com.buba.rural.login.service.ILoginService;
import com.buba.rural.pojo.Acc;

public class LoginAction {
	private ILoginService loginService;
	
	private Acc acc;
	private String errorMessage;
	/**
	 * login.jsp后台登录
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws NoSuchAlgorithmException 
	 */
	public String findAcc() throws NoSuchAlgorithmException, UnsupportedEncodingException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Acc resultacc = loginService.findAcc(acc);
		Md5 md = new Md5();
		if(null!=resultacc){
			if(resultacc.getPassword().equals(md.toMd5(acc.getPassword()))){
				session.setAttribute("resultacc", resultacc);
				return "success";
			}else{
				request.setAttribute("errorMessage", "密码错误！");
				return "error";
			}
		}else{
			request.setAttribute("errorMessage", "该账号不存在！");
			return "error";
		}
	}
	/**
	 * ajax  left.jsp后台登录
	 * @return
	 * @throws IOException
	 * @throws NoSuchAlgorithmException 
	 */
	public String ajaxlogin() throws IOException, NoSuchAlgorithmException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String errorMessage = "";
		Acc resultacc = loginService.findAcc(acc);
		Md5 md = new Md5();
		if(null!=resultacc){
			if(resultacc.getPassword().equals(md.toMd5(acc.getPassword()))){
				session.setAttribute("resultacc", resultacc);
				errorMessage="success";
			}else{
				errorMessage="密码错误！";
			}
		}else{
			errorMessage="该账号不存在！";
		}
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(errorMessage);
		out.close();
		return null;
	}
	public String exit(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("resultacc");
		return "success";
	}
	/**
	 * 使用easyUI，利用json格式数据加载菜单列表
	 * @return null [ajax异步加载]
	 * @throws Exception 
	 */
	public String showMenu() throws Exception{
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpServletRequest request=ServletActionContext.getRequest();
		Acc accs = (Acc) request.getSession().getAttribute("resultacc");
		Map map = loginService.showMenu(accs);
		String jsonstr = JSONObject.fromObject(map)+"";
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(jsonstr);
		out.close();
		return null;
	}
	/**
	 * 进入index.jsp
	 * @return
	 */
	public String gotoindex(){
		return "success";
	}
	public Acc getAcc() {
		return acc;
	}
	public void setAcc(Acc acc) {
		this.acc = acc;
	}
	//向页面发送
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	//注入service
	public void setLoginService(ILoginService loginService) {
		this.loginService = loginService;
	}
}
