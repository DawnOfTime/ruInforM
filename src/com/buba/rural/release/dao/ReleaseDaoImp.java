package com.buba.rural.release.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Article;
import com.buba.rural.pojo.Rule;

public class ReleaseDaoImp extends SqlSessionDaoSupport implements IReleaseDao {
	
	public PageBean_easyui query(Article article,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("article",article);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Article.queryCount",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Article.queryList",map));
		return pageBean;
	}
	
	public void add(Article article) {
		this.getSqlSession().insert("com.buba.rural.pojo.Article.add",article);
	}

/*	public List<Article> query(PageBean_easyui pageBean) {
		return getSqlSession().selectList("com.buba.rural.pojo.Article.query");
	}*/
	public Article findquery(String id) {
		return this.getSqlSession().selectOne("com.buba.rural.pojo.Article.findquery",id);
	}
	public String deleted(Article[] article) {
		this.getSqlSession().insert("com.buba.rural.pojo.Article.deleted",article);
		return null;
	}

	@Override
	public String update(Article article) {
		this.getSqlSession().update("com.buba.rural.pojo.Article.update", article);
		return null;
	}
	@Override
	public PageBean_easyui queryExamine(PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Article.Countexamine",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Article.queryexamine",map));
		return pageBean;
	}

	@Override
	public String UpExamine(Article article) {
		this.getSqlSession().update("com.buba.rural.pojo.Article.upexamine", article);
		return null;
	}
	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", getSqlSession().selectList("com.buba.rural.pojo.Article.getOption","exam_state"));
		map.put("types", getSqlSession().selectList("com.buba.rural.pojo.Article.getOption","state_lb"));
		return map;
	}

	@Override
	public String updateE(Article article) {
		this.getSqlSession().update("com.buba.rural.pojo.Article.updatee", article);
		return null;
	}
}
