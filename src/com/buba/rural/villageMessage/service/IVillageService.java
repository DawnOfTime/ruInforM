package com.buba.rural.villageMessage.service;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.VersionRecord;

public interface IVillageService {
	public abstract PageBean_easyui seachvillage(Country_message countrymessage,PageBean_easyui pageBean);
	public abstract String deleted(Country_message[] country,Country_message countrymessage);
	public abstract String updated(Country_message[] country,Country_message countrymessage);
	public abstract String addVillage(Country_message countrymessage);
	public abstract List seachrecord(Country_message countrymessage);
	public abstract PageBean_easyui seachlishi(Country_message countrymessage,PageBean_easyui pageBean);

}
