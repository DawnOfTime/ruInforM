package com.buba.rural.villageMessage.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.VersionRecord;
import com.buba.rural.versionRecord.IVersionRecordUtil;
//import com.buba.rural.versionRecord.VersionRecordUtil;
import com.buba.rural.villageMessage.dao.IVillageDao;

public class VillageServiceImpl implements IVillageService{
		private IVillageDao villageDao;
		private IVersionRecordUtil vrUtil;
		@Override
		public PageBean_easyui seachvillage(Country_message countrymessage,PageBean_easyui pageBean) {
			return villageDao.seachvillage(countrymessage,pageBean);
		}
		@Override
		public String deleted(Country_message[] country,Country_message countrymessage) {
			return villageDao.deleted(country);
		}
		@Override
		public String updated(Country_message[] country,Country_message countrymessage) {
			//录入时间
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//操作人
			Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
			for (int i = 0; i < country.length; i++) {
				country[i].setOperate_time(df.format(new Date()));
				country[i].setOperator(accs.getAcccode());
			}
			try {
				vrUtil.updateVersionRecord(country, "update", "1", accs.getAcccode(), df.format(new Date()), "id");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return villageDao.updated(country);
		}
		
		@Override
		public String addVillage(Country_message countrymessage) {
			UUID uuid = UUID.randomUUID();
			countrymessage.setId(uuid+"");
			//录入时间
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			countrymessage.setOperate_time(df.format(new Date()));
			//操作人
			Acc accs=(Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
			countrymessage.setOperator(accs.getAcccode());
			try {
				vrUtil.insertVersionRecord(countrymessage, "add", "1", accs.getAcccode(), df.format(new Date()), "id");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return villageDao.addVillage(countrymessage);
		}
		
		@Override
		public List seachrecord(Country_message countrymessage) {
			return villageDao.seachrecord(countrymessage);
		}
		
		@Override
		public List seachlishi(Country_message countrymessage) {
				return villageDao.seachlishi(countrymessage);
		}
		
		public void setVillageDao(IVillageDao villageDao) {
			this.villageDao = villageDao;
		}
		public void setVrUtil(IVersionRecordUtil vrUtil) {
			this.vrUtil = vrUtil;
		}
		
		
}
