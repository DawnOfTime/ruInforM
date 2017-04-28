package com.buba.rural.familyquery.action;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.buba.rural.familyquery.service.IFamilyService;
import com.buba.rural.pojo.FamilyMessage;

public class FamilyAction {
	private IFamilyService familyService;
	private FamilyMessage familyMessage;
	
	
	public String getFamliyMessage() throws IOException{
		Map<String,Object> map = familyService.getFamliyMessage(familyMessage);
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("familyMap", map);
		return "success";
	}


	public FamilyMessage getFamilyMessage() {
		return familyMessage;
	}


	public void setFamilyMessage(FamilyMessage familyMessage) {
		this.familyMessage = familyMessage;
	}


	public void setFamilyService(IFamilyService familyService) {
		this.familyService = familyService;
	}
	
}
