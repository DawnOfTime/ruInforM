package com.buba.rural.outgoing.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.County_outgoing;

public class OutgoingDaoImpl extends SqlSessionDaoSupport implements IOutgoingDao{
	@Override
	public List seachOutgoing(County_outgoing countyoutgoing) {
		return getSqlSession().selectList("com.buba.rural.pojo.Outgoing.queryList",countyoutgoing);
	}

	@Override
	public String deleted(County_outgoing[] country) {
		 int a = getSqlSession().delete("com.buba.rural.pojo.Outgoing.deleteOutgoing", country);
			String finall = "no";
			if(a>0){
				finall="ok";
			}
			return finall;
	}

	@Override
	public String updated(County_outgoing[] country) {
		int a=getSqlSession().update("com.buba.rural.pojo.Outgoing.updateOutgoing", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String addOutgoing(County_outgoing countyoutgoing) {
		int  a = this.getSqlSession().insert("com.buba.rural.pojo.Outgoing.addOutgoing", countyoutgoing);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}
	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sex", getSqlSession().selectList("com.buba.rural.pojo.Outgoing.getOption","sex"));
		return map;
	}

	@Override
	public County_outgoing seachOne(County_outgoing countyoutgoing) {
		return getSqlSession().selectOne("com.buba.rural.pojo.Outgoing.seachOne",countyoutgoing);
	}

	@Override
	public PageBean_easyui seachHistory(County_outgoing countyoutgoing,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("countyoutgoing", countyoutgoing);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Outgoing.queryOutgoing",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Outgoing.seachHistory",map));
		return pageBean;
	}
}
