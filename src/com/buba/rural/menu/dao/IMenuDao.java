package com.buba.rural.menu.dao;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Menu;

public interface IMenuDao {

	PageBean_easyui findMenu(Menu menu, PageBean_easyui pageBean);

	String updated(Menu menu);

	List<Menu> findMenuTree();

	String inserted(Menu[] menu);

	String deleted(Menu[] menu);

}
