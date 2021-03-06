package com.buba.rural.message.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Cadres_home;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.FamilyMessage;
import com.buba.rural.pojo.Family_assets;
import com.buba.rural.pojo.Family_income;
import com.buba.rural.pojo.Family_other;
import com.buba.rural.pojo.Family_pay;
import com.buba.rural.pojo.Family_shebao;
import com.buba.rural.pojo.Family_vehicle;
import com.buba.rural.pojo.Person_message;

public interface IMessageService {

	String showCountryTree();

	PageBean_easyui findFamilyMessage(FamilyMessage flow, PageBean_easyui pageBean,Country countrys);

	List<Person_message> familyPersonList(FamilyMessage familyMessage);

	String inserted(Person_message[] person_message, FamilyMessage familyMessage);

	String deleted(Person_message[] person_message, FamilyMessage familyMessage);

	String updated(Person_message[] person_message, FamilyMessage familyMessage);

	Person_message getPersonOne(Person_message person_message);

	Map<String,Object> getFamliyMessage(FamilyMessage familyMessage);

	String saveFamilAllMessage(FamilyMessage familyMessage,
			Person_message person_message, List<Family_vehicle> family_vehicle,
			Family_shebao family_shebao, Family_pay family_pay,
			Family_other family_other, Family_income family_income,
			Family_assets family_assets, List<Cadres_home> cadres_home);

	String saveUpdateFamilyAllMessage(FamilyMessage familyMessage,
			Person_message person_message, List<Family_vehicle> family_vehicle,
			Family_shebao family_shebao, Family_pay family_pay,
			Family_other family_other, Family_income family_income,
			Family_assets family_assets, List<Cadres_home> cadres_home);
	public	Map<String, Object> findOption();

	String delFamilyAllMessage(FamilyMessage familyMessage);

	PageBean_easyui findFamilyMessages(FamilyMessage familyMessage,
			PageBean_easyui pageBean);
	
}
