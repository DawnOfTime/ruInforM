package com.buba.rural.countycommittee.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_committee;
import com.buba.rural.pojo.Country_message;

public interface ICommitteeSercvice {
	public abstract String updated(Country_committee[] country,Country_committee countrycommittee);
	public abstract String deleted(Country_committee[] country,Country_committee countrycommittee);
	public abstract String addCommittee(Country_committee countrycommittee);
	public abstract PageBean_easyui seachCommittee(Country_committee flow,PageBean_easyui pageBean);
	public	Map<String, Object> findOption();
	public abstract List seachrecord(Country_committee countrycommittee);
	public abstract List seachlishi(Country_committee countrycommittee);
}
