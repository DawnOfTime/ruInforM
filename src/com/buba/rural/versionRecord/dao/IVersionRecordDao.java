package com.buba.rural.versionRecord.dao;

import java.util.List;

import com.buba.rural.pojo.VersionRecord;

public interface IVersionRecordDao {

	Integer getMaxVersion(String id);

	String getOldContext(String id);

	void insertVersionRecord(List<VersionRecord> list);

}
