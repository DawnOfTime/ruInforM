package com.buba.rural.countryBuilding.service;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_message;

public interface IBuildingService {
/*	public abstract  PageBean_easyui seachbuilding(Country_building countrybuilding,PageBean_easyui pageBean);*/
	public abstract String addBuilding(Country_building countrybuilding);
	public abstract String deleted(Country_building[] country,Country_building countrybuilding);
	public abstract String updated(Country_building[] country,Country_building countrybuilding);
	public abstract List seachrecord(Country_building countrybuilding);
	public abstract Country_building searchbuilding(Country_building countrybuilding);
	public abstract PageBean_easyui seachlishi(
			Country_building countrybuilding, PageBean_easyui pageBean);
}
