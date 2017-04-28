package com.buba.rural.acc.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Rule;

public class AccDaoImpl extends SqlSessionDaoSupport implements IAccDao {
	@Override
	public PageBean_easyui seachacc(Acc acc,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("acc", acc);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Acc.queryacc",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Acc.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}

	@Override
	public String inserted(Acc[] ac) {
		getSqlSession().insert("com.buba.rural.pojo.Acc.insertac",ac);
		return "ok";
	}
	@Override
	public String deleted(Acc[] ac) {
		getSqlSession().delete("com.buba.rural.pojo.Acc.deleteac",ac);
		return "ok";
	}
	@Override
	public String updated(Acc[] ac) {
		for (int i = 0; i < ac.length; i++) {
			getSqlSession().update("com.buba.rural.pojo.Acc.updateac",ac[i]);
		}
		return "ok";
	}
	@Override
	public void uppsw(Acc acc) {
		this.getSqlSession().update("com.buba.rural.pojo.Acc.uppsw", acc);
	}

	@Override
	public List<Rule> getRule() {
		return getSqlSession().selectList("com.buba.rural.pojo.Acc.getRule");
	}

	@Override
	public String addAcc(Acc acc) {
		int a = getSqlSession().insert("com.buba.rural.pojo.Acc.addAcc",acc);
		if(a>0){
			return "ok";
		}
		return null;
	}

	@Override
	public List<Country> getCountryTree(Acc acc) {
		String countryCode = getSqlSession().selectOne("com.buba.rural.pojo.Acc.getAcc",acc);
		if(null==countryCode){
			countryCode = "";
		}
		String [] countryArray = countryCode.split(";");
		String [] countryCodeArray = countryArray[1].split(",");
		return getSqlSession().selectList("com.buba.rural.pojo.Acc.getCountryTree",countryCodeArray);
	}

	@Override
	public String saveAcc_Country(Acc acc) {
		int a = getSqlSession().update("com.buba.rural.pojo.Acc.saveAcc_Country",acc);
		if(a>0){
			return "ok";
		}
		return "no";
	}
}
