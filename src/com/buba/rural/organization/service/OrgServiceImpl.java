package com.buba.rural.organization.service;

import java.util.HashMap;
import java.util.List;

import com.buba.rural.organization.dao.IOrgDao;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Menu;

public class OrgServiceImpl implements IOrgService{
	
	private IOrgDao orgDao;

	public void addcountry(Country country){
		orgDao.addcuntry(country);
	}
	@Override
	public void deletecounty(Country country) {
		orgDao.deletecounty(country);
	}
	@Override
	public void updatecounty(Country country) {
		orgDao.updatecounty(country);
	}
	@Override
	public List<Country> findCountryTree(){
		return orgDao.findCountryTree();
	}
	
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	
}
