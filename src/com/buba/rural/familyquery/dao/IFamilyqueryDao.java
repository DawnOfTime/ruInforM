package com.buba.rural.familyquery.dao;

import java.util.Map;

import com.buba.rural.pojo.FamilyMessage;

public interface IFamilyqueryDao {
	Map<String,Object> getFamliyMessage(FamilyMessage familyMessage);
}
