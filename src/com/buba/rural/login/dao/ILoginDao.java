package com.buba.rural.login.dao;

import java.util.List;

import com.buba.rural.pojo.Acc;

public interface ILoginDao {
	public Acc findAcc(Acc acc);
	public List showMenu(Acc accs);
}
