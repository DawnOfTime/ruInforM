package com.buba.rural.versionRecord;

import com.buba.rural.pojo.Country_message;

public interface IVersionRecordUtil {
	void insertVersionRecord(Object object,String type,String scope,
			String operator,String operate_time,String id) throws Exception;

	void updateVersionRecord(Object[] object, String string,
			String string2, String acccode, String format, String string3) throws Exception;
}
