package com.buba.rural.updatepws.dao;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;

public interface IUpdatepwsDao {
	public String updated(Acc[] ac);

	public PageBean_easyui seachacc(Acc acc, PageBean_easyui pageBean);

	public String ispwd(String id);

	public String savepwd(String password,String id);
}
