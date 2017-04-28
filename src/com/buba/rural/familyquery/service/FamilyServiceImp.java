package com.buba.rural.familyquery.service;

import java.util.Map;

import com.buba.rural.familyquery.dao.IFamilyqueryDao;
import com.buba.rural.pojo.FamilyMessage;

public class FamilyServiceImp implements IFamilyService{
	private IFamilyqueryDao familyDao;
	@Override
	public Map<String, Object> getFamliyMessage(FamilyMessage familyMessage) {
		return familyDao.getFamliyMessage(familyMessage);
	}
	
	public void setFamilyDao(IFamilyqueryDao familyDao) {
		this.familyDao = familyDao;
	}
	
	
 
}
