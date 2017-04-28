package com.buba.ruralR.article.service;


import java.util.List;

import com.buba.rural.pojo.Article;
import com.buba.rural.pojo.PageBean;
import com.buba.ruralR.article.dao.IArticleDao;

public class ArticleServiceImpl implements IArticleService{
	private IArticleDao articleDao;

	
	public Article getAll(String id) {
		return articleDao.getAll(id);
	}
	public List<Article> getAll() {
		return articleDao.getAll();
	}
	
	
	public void setArticleDao(IArticleDao articleDao) {
		this.articleDao = articleDao;
	}
	
	public PageBean selectlong(Article article, PageBean pageBean,
			String types) {
		return articleDao.selectlong(article,pageBean,types);
	}
	@Override
	public List<Article> seachtype(String types) {
		return  articleDao.seachtype(types);
		
	}

}
