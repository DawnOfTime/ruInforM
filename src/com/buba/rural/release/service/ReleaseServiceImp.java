package com.buba.rural.release.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Article;
import com.buba.rural.release.dao.IReleaseDao;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class ReleaseServiceImp implements IReleaseService{
	private IReleaseDao releaseDao; 
	private IVersionRecordUtil vrUtil;
	
	public void add(Article article) {
		UUID uuid = UUID.randomUUID();
		article.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		article.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		article.setOperator(accs.getAcccode());
		try {
			vrUtil.insertVersionRecord(article, "add", "10", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		releaseDao.add(article);
	}
	public PageBean_easyui query(Article article,PageBean_easyui pageBean) {
		return releaseDao.query(article,pageBean);
	}
	public String deleted(Article[] article) {
		return releaseDao.deleted(article);
	}
	public Article findquery(String id) {
		return releaseDao.findquery(id);
	}
	public String update(Article article) {
				//录入时间
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				article.setOperate_time(df.format(new Date()));
				//操作人
				Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
				article.setOperator(accs.getAcccode());
				try {
					vrUtil.insertVersionRecord(article, "update", "10", accs.getAcccode(), df.format(new Date()), "id");
				} catch (Exception e) {
					e.printStackTrace();
				}
		return releaseDao.update(article);
	}
	public PageBean_easyui queryExamine(PageBean_easyui pageBean) {
		
		return releaseDao.queryExamine(pageBean);
	}
	public String UpExamine(Article article) {
		
		return releaseDao.UpExamine(article);
	}
	
	public String updateE(Article article) {
		return releaseDao.updateE(article);
	}
	public Map<String, Object> findOption() {
		return releaseDao.findOption();
	}
	/**
	 * ע��
	 * @param releaseDao
	 */
	public void setReleaseDao(IReleaseDao releaseDao) {
		this.releaseDao = releaseDao;
	}
	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}
}
