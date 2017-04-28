package com.buba.rural.organization.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Menu;

public class OrgDaoImpl extends SqlSessionDaoSupport implements IOrgDao{
	@Override
	public void addcuntry(Country country){
		this.getSqlSession().insert("com.buba.rural.pojo.Country.addcountry",country);
	}
	@Override
	public void deletecounty(Country country) {
		this.getSqlSession().delete("com.buba.rural.pojo.Country.deletecountry", country);
		
	}
	@Override
	public void updatecounty(Country country) {
		this.getSqlSession().update("com.buba.rural.pojo.Country.updatecounty", country);
	}
	@Override
	public List<Country> findCountryTree() {
		return getSqlSession().selectList("com.buba.rural.pojo.Country.findCountryTree");
	}
}
