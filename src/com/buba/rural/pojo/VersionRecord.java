package com.buba.rural.pojo;

public class VersionRecord {
	private String id;
	private String context;
	private Integer version;
	private String type;
	private String scope;
	private String operator;
	private String operate_time;
	private String operate_describe;
	private String initialid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getOperate_time() {
		return operate_time;
	}
	public void setOperate_time(String operate_time) {
		this.operate_time = operate_time;
	}
	public String getOperate_describe() {
		return operate_describe;
	}
	public void setOperate_describe(String operate_describe) {
		this.operate_describe = operate_describe;
	}
	public String getInitialid() {
		return initialid;
	}
	public void setInitialid(String initialid) {
		this.initialid = initialid;
	}
	@Override
	public String toString() {
		return "VersionRecord [id=" + id + ", context=" + context
				+ ", version=" + version + ", type=" + type + ", scope="
				+ scope + ", operator=" + operator + ", operate_time="
				+ operate_time + ", operate_describe=" + operate_describe
				+ ", initialid=" + initialid + "]";
	}
}
