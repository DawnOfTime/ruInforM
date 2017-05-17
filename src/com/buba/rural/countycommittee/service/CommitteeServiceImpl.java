package com.buba.rural.countycommittee.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.countycommittee.dao.ICommitteeDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country_committee;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class CommitteeServiceImpl implements ICommitteeSercvice{
	
	private ICommitteeDao committeeDao;
	private IVersionRecordUtil vrUtil;
	
	@Override
	public PageBean_easyui seachCommittee(Country_committee countrycommittee,PageBean_easyui pageBean) {
		return committeeDao.seachCommittee(countrycommittee,pageBean);
	}
	@Override
	public String deleted(Country_committee[] country,Country_committee countrycommittee) {
		return committeeDao.deleted(country);
	}
	@Override
	public String updated(Country_committee[] country,Country_committee countrycommittee) {
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		for (int i = 0; i < country.length; i++) {
			country[i].setOperate_time(df.format(new Date()));
			country[i].setOperator(accs.getUsername());
		}
		try {
			vrUtil.updateVersionRecord(country, "update", "2", accs.getUsername(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return committeeDao.updated(country);
	}
	@Override
	public String addCommittee(Country_committee countrycommittee) {
		UUID uuid = UUID.randomUUID();
		countrycommittee.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		countrycommittee.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		countrycommittee.setOperator(accs.getUsername());
		try {
			vrUtil.insertVersionRecord(countrycommittee, "add", "2", accs.getUsername(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return committeeDao.addCommittee(countrycommittee);
	}
	@Override
	public Map<String, Object> findOption() {
		return committeeDao.findOption();
	}
	@Override
	public List seachrecord(Country_committee countrycommittee) {
		return committeeDao.seachrecord(countrycommittee);
	}
	@Override
	public PageBean_easyui seachlishi(Country_committee countrycommittee,PageBean_easyui pageBean) {
		return committeeDao.seachlishi(countrycommittee,pageBean);
	}
	
	
	
	public void setCommitteeDao(ICommitteeDao committeeDao) {
		this.committeeDao = committeeDao;
	}
	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}
}
