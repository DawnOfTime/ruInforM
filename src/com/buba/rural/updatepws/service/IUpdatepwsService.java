package com.buba.rural.updatepws.service;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Acc;

public interface IUpdatepwsService {

	public String updated(Acc[] ac, Acc acc);

	public PageBean_easyui seachacc(Acc acc, PageBean_easyui pageBean);

	public String ispwd();

	public String savepwd(String password);
}
