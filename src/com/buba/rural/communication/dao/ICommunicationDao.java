package com.buba.rural.communication.dao;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_communication;

public interface ICommunicationDao {
	public Country_communication querycommunication(Country_communication communication);
	public abstract String deleted(Country_communication[] country);
	public abstract String updated(Country_communication[] country);
	public abstract String addcommunicationr(Country_communication communication);
	public Map<String, Object> findOption();
	List seachrecord(Country_communication communication);
	PageBean_easyui seachlishi(Country_communication communication,PageBean_easyui pageBean);
}
