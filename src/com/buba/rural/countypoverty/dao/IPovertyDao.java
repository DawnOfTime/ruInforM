package com.buba.rural.countypoverty.dao;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_poverty;

public interface IPovertyDao {
/*	public abstract PageBean_easyui seachPoverty(Country_poverty countrypoverty,PageBean_easyui pageBean);*/
	public abstract  String deleted(Country_poverty[] country);
	public abstract  String updated(Country_poverty[] country);
	public abstract  String addPoverty(Country_poverty countrymessage);
	public abstract List seachrecord(Country_poverty countrypoverty);
	public abstract List seachPoverty(Country_poverty countrypoverty);
	public abstract PageBean_easyui seachlishi(Country_poverty countrypoverty,PageBean_easyui pageBean);

}
