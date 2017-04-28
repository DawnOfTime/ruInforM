package com.buba.rural.dictionary.service;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Dictionary;
import com.buba.rural.pojo.Person_message;


public interface IDictionaryService {
	public abstract PageBean_easyui seachDic(Dictionary dictionary, PageBean_easyui pageBean);

	public abstract String inserted(Dictionary[] diction,Dictionary dictionary);
	public abstract String deleted(Dictionary[] diction,Dictionary dictionary);
	public abstract String updated(Dictionary[] diction,Dictionary dictionary);
}
