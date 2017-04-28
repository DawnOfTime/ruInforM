package com.buba.rural.population.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.CountryTreeUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Person_message;
import com.buba.rural.population.dao.IPopulationDao;

public class PopulationServiceImp implements IPopulationService{
	private IPopulationDao populationDao;
	
	@Override
	public PageBean_easyui querypopulation(Country country,
			PageBean_easyui pageBean, Person_message person_message) {
		return populationDao.querypopulation(country, pageBean,person_message);
	}
	@Override
	public Map<String, Object> findOption() {
		return populationDao.findOption();
	}
	
	public void setPopulationDao(IPopulationDao populationDao) {
		this.populationDao = populationDao;
	}
}
