package com.buba.rural.pojo;

public class County_outgoing {
	
	private String id;
	private String name;
	private String age;
	private String sex;
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
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
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
	@Override
	public String toString() {
		return "County_outgoing [id=" + id + ", name=" + name + ", age=" + age
				+ ", sex=" + sex + ", operate_time=" + operate_time
				+ ", operator=" + operator + ", cid=" + cid + "]";
	}
}
