package com.buba.rural.countypoverty.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.countypoverty.dao.IPovertyDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country_poverty;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class PovertyServiceImpl implements IPovertyService{
	private IPovertyDao povertyDao;
	private IVersionRecordUtil vrUtil;
	
	public PageBean_easyui seachPoverty(Country_poverty flow, PageBean_easyui pageBean) {
		return povertyDao.seachPoverty(flow,pageBean);
	}
	public String deleted(Country_poverty[] country,Country_poverty countrypoverty) {
		return povertyDao.deleted(country);
	}
	public String updated(Country_poverty[] country,Country_poverty countrypoverty) {
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		for (int i = 0; i < country.length; i++) {
			country[i].setOperate_time(df.format(new Date()));
			country[i].setOperator(accs.getAcccode());
		}
		try {
			vrUtil.updateVersionRecord(country, "update", "5", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return povertyDao.updated(country);
	}
	public String addPoverty(Country_poverty countrypoverty) {
		UUID uuid = UUID.randomUUID();
		countrypoverty.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		countrypoverty.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		countrypoverty.setOperator(accs.getAcccode());
		try {
			vrUtil.insertVersionRecord(countrypoverty, "add", "5", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return povertyDao.addPoverty(countrypoverty);
	}
	
	@Override
	public List seachrecord(Country_poverty countrypoverty) {
		return povertyDao.seachrecord(countrypoverty);
	}
	@Override
	public List seachlishi(Country_poverty countrypoverty) {
		return  povertyDao.seachlishi(countrypoverty);
	}
	
	public void setPovertyDao(IPovertyDao povertyDao) {
		this.povertyDao = povertyDao;
	}
	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}
	
	
}
