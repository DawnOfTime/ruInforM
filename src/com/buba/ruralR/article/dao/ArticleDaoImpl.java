package com.buba.ruralR.article.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.pojo.Article;
import com.buba.rural.pojo.PageBean;

public class ArticleDaoImpl  extends SqlSessionDaoSupport implements IArticleDao{
	public Article getAll(String id){
		return  this.getSqlSession().selectOne("com.buba.rural.pojo.Article.findarticle",id);
	}
	public List<Article> getAll(){
		return  this.getSqlSession().selectList("com.buba.rural.pojo.Article.find");
	}
	public PageBean selectlong(Article article, PageBean pageBean,
			String types) {
		//查询总记录数
				long count=getSqlSession().selectOne("com.buba.rural.pojo.Article.selectlong",types);
				//当前页码-1*每页记录数=得出数据的条数
				pageBean.setPageindex((pageBean.getPagecode()-1)*pageBean.getPagesize());
				//表中总记录数
				pageBean.setTotalrecord((int)count);
				//从Pageindex开始进行查询，每页记录数为Pagesize
				Map hash=new HashMap();
				hash.put("pageBean", pageBean);
				hash.put("types", types);
				List<Article> rolelist=getSqlSession().selectList("com.buba.rural.pojo.Article.limitselect",hash);
				for(Article a : rolelist){ 
				}
				//当页的数据
				pageBean.setBeanList(rolelist);
				return pageBean;
	}
	public List<Article> seachtype(String types) {
		return  this.getSqlSession().selectList("com.buba.rural.pojo.Article.seachtype",types);

	}
	
}
