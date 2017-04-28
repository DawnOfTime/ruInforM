package com.buba.rural.statistics.service;

import java.util.List;

import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_building;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.Country_poverty;
import com.buba.rural.pojo.Land_industry;

public interface IStatisticsService {

	List<Country_building> getCountrybuilding(String cid);

	List<Country_poverty> getCountryPoverty(String cid);

	List<Country_group_finance> getCountryGroupFinance(String cid,String type);

	List<Land_industry> getCountryLand_industry(String cid);

	Country_building pie_countryBuilding(Country country);

	Country_poverty pie_countryPoverty(Country country);

	Land_industry pie_countryLand(Country country);

}
