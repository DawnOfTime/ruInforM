package com.buba.rural.menu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.comm.TreeUtil;
import com.buba.rural.menu.dao.IMenuDao;
import com.buba.rural.pojo.Menu;

public class MenuServiceImpl implements IMenuService{
	private IMenuDao iMenuDao;
	/**
	 * 分页查询【菜单】
	 */
	public PageBean_easyui findMenu(Menu menu, PageBean_easyui pageBean) {
		return iMenuDao.findMenu(menu,pageBean);
	}
	public String updated(Map<String,String> map) {
		Menu menu = new Menu();
		menu.setId(map.get("id"));
		menu.setNum(map.get("num"));
		menu.setName(map.get("name"));
		menu.setFather_num(map.get("father_num"));
		menu.setLevel(map.get("level"));
		menu.setMenuurl(map.get("menuurl"));
		return iMenuDao.updated(menu);
	}
	//注入dao
	public void setiMenuDao(IMenuDao iMenuDao) {
		this.iMenuDao = iMenuDao;
	}
	public String findMenuTree() {
		List<Menu> list = iMenuDao.findMenuTree();
		TreeUtil treeUtil = new TreeUtil();
		return treeUtil.backComboTreeTreeRole(list);
	}
	@Override
	public String insertMenu(Menu[] menu) {
		return iMenuDao.inserted(menu);
	}
	@Override
	public String deleteMenu(Menu[] menu) {
		// TODO Auto-generated method stub
		return iMenuDao.deleted(menu);
	}
}
