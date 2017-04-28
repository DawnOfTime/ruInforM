package com.buba.rural.acc.dao;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Rule;

public interface IAccDao {
	public abstract PageBean_easyui seachacc(Acc acc, PageBean_easyui pageBean);
	public abstract String inserted(Acc[] ac);
	public abstract String deleted(Acc[] ac);
	public abstract String updated(Acc[] ac);
	public abstract void uppsw(Acc acc);
	public abstract List<Rule> getRule();
	public abstract String addAcc(Acc acc);
	public abstract List<Country> getCountryTree(Acc acc);
	public abstract String saveAcc_Country(Acc acc);

}
