package com.buba.rural.acc.service;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Rule;

public interface IAccService {
	public abstract PageBean_easyui seachacc(Acc acc, PageBean_easyui pageBean);
	public abstract String inserted(Acc[] ac, Acc acc);
	public abstract String deleted(Acc[] ac, Acc acc);
	public abstract String updated(Acc[] ac, Acc acc);
	public abstract void uppsw(Acc acc);
	public abstract List<Rule> getRule();
	public abstract String addAcc(Acc acc);
	public abstract String getCountryTree(Acc acc);
	public abstract String saveAcc_Country(Acc acc);

}
