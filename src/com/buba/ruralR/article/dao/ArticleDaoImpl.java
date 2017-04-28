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
		//��ѯ�ܼ�¼��
				long count=getSqlSession().selectOne("com.buba.rural.pojo.Article.selectlong",types);
				//��ǰҳ��-1*ÿҳ��¼��=�ó����ݵ�����
				pageBean.setPageindex((pageBean.getPagecode()-1)*pageBean.getPagesize());
				//�����ܼ�¼��
				pageBean.setTotalrecord((int)count);
				//��Pageindex��ʼ���в�ѯ��ÿҳ��¼��ΪPagesize
				Map hash=new HashMap();
				hash.put("pageBean", pageBean);
				hash.put("types", types);
				List<Article> rolelist=getSqlSession().selectList("com.buba.rural.pojo.Article.limitselect",hash);
				for(Article a : rolelist){ 
				}
				//��ҳ������
				pageBean.setBeanList(rolelist);
				return pageBean;
	}
	public List<Article> seachtype(String types) {
		return  this.getSqlSession().selectList("com.buba.rural.pojo.Article.seachtype",types);

	}
	
}
