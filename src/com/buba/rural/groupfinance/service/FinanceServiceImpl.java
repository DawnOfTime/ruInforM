package com.buba.rural.groupfinance.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.groupfinance.dao.IFinanceDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class FinanceServiceImpl implements IFinanceService{
	private IVersionRecordUtil vrUtil;
	private IFinanceDao financeDao;
	
	/*@Override
	public PageBean_easyui seachFinance(Country_group_finance groupfinance,PageBean_easyui pageBean) {
		return financeDao.seachFinance(groupfinance, pageBean);
	}*/

	@Override
	public List seachFinance(Country_group_finance groupfinance) {
		return financeDao.seachFinance(groupfinance);
	}

	
	@Override
	public String deleted(Country_group_finance[] country,Country_group_finance groupfinance) {
		return financeDao.deleted(country);
	}

	@Override
	public String updated(Country_group_finance[] country,Country_group_finance groupfinance) {
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		for (int i = 0; i < country.length; i++) {
			country[i].setOperate_time(df.format(new Date()));
			country[i].setOperator(accs.getAcccode());
		}
		try {
			vrUtil.updateVersionRecord(country, "update", "7", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return financeDao.updated(country);
	}

	@Override
	public String addFinance(Country_group_finance groupfinance) {
		UUID uuid = UUID.randomUUID();
		groupfinance.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		groupfinance.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		groupfinance.setOperator(accs.getAcccode());
		try {
			vrUtil.insertVersionRecord(groupfinance, "add", "7", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return financeDao.addFinance(groupfinance);
	}

	@Override
	public Map<String, Object> findOption() {
		return financeDao.findOption();
	}
	
	
	@Override
	public List seachrecord(Country_group_finance groupfinance) {
		return financeDao.seachrecord(groupfinance);
	}

	
	@Override
	public PageBean_easyui seachlishi(Country_group_finance groupfinance,PageBean_easyui pageBean) {
		return financeDao.seachlishi(groupfinance, pageBean);
	}

	
	public void setFinanceDao(IFinanceDao financeDao) {
		this.financeDao = financeDao;
	}

	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}
	
}
