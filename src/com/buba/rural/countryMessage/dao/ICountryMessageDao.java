package com.buba.rural.countryMessage.dao;

import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_message;

public interface ICountryMessageDao {

	Map<String, Object> findCountryAllMessage(Country_message country_message);

	PageBean_easyui findCountryMessage(Country country,PageBean_easyui pageBean);

}
