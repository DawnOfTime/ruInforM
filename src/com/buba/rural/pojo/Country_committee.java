package com.buba.rural.pojo;


public class Country_committee {
	private String id;
	private String name;
	private String sex;
	private String birthday;
	private String whcd;
	private String lxfs;
	private String rxzsj;
	private String rznx;
	private String wyxm;
	private String state;
	private String zw;
	private String operate_time;
	private String operator;
	private String cid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getWhcd() {
		return whcd;
	}
	public void setWhcd(String whcd) {
		this.whcd = whcd;
	}
	public String getLxfs() {
		return lxfs;
	}
	public void setLxfs(String lxfs) {
		this.lxfs = lxfs;
	}
	public String getRxzsj() {
		return rxzsj;
	}
	public void setRxzsj(String rxzsj) {
		this.rxzsj = rxzsj;
	}
	public String getRznx() {
		return rznx;
	}
	public void setRznx(String rznx) {
		this.rznx = rznx;
	}
	public String getWyxm() {
		return wyxm;
	}
	public void setWyxm(String wyxm) {
		this.wyxm = wyxm;
	}
	public String getZw() {
		return zw;
	}
	public void setZw(String zw) {
		this.zw = zw;
	}
	public String getOperate_time() {
		return operate_time;
	}
	public void setOperate_time(String operate_time) {
		this.operate_time = operate_time;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "Country_committee [id=" + id + ", name=" + name + ", sex="
				+ sex + ", birthday=" + birthday + ", whcd=" + whcd + ", lxfs="
				+ lxfs + ", rxzsj=" + rxzsj + ", rznx=" + rznx + ", wyxm="
				+ wyxm + ", state=" + state + ", zw=" + zw + ", operate_time="
				+ operate_time + ", operator=" + operator + ", cid=" + cid
				+ "]";
	}
}
