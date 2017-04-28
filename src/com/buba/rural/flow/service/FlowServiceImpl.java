package com.buba.rural.flow.service;

import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.flow.dao.IFlowDao;
import com.buba.rural.pojo.Country_flow;

public class FlowServiceImpl implements IFlowService{
	private IFlowDao iFlowDao;
	/**
	 * 注入
	 * @param iFlowDao
	 */
	public void setiFlowDao(IFlowDao iFlowDao) {
		this.iFlowDao = iFlowDao;
	}
	@Override
	public PageBean_easyui findFlowPerson(Country_flow country_flow,
			PageBean_easyui pageBean) {
		return iFlowDao.findFlowPerson(country_flow,pageBean);
	}
	@Override
	public String addFlowPerson(Country_flow country_flow) {
		return iFlowDao.addFlowPerson(country_flow);
	}
	@Override
	public String savedeleted(Country_flow[] flow) {
		return iFlowDao.savedeleted(flow);
	}
	@Override
	public String saveupdated(Country_flow[] flow) {
		return iFlowDao.saveupdated(flow);
	}
	@Override
	public Map<String, Object> findOption() {
		return iFlowDao.findOption();
	}
}
