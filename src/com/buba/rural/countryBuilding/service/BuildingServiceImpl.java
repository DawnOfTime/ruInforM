package com.buba.rural.countryBuilding.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.countryBuilding.dao.IBuildingDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class BuildingServiceImpl implements IBuildingService{
	
	private IBuildingDao buildingDao;
	private IVersionRecordUtil vrUtil;
	
	
	/*public PageBean_easyui seachbuilding(Country_building countrybuilding,PageBean_easyui pageBean) {
		return buildingDao.seachbuilding(countrybuilding,pageBean);
	}*/
	
	public List searchbuilding(Country_building countrybuilding) {
		// TODO Auto-generated method stub
		return buildingDao.seachbuilding(countrybuilding);
	}

	@Override
	public String addBuilding(Country_building countrybuilding) {
		UUID uuid = UUID.randomUUID();
		countrybuilding.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		countrybuilding.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		countrybuilding.setOperator(accs.getUsername());
		try {
			vrUtil.insertVersionRecord(countrybuilding, "add", "4", accs.getUsername(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return buildingDao.addaddBuilding(countrybuilding);
	}
	@Override
	public String deleted(Country_building[] country,Country_building countrybuilding) {
		return buildingDao.deleted(country);
	}
	@Override
	public String updated(Country_building[] country,Country_building countrybuilding) {
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		for (int i = 0; i < country.length; i++) {
			country[i].setOperate_time(df.format(new Date()));
			country[i].setOperator(accs.getUsername());
		}
		try {
			vrUtil.updateVersionRecord(country, "update", "4", accs.getUsername(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return buildingDao.updated(country);
	}
	
	
	@Override
	public List seachrecord(Country_building countrybuilding) {
		return buildingDao.seachrecord(countrybuilding);
	}
	
	@Override
	public PageBean_easyui seachlishi(Country_building countrybuilding,PageBean_easyui pageBean) {
		return buildingDao.seachlishi(countrybuilding,pageBean);
	}
	
	
	public void setBuildingDao(IBuildingDao buildingDao) {
		this.buildingDao = buildingDao;
	}
	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}

	
	
}
