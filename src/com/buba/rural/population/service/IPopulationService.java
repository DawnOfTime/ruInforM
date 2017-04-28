package com.buba.rural.population.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Person_message;

public interface IPopulationService {
	public	Map<String, Object> findOption();
	public PageBean_easyui querypopulation(Country country,PageBean_easyui pageBean, Person_message person_message);
}
