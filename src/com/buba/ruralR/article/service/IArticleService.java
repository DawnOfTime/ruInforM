package com.buba.ruralR.article.service;


import java.util.List;

import com.buba.rural.pojo.Article;
import com.buba.rural.pojo.PageBean;

public interface IArticleService {
	public Article getAll(String id);
	public List<Article> getAll();
	public PageBean selectlong(Article article,PageBean pageBean,String types);
	public List<Article> seachtype(String types);
}
