package com.buba.rural.menu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.junit.Test;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Menu;

public class MenuDaoImpl extends SqlSessionDaoSupport implements IMenuDao{
	/**
	 * 分页查询【菜单】
	 */
	public PageBean_easyui findMenu(Menu menu, PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("menu", menu);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Menu.menuCount",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Menu.menuList",map));
		return pageBean;
	}
	public String inserted(Menu [] menu) {
		getSqlSession().insert("com.buba.rural.pojo.Menu.insertMenu",menu);
		return "ok";
	}
	public String deleted(Menu [] menu) {
		getSqlSession().delete("com.buba.rural.pojo.Menu.deleteMenu",menu);
		return "ok";
	}
	public String updated(Menu menu) {
		getSqlSession().update("com.buba.rural.pojo.Menu.updateMenu",menu);
		return "ok";
	}
	@Override
	public List<Menu> findMenuTree() {
		return getSqlSession().selectList("com.buba.rural.pojo.Menu.findMenu");
	}
}
