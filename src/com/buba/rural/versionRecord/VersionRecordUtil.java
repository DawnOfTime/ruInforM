package com.buba.rural.versionRecord;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.VersionRecord;
import com.buba.rural.versionRecord.dao.IVersionRecordDao;

/**
 * 操作记录公共类
 * @author liy
 *
 */
public class VersionRecordUtil implements IVersionRecordUtil{
	private IVersionRecordDao versionRecordDao;
	/**
	 * 
	 * @param objects 添加或修改的对象或对象数组
	 * @param id	主键字段名
	 * @param type	操作类型
	 * @param scope	操作范围
	 * @param operator 操作人
	 * @param operate_time 操作时间
	 * @throws SecurityException 
	 * @throws NoSuchMethodException 
	 */
	public void insertVersionRecord(Object object,String type,String scope,String operator,String operate_time,String id) throws Exception{
		Object [] objects = new Object[1];
		objects[0] = object;
		updateVersionRecord(objects,type,scope,operator,operate_time,id);
	}
	public void updateVersionRecord(Object [] objects,String type,String scope,String operator,String operate_time,String id) throws Exception{
		List<VersionRecord> list = new ArrayList<VersionRecord>();
		for (int i = 0; i < objects.length; i++) { 
			String firstLetter = id.substring(0, 1).toUpperCase();
			String getter = "get" + firstLetter + id.substring(1);
			Method method = objects[i].getClass().getMethod(getter, new Class[] {});
			String idValue = (String) method.invoke(objects[i], new Object[] {});
			
			VersionRecord vr = new VersionRecord();
			
			vr.setContext(JSONObject.fromObject(objects[i])+"");
			Integer version = 1;//版本号默认为1
			if(type.equals("update")){
				version = getMaxVersion(idValue)+1;//获取最大版本号并加1
			}
			vr.setVersion(version);
			vr.setType(type);
			vr.setScope(scope);
			vr.setOperator(operator);
			vr.setOperate_time(operate_time);
			vr.setInitialid(idValue);
			String operate_describe = getOperate_describe(idValue,JSONObject.fromObject(objects[i])+"");
			if(type.equals("add")){
				operate_describe = "";
			}
			vr.setOperate_describe(operate_describe);
			list.add(vr);
		}
		versionRecordDao.insertVersionRecord(list);
	}
	
	
	
	/**
	 * 根据初始记录ID获取该记录的最大版本号
	 * @param id
	 * @return
	 */
	public Integer getMaxVersion(String id){
		Integer maxVersion = versionRecordDao.getMaxVersion(id);
		if(null==maxVersion){
			maxVersion = 1;
		}
		return maxVersion;
//		return 1;
	}
	/**
	 * 根据初始记录ID获取数据库中该记录的最新版本，比较修改后的数据有哪些变动
	 * @param id
	 * @param clazz
	 * @return
	 */
	public String getOperate_describe(String id,String newJson){
		newJson = newJson.replaceAll("\\{", "");
		newJson = newJson.replaceAll("\\}", "");
		String [] newJsons = newJson.split(",");
		
		String oldJson = versionRecordDao.getOldContext(id);
		if(null==oldJson){
			oldJson = "";
		}
		
		oldJson = oldJson.replaceAll("\\{", "");
		oldJson = oldJson.replaceAll("\\}", "");
		String [] oldJsons = oldJson.split(",");
		
		String str = "";
		for (int i = 0; i < oldJsons.length; i++) {
			if(!newJsons[i].equals(oldJsons[i])){
				if(!str.equals("")){
					str+=",";
				}
				str+= oldJsons[i]+"改为"+newJsons[i];
			}
		}
		
		return str;
	}
	public static void main(String[] args) throws Exception {
		VersionRecordUtil vru = new VersionRecordUtil();
		Country_message cm = new Country_message();
		cm.setId("456");
		cm.setBcczdzywt("asdf");
		Country_message [] objects = new Country_message[1];
		objects[0] = cm;
		String type = "add";
//		String type = "update";
		String scope = "1";
		String operator = "1";
		String operate_time = "1";
		String id = "id";
		Class clazz = Country_message.class;
		vru.insertVersionRecord(objects,type,scope,operator,operate_time,id);
	}
	/**
	 * 注入
	 * @param versionRecordDao
	 */
	public void setVersionRecordDao(IVersionRecordDao versionRecordDao) {
		this.versionRecordDao = versionRecordDao;
	}
}
