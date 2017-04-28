package com.buba.rural.countypoverty.service;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.Country_poverty;

public interface IPovertyService {
	public abstract PageBean_easyui seachPoverty(Country_poverty flow, PageBean_easyui pageBean);
	public abstract String addPoverty(Country_poverty countrypoverty);
	public abstract String deleted(Country_poverty[] country,Country_poverty countrypoverty);
	public abstract String updated(Country_poverty[] country,Country_poverty countrypoverty);
	public abstract List seachrecord(Country_poverty countrypoverty);
	public abstract List seachlishi(Country_poverty countrypoverty);

}
