package com.buba.rural.menu.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Menu;

public interface IMenuService {

	PageBean_easyui findMenu(Menu menu, PageBean_easyui pageBean);

	String updated(Map<String,String> map);

	String findMenuTree();

	String insertMenu(Menu[] menu);

	String deleteMenu(Menu[] menu);

}
