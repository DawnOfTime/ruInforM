package com.buba.rural.dictionary.dao;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Dictionary;
import com.buba.rural.pojo.FamilyMessage;
import com.buba.rural.pojo.Person_message;

public interface IDictionaryDao {
	public abstract PageBean_easyui seachDic(Dictionary dictionary,PageBean_easyui pageBean);

	public abstract String inserted(Dictionary[] diction);
	public abstract String deleted(Dictionary[] diction);
	public abstract String updated(Dictionary[] diction);


}
