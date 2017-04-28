package com.buba.rural.countryMessage.service;

import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.countryMessage.dao.ICountryMessageDao;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_message;

public class CountryMessageServiceImpl implements ICountryMessageService{
	private ICountryMessageDao iCountryMessageDao;
	/**
	 * 注入
	 * @param iCountryMessageDao
	 */
	public void setiCountryMessageDao(ICountryMessageDao iCountryMessageDao) {
		this.iCountryMessageDao = iCountryMessageDao;
	}
	@Override
	public Map<String, Object> findCountryAllMessage(
			Country_message country_message) {
		return iCountryMessageDao.findCountryAllMessage(country_message);
	}
	@Override
	public PageBean_easyui findCountryMessage(Country country,PageBean_easyui pageBean) {
		return iCountryMessageDao.findCountryMessage(country,pageBean);
	}
}
