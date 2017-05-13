package com.buba.rural.communication.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_communication;

public interface ICommunicationService {
	public List querycommunication(Country_communication communication);
	public abstract String deleted(Country_communication[] country,Country_communication communication);
	public abstract String updated(Country_communication[] country,Country_communication communication);
	public abstract String addcommunication(Country_communication communication);
	public	Map<String, Object> findOption();
	public abstract List seachrecord(Country_communication communication);
	public abstract PageBean_easyui seachlishi(Country_communication communication,PageBean_easyui pageBean);
	
}
