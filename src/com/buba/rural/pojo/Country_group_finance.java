package com.buba.rural.pojo;

public class Country_group_finance {
	private String id;
	private String type;
	private Float privce;
	private String message;
	private String operate_time;
	private String operator;
	private String cid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Float getPrivce() {
		return privce;
	}
	public void setPrivce(Float privce) {
		this.privce = privce;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
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
		return "Country_group_finance [id=" + id + ", type=" + type
				+ ", privce=" + privce + ", message=" + message
				+ ", operate_time=" + operate_time + ", operator=" + operator
				+ ", cid=" + cid + "]";
	}
	
}
