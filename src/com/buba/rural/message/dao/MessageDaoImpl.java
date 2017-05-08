package com.buba.rural.message.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
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


public class MessageDaoImpl extends SqlSessionDaoSupport implements IMessageDao{

	@Override
	public List<Menu> showCountryTree(Acc acc) {
		String countryCode = acc.getCountryCode();
		String [] cStr = null;
		if(null!=countryCode){
			cStr = countryCode.split(";")[0].split(",");
		}else{
			cStr = new String[]{""};
		}
		return getSqlSession().selectList("com.buba.rural.pojo.Country.showCountryTree",cStr);
	}

	@Override
	public PageBean_easyui findFamilyMessage(FamilyMessage familyMessage,PageBean_easyui pageBean,Country countrys) {
		Map<String,Object> map = new HashMap<String,Object>();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String cid = request.getParameter("cid");
		map.put("familyMessage", familyMessage);
		map.put("pageBean", pageBean);
		map.put("countrys", countrys);
		map.put("cid",cid);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.familyMessageCount",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}

	@Override
	public List<Person_message> familyPersonList(FamilyMessage familyMessage) {
		return getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.familyPersonMessage",familyMessage);
	}

	@Override
	public String inserted(Person_message[] person_message) {
		getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.insertPerson_message",person_message);
		return "ok";
	}
	@Override
	public String deleted(Person_message[] person_message) {
		getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.deletePerson_message",person_message);
		return "ok";
	}
	@Override
	public String updated(Person_message[] person_message) {
		for (int i = 0; i < person_message.length; i++) {
			getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.updatePerson_message",person_message[i]);
		}
		return "ok";
	}

	@Override
	public Person_message getPersonOne(Person_message person_message) {
		return getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getPersonOne",person_message);
	}

	@Override
	public Map<String,Object> getFamliyMessage(FamilyMessage familyMessage) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("family_message", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_message",familyMessage));
		map.put("family_assets", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_assets",familyMessage));
		map.put("family_vehicle", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getFamily_vehicle",familyMessage));
		map.put("family_income", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_income",familyMessage));
		map.put("family_pay", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_pay",familyMessage));
		map.put("family_shebao", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_shebao",familyMessage));
		map.put("family_other", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_other",familyMessage));
		map.put("cadres_home", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getCadres_home",familyMessage));
		map.put("familyPersonNumber",getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.familyPersonNumber",familyMessage));
		return map;
	}

	@Override
	public String saveFamilAllMessage(FamilyMessage familyMessage,
			Person_message person_message, List<Family_vehicle> family_vehicle,
			Family_shebao family_shebao, Family_pay family_pay,
			Family_other family_other, Family_income family_income,
			Family_assets family_assets, List<Cadres_home> cadres_home) {
		int a = 0;
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveFamilyMessage",familyMessage);
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveFamily_vehicle",family_vehicle);
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveFamily_shebao",family_shebao);
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveFamily_pay",family_pay);
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveFamily_other",family_other);
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveFamily_income",family_income);
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveFamily_assets",family_assets);
		a+=getSqlSession().insert("com.buba.rural.pojo.FamilyMessage.saveCadres_home",cadres_home);
		if(a<8){
			getSqlSession().rollback();
		}
		return "ok";
	}

	@Override
	public String saveUpdateFamilyAllMessage(FamilyMessage familyMessage,
			Person_message person_message, List<Family_vehicle> family_vehicle,
			Family_shebao family_shebao, Family_pay family_pay,
			Family_other family_other, Family_income family_income,
			Family_assets family_assets, List<Cadres_home> cadres_home) {
		if(null!=familyMessage){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedFamilyMessage",familyMessage);
		}
		if(null!=family_vehicle){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedFamily_vehicle",family_vehicle);
		}
		if(null!=family_shebao){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedFamily_shebao",family_shebao);
		}
		if(null!=family_pay){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedFamily_pay",family_pay);
		}
		if(null!=family_other){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedFamily_other",family_other);
		}
		if(null!=family_income){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedFamily_income",family_income);
		}
		if(null!=family_assets){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedFamily_assets",family_assets);
		}
		if(null!=cadres_home){
			getSqlSession().update("com.buba.rural.pojo.FamilyMessage.updatedCadres_home",cadres_home);
		}
		return "ok";
	}
	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("yhzgx", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","yhzgx"));
		map.put("xb", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","sex"));
		map.put("zzmm", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","zzmm"));
		map.put("hyzk", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","hyState"));
		map.put("jkzk", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","jkzk"));
		map.put("whcd", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","whcdState"));
		map.put("cyzt", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","cy_state"));
		map.put("zylx", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","zy_type"));
		map.put("gzdw", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getOption","gz_type"));
		return map;
	}

	@Override
	public String delFamilyAllMessage(FamilyMessage familyMessage) {
		int a = 0;
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delfamilyMessage",familyMessage);
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delfamily_vehicle",familyMessage);
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delfamily_shebao",familyMessage);
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delfamily_pay",familyMessage);
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delfamily_other",familyMessage);
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delfamily_income",familyMessage);
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delfamily_assets",familyMessage);
		a += getSqlSession().delete("com.buba.rural.pojo.FamilyMessage.delcadres_home",familyMessage);
		if(a>0){
			return "ok";
		}
		return null;
	}

	@Override
	public PageBean_easyui findFamilyMessages(FamilyMessage familyMessage,
			PageBean_easyui pageBean) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("familyMessage", familyMessage);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.queryone",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}
}
