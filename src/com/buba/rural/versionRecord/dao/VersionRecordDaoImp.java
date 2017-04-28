package com.buba.rural.versionRecord.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.pojo.VersionRecord;

public class VersionRecordDaoImp extends SqlSessionDaoSupport implements IVersionRecordDao{

	@Override
	public Integer getMaxVersion(String id) {
		Integer a = getSqlSession().selectOne("com.buba.rural.pojo.VersionRecord.getMaxVersion",id);
		return getSqlSession().selectOne("com.buba.rural.pojo.VersionRecord.getMaxVersion",id);
	}

	@Override
	public String getOldContext(String id) {
		String jsonstr = getSqlSession().selectOne("com.buba.rural.pojo.VersionRecord.getOldContext",id);
		return getSqlSession().selectOne("com.buba.rural.pojo.VersionRecord.getOldContext",id);
	}

	@Override
	public void insertVersionRecord(List<VersionRecord> list) {
		getSqlSession().insert("com.buba.rural.pojo.VersionRecord.insertVersionRecord",list);
		
	}

}
