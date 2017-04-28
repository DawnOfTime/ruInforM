package com.buba.rural.pojo;

public class Rule {
	private String id;
	private String rname;//角色名称
	private String menucode;//菜单编码（用逗号隔开的字符串）
	private String comm;//描述（备注）
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getMenucode() {
		return menucode;
	}
	public void setMenucode(String menucode) {
		this.menucode = menucode;
	}
	public String getComm() {
		return comm;
	}
	public void setComm(String comm) {
		this.comm = comm;
	}
	@Override
	public String toString() {
		return "Rule [id=" + id + ", rname=" + rname + ", menucode=" + menucode
				+ ", comm=" + comm + "]";
	}
}
