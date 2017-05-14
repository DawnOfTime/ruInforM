package com.buba.rural.countryBuilding.dao;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_building;

public interface IBuildingDao {
	public abstract List seachbuilding(Country_building countrybuilding);

	public abstract String addaddBuilding(Country_building countrybuilding);
	public abstract String updated(Country_building[] country);
	public abstract String deleted(Country_building[] country);
	public abstract List seachrecord(Country_building countrybuilding);
	public abstract PageBean_easyui seachlishi(Country_building countrybuilding, PageBean_easyui pageBean);
}
