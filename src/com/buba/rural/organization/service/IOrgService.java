package com.buba.rural.organization.service;

import java.util.List;

import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Menu;

public interface IOrgService {
	public abstract void addcountry(Country country);
	public abstract void deletecounty(Country country);
	public abstract void updatecounty(Country country);
	public abstract List<Country> findCountryTree();
}
