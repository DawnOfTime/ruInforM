package com.buba.rural.login.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Rule;

public class LoginDaoImpl extends SqlSessionDaoSupport implements ILoginDao{
	@Override
	public Acc findAcc(Acc acc) {
		Acc resultAcc = getSqlSession().selectOne("com.buba.rural.pojo.Acc.findAcc",acc);
		return resultAcc;
	}
	@Override
	public List showMenu(Acc accs) {
		Rule rules = getSqlSession().selectOne("com.buba.rural.pojo.Rule.getRule",accs.getRid());
		String menucodeStr = rules.getMenucode();
		String [] menucodeArr = menucodeStr.split(",");
		return getSqlSession().selectList("com.buba.rural.pojo.Menu.showMenu",menucodeArr);
	}
}
