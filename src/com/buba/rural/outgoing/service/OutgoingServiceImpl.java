package com.buba.rural.outgoing.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.outgoing.dao.IOutgoingDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.County_outgoing;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class OutgoingServiceImpl implements IOutgoingService{
	
	private IOutgoingDao outgoingDao;
	private IVersionRecordUtil vrUtil;
	
	@Override
	public List seachOutgoing(County_outgoing countyoutgoing) {
		return outgoingDao.seachOutgoing(countyoutgoing);
	}

	@Override
	public String addOutgoing(County_outgoing countyoutgoing) {
		UUID uuid = UUID.randomUUID();
		countyoutgoing.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		countyoutgoing.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		countyoutgoing.setOperator(accs.getAcccode());
		try {
			vrUtil.insertVersionRecord(countyoutgoing, "add", "8", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return outgoingDao.addOutgoing(countyoutgoing);
	}

	@Override
	public String deleted(County_outgoing[] country,County_outgoing countyoutgoing) {
		return outgoingDao.deleted(country);
	}

	@Override
	public String updated(County_outgoing[] country,County_outgoing countyoutgoing) {
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		for (int i = 0; i < country.length; i++) {
			country[i].setOperate_time(df.format(new Date()));
			country[i].setOperator(accs.getAcccode());
		}
		try {
			vrUtil.updateVersionRecord(country, "update", "8", accs.getAcccode(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return outgoingDao.updated(country);
	}

	@Override
	public Map<String, Object> findOption() {
		return outgoingDao.findOption();
	}
	
	public void setOutgoingDao(IOutgoingDao outgoingDao) {
		this.outgoingDao = outgoingDao;
	}

	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}

	@Override
	public County_outgoing seachOne(County_outgoing countyoutgoing) {
		return outgoingDao.seachOne(countyoutgoing);
	}

	@Override
	public PageBean_easyui seachHistory(County_outgoing countyoutgoing,PageBean_easyui pageBean) {
		return outgoingDao.seachHistory(countyoutgoing, pageBean);
	}

	
}
