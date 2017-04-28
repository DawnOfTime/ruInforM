package com.buba.ruralR.article.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.buba.rural.comm.FenYe;
import com.buba.rural.pojo.Article;
import com.buba.rural.pojo.PageBean;
import com.buba.ruralR.article.service.IArticleService;
import com.opensymphony.xwork2.ActionContext;

public class ArticleAction {

	private IArticleService articleservice;
	
	private Article article;
	private List<Article> articles;
	private String id;
	private String types;
	private String pagecode;
	
	
	public String searcharticle(){
		article=articleservice.getAll(id);
		return "success";
	}


	public String selecttype() throws IOException{
		
		HttpServletResponse response=(HttpServletResponse) ActionContext.getContext().get(ServletActionContext.HTTP_RESPONSE);
			articles=articleservice.seachtype(types);
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control","no-cache");
			PrintWriter pw=response.getWriter();
			pw=response.getWriter();
			pw.write(JSONArray.fromObject(articles)+"");
			pw.close();
			return null;
	}
	
	
	public String search() throws IOException{
		HttpServletResponse response=(HttpServletResponse) ActionContext.getContext().get(ServletActionContext.HTTP_RESPONSE);
		articles=articleservice.getAll();
		 response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control","no-cache");
			PrintWriter pw=response.getWriter();
			pw=response.getWriter();
			pw.write(JSONArray.fromObject(articles)+"");
			pw.close();

		return null;
	}
	public String selectlong() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		PageBean pageBean=new PageBean();
		//findpage();
		//三目运算符
		pageBean.setPagecode((null != pagecode && !"".equals(pagecode.trim())) ? Integer
				.parseInt(pagecode.trim()) : 1);			//去掉两边的空格
		//拼接那个分页的url
		pageBean.setUrl(FenYe.getParameterUrl(request.getParameterMap(), request,"/selectlong"));
		//页码															
		PageBean bean =articleservice.selectlong(article,pageBean,types);
		//重新setBeanList当前页数据
		pageBean.setBeanList(bean.getBeanList());
		//重新setTotalrecord总记录数
		pageBean.setTotalrecord(bean.getTotalrecord());
		//传到前台页面
		ActionContext.getContext().getSession().put("pageBean",pageBean);
		return  "listQuerys";
	}
	
	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}
	
	public List<Article> getArticles() {
		return articles;
	}

	public void setArticles(List<Article> articles) {
		this.articles = articles;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public void setArticleservice(IArticleService articleservice) {
		this.articleservice = articleservice;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public String getPagecode() {
		return pagecode;
	}

	public void setPagecode(String pagecode) {
		this.pagecode = pagecode;
	}
	
}
