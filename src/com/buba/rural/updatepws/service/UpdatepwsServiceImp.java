package com.buba.rural.updatepws.service;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;
import com.buba.rural.updatepws.dao.IUpdatepwsDao;

public class UpdatepwsServiceImp implements IUpdatepwsService  {
	private IUpdatepwsDao updateDao;
	
	
	public String updated(Acc[] ac, Acc acc) {
		return updateDao.updated(ac);
	}

	public PageBean_easyui seachacc(Acc acc, PageBean_easyui pageBean) {
		return updateDao.seachacc(acc, pageBean);
	}
	


	public void setUpdateDao(IUpdatepwsDao updateDao) {
		this.updateDao = updateDao;
	}

	@Override
	public String ispwd() {
		HttpServletRequest request=ServletActionContext.getRequest();
		Acc acc = (Acc) request.getSession().getAttribute("resultacc");
		return updateDao.ispwd(acc.getId());
	}

	@Override
	public String savepwd(String password) {
		HttpServletRequest request=ServletActionContext.getRequest();
		Acc acc = (Acc) request.getSession().getAttribute("resultacc");
		return updateDao.savepwd(password,acc.getId());
	}
	
}
