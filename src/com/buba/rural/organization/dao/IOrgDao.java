package com.buba.rural.organization.dao;

import java.util.HashMap;
import java.util.List;

import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Menu;

public interface IOrgDao {
	public abstract void addcuntry(Country country);
	public abstract void deletecounty(Country country);
	public abstract void updatecounty(Country country);
	public abstract List<Country> findCountryTree();
}
