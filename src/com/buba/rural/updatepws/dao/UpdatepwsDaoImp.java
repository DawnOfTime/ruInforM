package com.buba.rural.updatepws.dao;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;

public class UpdatepwsDaoImp extends SqlSessionDaoSupport implements IUpdatepwsDao{

	public String updated(Acc[] ac) {
		for (int i = 0; i < ac.length; i++) {
			getSqlSession().update("com.buba.rural.pojo.PwsMapper.updateac",ac[i]);
		}
		return "ok";
	}

	public PageBean_easyui seachacc(Acc acc, PageBean_easyui pageBean) {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Acc accs=(Acc) session.getAttribute("resultacc");
		Map map = new HashMap();
		map.put("acc", acc);
		map.put("pageBean", pageBean);
		map.put("accs", accs);
		//��ȡ�ܼ�¼����
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.PwsMapper.queryacc",map));
		//��ѯ��¼
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.PwsMapper.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}

	@Override
	public String ispwd(String id) {
		return getSqlSession().selectOne("com.buba.rural.pojo.PwsMapper.ispwd",id);
	}

	@Override
	public String savepwd(String password,String id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("password", password);
		map.put("id", id);
		int a = getSqlSession().update("com.buba.rural.pojo.PwsMapper.savepwd",map);
		if(a>0){
			return "ok";
		}
		return null;
	}
}
