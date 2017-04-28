package com.buba.rural.pojo;

public class Acc {
	private String id;
	private String username;
	private String acccode;
	private String password;
	private String isable;
	private String rid;
	private String rulename;
	private String countryCode;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAcccode() {
		return acccode;
	}
	public void setAcccode(String acccode) {
		this.acccode = acccode;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getIsable() {
		return isable;
	}
	public void setIsable(String isable) {
		this.isable = isable;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRulename() {
		return rulename;
	}
	public void setRulename(String rulename) {
		this.rulename = rulename;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	@Override
	public String toString() {
		return "Acc [id=" + id + ", username=" + username + ", acccode=" + acccode + ", password=" + password
				+ ", isable=" + isable + ", rid=" + rid + ", rulename=" + rulename + ", countryCode=" + countryCode
				+ "]";
	}
}
