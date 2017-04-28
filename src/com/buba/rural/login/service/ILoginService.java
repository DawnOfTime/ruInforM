package com.buba.rural.login.service;

import java.util.Map;

import com.buba.rural.pojo.Acc;

public interface ILoginService {
	public Acc findAcc(Acc acc);
	public Map showMenu(Acc accs);
}
