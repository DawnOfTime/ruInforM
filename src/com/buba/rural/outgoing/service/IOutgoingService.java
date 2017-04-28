package com.buba.rural.outgoing.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.County_outgoing;

public interface IOutgoingService {

	public abstract PageBean_easyui seachOutgoing(County_outgoing countyoutgoing, PageBean_easyui pageBean);
	public abstract String addOutgoing(County_outgoing countyoutgoing);
	public abstract String deleted(County_outgoing[] country, County_outgoing countyoutgoing);
	public abstract String updated(County_outgoing[] country, County_outgoing countyoutgoing);
	public	Map<String, Object> findOption();
	public abstract County_outgoing seachOne(County_outgoing countyoutgoing);
	public abstract List<String> seachHistory(County_outgoing countyoutgoing);
}
