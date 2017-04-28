package com.buba.rural.pojo;

public class Article {
	private String id;
	private String titles;
	private String texts;
	private String riqis;
	private String types;
	private String state;
	private String operator;
	private String operate_time;
	private String remarks;
	private String starttime;
	private String overtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitles() {
		return titles;
	}
	public void setTitles(String titles) {
		this.titles = titles;
	}
	public String getTexts() {
		return texts;
	}
	public void setTexts(String texts) {
		this.texts = texts;
	}
	public String getRiqis() {
		return riqis;
	}
	public void setRiqis(String riqis) {
		this.riqis = riqis;
	}
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getOvertime() {
		return overtime;
	}
	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}
	public Article() {
		super();
	}
	public Article(String id, String titles, String texts, String riqis,
			String types, String state, String operator, String operate_time,
			String remarks) {
		super();
		this.id = id;
		this.titles = titles;
		this.texts = texts;
		this.riqis = riqis;
		this.types = types;
		this.state = state;
		this.operator = operator;
		this.operate_time = operate_time;
		this.remarks = remarks;
	}
	@Override
	public String toString() {
		return "Article [id=" + id + ", titles=" + titles + ", texts=" + texts
				+ ", riqis=" + riqis + ", types=" + types + ", state=" + state
				+ ", operator=" + operator + ", operate_time=" + operate_time
				+ ", remarks=" + remarks + "]";
	}
	
	
}
