package com.buba.rural.outgoing.dao;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.County_outgoing;

public interface IOutgoingDao {

	List seachOutgoing(County_outgoing countyoutgoing);
	String deleted(County_outgoing[] country);
	String updated(County_outgoing[] country);
	String addOutgoing(County_outgoing countyoutgoing);
	public Map<String, Object> findOption();
	County_outgoing seachOne(County_outgoing countyoutgoing);
	PageBean_easyui seachHistory(County_outgoing countyoutgoing,PageBean_easyui pageBean);

}
