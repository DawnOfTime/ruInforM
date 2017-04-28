package com.buba.rural.flow.service;

import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_flow;

public interface IFlowService {

	PageBean_easyui findFlowPerson(Country_flow country_flow,
			PageBean_easyui pageBean);

	String addFlowPerson(Country_flow country_flow);

	String savedeleted(Country_flow[] flow);

	String saveupdated(Country_flow[] flow);

	Map<String, Object> findOption();

}
