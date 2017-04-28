package com.buba.rural.message.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.comm.CountryTreeUtil;
import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.message.dao.IMessageDao;
import com.buba.rural.pojo.Acc;
import com.buba.rural.pojo.Cadres_home;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.FamilyMessage;
import com.buba.rural.pojo.Family_assets;
import com.buba.rural.pojo.Family_income;
import com.buba.rural.pojo.Family_other;
import com.buba.rural.pojo.Family_pay;
import com.buba.rural.pojo.Family_shebao;
import com.buba.rural.pojo.Family_vehicle;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Person_message;

public class MessageServiceImpl implements IMessageService{
	private IMessageDao iMessageDao;
	
	@Override
	public String showCountryTree() {
//		HttpServletRequest request=ServletActionContext.getRequest();
		Acc acc = (Acc) ServletActionContext.getRequest().getSession().getAttribute("resultacc");
		List<Menu> list = iMessageDao.showCountryTree(acc);
		CountryTreeUtil countryTreeUtil = new CountryTreeUtil();
		return countryTreeUtil.backComboTreeTreeRole(list);
	}
	
	@Override
	public PageBean_easyui findFamilyMessage(FamilyMessage familyMessage,PageBean_easyui pageBean,Country countrys) {
		return iMessageDao.findFamilyMessage(familyMessage, pageBean,countrys);
	}
	
	@Override
	public List<Person_message> familyPersonList(FamilyMessage familyMessage) {
		return iMessageDao.familyPersonList(familyMessage);
	}
	
	/**
	 * 注入dao
	 * @param iMessageDao
	 */
	public void setiMessageDao(IMessageDao iMessageDao) {
		this.iMessageDao = iMessageDao;
	}

	@Override
	public String inserted(Person_message[] person_message,FamilyMessage familyMessage) {
		for (int i = 0; i < person_message.length; i++) {
			if(person_message[i].getRdsj().equals("")){
				person_message[i].setRdsj(null);
			}
			person_message[i].setFid(familyMessage.getId());
		}
		return iMessageDao.inserted(person_message);
	}
	@Override
	public String deleted(Person_message[] person_message,FamilyMessage familyMessage) {
		return iMessageDao.deleted(person_message);
	}
	@Override
	public String updated(Person_message[] person_message,FamilyMessage familyMessage) {
		for (int i = 0; i < person_message.length; i++) {
			if(person_message[i].getRdsj().equals("")){
				person_message[i].setRdsj(null);
			}
			person_message[i].setFid(familyMessage.getId());
		}
		return iMessageDao.updated(person_message);
	}

	@Override
	public Person_message getPersonOne(Person_message person_message) {
		return iMessageDao.getPersonOne(person_message);
	}

	@Override
	public Map<String,Object> getFamliyMessage(FamilyMessage familyMessage) {
		return iMessageDao.getFamliyMessage(familyMessage);
	}

	@Override
	public String saveFamilAllMessage(FamilyMessage familyMessage,
			Person_message person_message, List<Family_vehicle> family_vehicle,
			Family_shebao family_shebao, Family_pay family_pay,
			Family_other family_other, Family_income family_income,
			Family_assets family_assets, List<Cadres_home> cadres_home) {
		UUID uuid = UUID.randomUUID();
		String fid = uuid+"";
		String cid = familyMessage.getCid().split(",")[0];
		familyMessage.setCid(cid);
		familyMessage.setId(fid);
		if(null!=family_vehicle){
			for (int i = 0; i < family_vehicle.size(); i++) {
				family_vehicle.get(i).setFid(fid);
			}
		}
		family_shebao.setFid(fid);
		family_pay.setFid(fid);
		family_other.setFid(fid);
		family_income.setFid(fid);
		family_assets.setFid(fid);
		if(null!=cadres_home){
			for (int i = 0; i < cadres_home.size(); i++) {
				cadres_home.get(i).setFid(fid);
			}
		}
		return iMessageDao.saveFamilAllMessage(familyMessage,
				person_message,family_vehicle,
				family_shebao,family_pay,
				family_other,family_income,
				family_assets,cadres_home);
	}

	@Override
	public String saveUpdateFamilyAllMessage(FamilyMessage familyMessage,
			Person_message person_message, List<Family_vehicle> family_vehicle,
			Family_shebao family_shebao, Family_pay family_pay,
			Family_other family_other, Family_income family_income,
			Family_assets family_assets, List<Cadres_home> cadres_home) {
		return iMessageDao.saveUpdateFamilyAllMessage(familyMessage,
				person_message,family_vehicle,
				family_shebao,family_pay,
				family_other,family_income,
				family_assets,cadres_home);
	}
	@Override
	public Map<String, Object> findOption() {
		return iMessageDao.findOption();
	}
	@Override
	public String delFamilyAllMessage(FamilyMessage familyMessage) {
		return iMessageDao.delFamilyAllMessage(familyMessage);
	}

	@Override
	public PageBean_easyui findFamilyMessages(FamilyMessage familyMessage,
			PageBean_easyui pageBean) {
		return iMessageDao.findFamilyMessages(familyMessage, pageBean);
	}

	
}
