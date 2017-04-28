package com.buba.rural.dictionary.service;


import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.dictionary.dao.IDictionaryDao;
import com.buba.rural.pojo.Dictionary;
import com.buba.rural.pojo.FamilyMessage;
import com.buba.rural.pojo.Person_message;

public class DictionaryServiceImpl  implements IDictionaryService{
	
	private IDictionaryDao idictionarydao;
	
	@Override
	public PageBean_easyui seachDic(Dictionary dictionary,PageBean_easyui pageBean) {
		return idictionarydao.seachDic(dictionary,pageBean);
	}
	@Override
	public String inserted(Dictionary[] diction,Dictionary dictionary) {
		return idictionarydao.inserted(diction);
	}
	@Override
	public String deleted(Dictionary[] diction,Dictionary dictionary) {
		return idictionarydao.deleted(diction);
	}
	@Override
	public String updated(Dictionary[] diction,Dictionary dictionary) {
		return idictionarydao.updated(diction);
	}
	
	
	
	public void setIdictionarydao(IDictionaryDao idictionarydao) {
		this.idictionarydao = idictionarydao;
	}

}
