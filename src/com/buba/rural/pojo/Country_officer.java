package com.buba.rural.pojo;

public class Country_officer {
	private String id;
	private String name;
	private String sex;
	private String birthday;
	private String whcd;
	private String phonenumber;
	private String state;
	private String intime;
	private String lztime;
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
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
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
	public String getIntime() {
		return intime;
	}
	public void setIntime(String intime) {
		this.intime = intime;
	}
	public String getLztime() {
		return lztime;
	}
	public void setLztime(String lztime) {
		this.lztime = lztime;
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
	@Override
	public String toString() {
		return "Country_officer [id=" + id + ", name=" + name + ", sex=" + sex
				+ ", birthday=" + birthday + ", whcd=" + whcd
				+ ", phonenumber=" + phonenumber + ", state=" + state
				+ ", intime=" + intime + ", lztime=" + lztime
				+ ", operate_time=" + operate_time + ", operator=" + operator
				+ ", cid=" + cid + "]";
	}
	
	
}
