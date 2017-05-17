package com.buba.rural.communication.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.communication.dao.ICommunicationDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country_communication;
import com.buba.rural.versionRecord.IVersionRecordUtil;

public class CommunicationServiceImp implements ICommunicationService{
	private ICommunicationDao communicationDao;
	private IVersionRecordUtil vrUtil;
	
	@Override
	public List querycommunication(Country_communication communication) {
		return communicationDao.querycommunication(communication);
	}

	@Override
	public String deleted(Country_communication[] country,
			Country_communication communication) {
		return communicationDao.deleted(country);
	}

	@Override
	public String updated(Country_communication[] country,
			Country_communication communication) {
				//录入时间
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//操作人
				Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
				for (int i = 0; i < country.length; i++) {
					country[i].setOperate_time(df.format(new Date()));
					country[i].setOperator(accs.getUsername());
				}
				try {
					vrUtil.updateVersionRecord(country, "update", "6", accs.getUsername(), df.format(new Date()), "id");
				} catch (Exception e) {
					e.printStackTrace();
				}
		return communicationDao.updated(country);
	}

	@Override
	public String addcommunication(Country_communication communication) {
		UUID uuid = UUID.randomUUID();
		communication.setId(uuid+"");
		//录入时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		communication.setOperate_time(df.format(new Date()));
		//操作人
		Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		communication.setOperator(accs.getUsername());
		try {
			vrUtil.insertVersionRecord(communication, "add", "6", accs.getUsername(), df.format(new Date()), "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return communicationDao.addcommunicationr(communication);
	}
	
	@Override
	public Map<String, Object> findOption() {
		return communicationDao.findOption();
	}
	@Override
	public List seachrecord(Country_communication communication) {
		return communicationDao.seachrecord(communication);
	}

	@Override
	public PageBean_easyui seachlishi(Country_communication communication,PageBean_easyui pageBean) {
		return communicationDao.seachlishi(communication,pageBean);
	}
	
	public void setCommunicationDao(ICommunicationDao communicationDao) {
		this.communicationDao = communicationDao;
	}

	public void setVrUtil(IVersionRecordUtil vrUtil) {
		this.vrUtil = vrUtil;
	}
}
