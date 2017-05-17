package com.buba.rural.land_industry.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.land_industry.dao.ILand_industryDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Land_industry;
import com.buba.rural.pojo.VersionRecord;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class Land_industryServiceImp implements ILand_industryService{
	private	ILand_industryDao land_industryDao;
	private IVersionRecordUtil vrUtil;

	@Override
	public List queryland_industry(Land_industry land_industry) {
		// TODO Auto-generated method stub
		return land_industryDao.queryland_industry(land_industry);
	}

	@Override
	public String deleted(Land_industry[] land, Land_industry land_industry) {
		// TODO Auto-generated method stub
		return land_industryDao.deleted(land);
	}

	@Override
	public String updated(Land_industry[] land, Land_industry land_industry) {
		// TODO Auto-generated method stub
		//录入时间
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//操作人
				Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
				for (int i = 0; i < land.length; i++) {
					land[i].setOperate_time(df.format(new Date()));
					land[i].setOperator(accs.getUsername());
				}
				try {
					vrUtil.updateVersionRecord(land, "update", "9", accs.getUsername(), df.format(new Date()), "id");
				} catch (Exception e) {
					e.printStackTrace();
				}
		return land_industryDao.updated(land);
	}

	@Override
	public String addland_industry(Land_industry land_industry) {
		// TODO Auto-generated method stub
		UUID uuid = UUID.randomUUID();
		land_industry.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		land_industry.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		land_industry.setOperator(accs.getUsername());
		try {
			vrUtil.insertVersionRecord(land_industry, "add", "9", accs.getUsername(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return land_industryDao.addland_industry(land_industry);
	}
	

	public void setLand_industryDao(ILand_industryDao land_industryDao) {
		this.land_industryDao = land_industryDao;
	}

	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}

	@Override
	public Land_industry searchLand_industry(Land_industry land_industry) {
		return land_industryDao.searchLand_industry(land_industry);
	}

	@Override
	public PageBean_easyui searchHistory(Land_industry land_industry,PageBean_easyui pageBean) {
		return land_industryDao.searchHistory(land_industry, pageBean);
	}
	
}
