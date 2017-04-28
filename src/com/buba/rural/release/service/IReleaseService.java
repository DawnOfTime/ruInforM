package com.buba.rural.release.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Article;

public interface IReleaseService {
	public abstract void add(Article article);
	public abstract PageBean_easyui query(Article article, PageBean_easyui pageBean);
	public abstract String deleted(Article[] article);
	public abstract Article findquery(String id);
	public abstract String update(Article article);
	public abstract PageBean_easyui queryExamine(PageBean_easyui pageBean);
	public abstract String UpExamine(Article article);
	public abstract String updateE(Article article);
	public	Map<String, Object> findOption();
}
