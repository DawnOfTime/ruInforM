package com.buba.rural.acc.service;

import java.util.List;

import com.buba.rural.acc.dao.IAccDao;
import com.buba.rural.comm.CountryTreeUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.comm.RuleMenuTreeUtil;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Rule;

public class AccServiceImpl implements IAccService{
	
	private IAccDao accDao;

	public PageBean_easyui seachacc(Acc acc,PageBean_easyui pageBean) {
		return accDao.seachacc(acc,pageBean);
	}
	@Override
	public String inserted(Acc[] ac, Acc acc) {
		 return accDao.inserted(ac);
	}
	@Override
	public String deleted(Acc[] ac, Acc acc) {
		 return accDao.deleted(ac);
	}
	@Override
	public String updated(Acc[] ac, Acc acc) {
		 return accDao.updated(ac);
	}
	@Override
	public void uppsw(Acc acc) {
		accDao.uppsw(acc);
	}
	@Override
	public List<Rule> getRule() {
		return accDao.getRule();
	}
	@Override
	public String addAcc(Acc acc) {
		return accDao.addAcc(acc);
	}
	@Override
	public String getCountryTree(Acc acc) {
		List<Country> list = accDao.getCountryTree(acc);
		CountryTreeUtil countryTreeUtil = new CountryTreeUtil();
		return countryTreeUtil.backComboTreeTreeRole(list);
	}
	@Override
	public String saveAcc_Country(Acc acc) {
		return accDao.saveAcc_Country(acc);
	}
	/**
	 * 注入
	 * @param accDao
	 */
	public void setAccDao(IAccDao accDao) {
		this.accDao = accDao;
	}
}
