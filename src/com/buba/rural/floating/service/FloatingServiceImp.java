package com.buba.rural.floating.service;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.floating.dao.IFloatingDao;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_flow;

public class FloatingServiceImp implements IFloatingService{
	private IFloatingDao floatingDao;
	@Override
	public PageBean_easyui findFlowPerson(Country country,Country_flow country_flow,
			PageBean_easyui pageBean) {
		return floatingDao.findFlowPerson(country,country_flow, pageBean);
	}
	
	public void setFloatingDao(IFloatingDao floatingDao) {
		this.floatingDao = floatingDao;
	}

}
