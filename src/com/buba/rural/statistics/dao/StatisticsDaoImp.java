package com.buba.rural.statistics.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.pojo.Country_poverty;
import com.buba.rural.pojo.Land_industry;

public class StatisticsDaoImp extends SqlSessionDaoSupport implements IStatisticsDao{

	@Override
	public List<Country_building> getCountrybuilding(String cid) {
		return getSqlSession().selectList("com.buba.rural.statistics.getCountrybuilding",cid);
	}

	@Override
	public List<Country_poverty> getCountryPoverty(String cid) {
		return getSqlSession().selectList("com.buba.rural.statistics.getCountryPoverty",cid);
	}

	@Override
	public List<Country_group_finance> getCountryGroupFinance(String cid,String type) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("cid", cid);
		map.put("type", type);
		return getSqlSession().selectList("com.buba.rural.statistics.getCountryGroupFinance",map);
	}

	@Override
	public List<Land_industry> getCountryLand_industry(String cid) {
		return getSqlSession().selectList("com.buba.rural.statistics.getCountryLand_industry",cid);
	}

	@Override
	public Country_building pie_countryBuilding(Country country) {
		return getSqlSession().selectOne("com.buba.rural.statistics.pie_countryBuilding",country);
	}

	@Override
	public Country_poverty pie_countryPoverty(Country country) {
		return getSqlSession().selectOne("com.buba.rural.statistics.pie_countryPoverty",country);
	}

	@Override
	public Land_industry pie_countryLand(Country country) {
		return getSqlSession().selectOne("com.buba.rural.statistics.pie_countryLand",country);
	}
}
