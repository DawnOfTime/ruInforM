package com.buba.rural.statistics.service;

import java.util.List;

import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.pojo.Country_poverty;
import com.buba.rural.pojo.Land_industry;
import com.buba.rural.statistics.dao.IStatisticsDao;

public class StatisticsServiceImp implements IStatisticsService{
	private IStatisticsDao iStatisticsDao;
	/**
	 * 注入
	 * @param iStatisticsDao
	 */
	public void setiStatisticsDao(IStatisticsDao iStatisticsDao) {
		this.iStatisticsDao = iStatisticsDao;
	}
	@Override
	public List<Country_building> getCountrybuilding(String cid) {
		return iStatisticsDao.getCountrybuilding(cid);
	}
	@Override
	public List<Country_poverty> getCountryPoverty(String cid) {
		return iStatisticsDao.getCountryPoverty(cid);
	}
	@Override
	public List<Country_group_finance> getCountryGroupFinance(String cid,String type) {
		return iStatisticsDao.getCountryGroupFinance(cid,type);
	}
	@Override
	public List<Land_industry> getCountryLand_industry(String cid) {
		return iStatisticsDao.getCountryLand_industry(cid);
	}
	@Override
	public Country_building pie_countryBuilding(Country country) {
		return iStatisticsDao.pie_countryBuilding(country);
	}
	@Override
	public Country_poverty pie_countryPoverty(Country country) {
		return iStatisticsDao.pie_countryPoverty(country);
	}
	@Override
	public Land_industry pie_countryLand(Country country) {
		return iStatisticsDao.pie_countryLand(country);
	}
}
