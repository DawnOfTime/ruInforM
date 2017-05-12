package com.buba.rural.land_industry.dao;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Land_industry;
import com.buba.rural.pojo.VersionRecord;

public interface ILand_industryDao {
	public List queryland_industry(Land_industry land_industry);
	public abstract String deleted(Land_industry[] land);
	public abstract String updated(Land_industry[] land);
	public abstract String addland_industry(Land_industry land_industry);
	public Land_industry searchLand_industry(Land_industry land_industry);
	public PageBean_easyui searchHistory(Land_industry land_industry,PageBean_easyui pageBean);
}
