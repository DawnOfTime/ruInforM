package com.buba.rural.officer.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.CountryTreeUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.officer.dao.IOfficerDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country_officer;
import com.buba.rural.pojo.Menu;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class OfficerServiceImp implements IOfficerService{
	private IOfficerDao officerDao;
	private IVersionRecordUtil vrUtil;
	
	@Override
	public String showTree() {
		List<Menu> list = officerDao.showTree();
		CountryTreeUtil countryTreeUtil = new CountryTreeUtil();
		return countryTreeUtil.backComboTreeTreeRole(list);
	}
	
	@Override
	public PageBean_easyui queryofficer(Country_officer countryofficer,
			PageBean_easyui pageBean) {
		return officerDao.queryofficer(countryofficer, pageBean);
	}
	
	@Override
	public String deleted(Country_officer[] officer,
			Country_officer countryofficer) {
		
		return officerDao.deleted(officer);
	}

	@Override
	public String updated(Country_officer[] officer,
			Country_officer countryofficer) {
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		for (int i = 0; i < officer.length; i++) {
			officer[i].setOperate_time(df.format(new Date()));
			officer[i].setOperator(accs.getAcccode());
			if(officer[i].getLztime().equals("")){
				officer[i].setLztime(null);
			}
		}
		try {
			vrUtil.updateVersionRecord(officer, "update", "3", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return officerDao.updated(officer);
	}

	@Override
	public String addofficer(Country_officer countryofficer) {
		UUID uuid = UUID.randomUUID();
		countryofficer.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		countryofficer.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		countryofficer.setOperator(accs.getAcccode());
		try {
			vrUtil.insertVersionRecord(countryofficer, "add", "3", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return officerDao.addofficer(countryofficer);
	}
	@Override
	public Map<String, Object> findOption() {
		return officerDao.findOption();
	}
	@Override
	public List seachrecord(Country_officer countryofficer) {
		return officerDao.seachrecord(countryofficer);
	}
	@Override
	public List seachlishi(Country_officer countryofficer) {
		return officerDao.seachlishi(countryofficer);
	}
	public void setOfficerDao(IOfficerDao officerDao) {
		this.officerDao = officerDao;
	}

	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}

	
}
