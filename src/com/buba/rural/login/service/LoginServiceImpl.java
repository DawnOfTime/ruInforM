package com.buba.rural.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.buba.rural.login.dao.ILoginDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Menu;

public class LoginServiceImpl implements ILoginService{
	private ILoginDao dao;
	public Acc findAcc(Acc acc){
		Acc resultAcc = dao.findAcc(acc);
		return resultAcc;
	}
	public void setDao(ILoginDao dao) {
		this.dao = dao;
	}
	/**
	 * 转换数据格式
	 */
	public Map showMenu(Acc accs) {
		List menus = dao.showMenu(accs);
		Map menuMap=new HashMap();
		
		for (int i = 0; i < menus.size(); i++) {
			Menu m = (Menu) menus.get(i);
			String father_num = m.getFather_num();
			List childrens = new ArrayList();
			if(null!=menuMap.get(father_num)){
				childrens = (List) menuMap.get(father_num);
			}
			childrens.add(m);
			menuMap.put(father_num, childrens);
		}
		return menuMap;
	}
}
