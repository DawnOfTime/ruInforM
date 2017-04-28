package com.buba.rural.countycommittee.dao;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_committee;

public interface ICommitteeDao {

	PageBean_easyui seachCommittee(Country_committee countrycommittee,PageBean_easyui pageBean);
	String deleted(Country_committee[] country);
	String updated(Country_committee[] country);
	String addCommittee(Country_committee countrycommittee);
	public Map<String, Object> findOption();
	List seachrecord(Country_committee countrycommittee);
	List seachlishi(Country_committee countrycommittee);

}
