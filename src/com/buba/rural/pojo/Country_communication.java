package com.buba.rural.pojo;

public class Country_communication {
	private String id;
	private String is_ydxh;//是否有移动信号
	private String is_ltxh;//是否有联通信号
	private String is_dxxh;//是否有电信信号
	private String is_qcfg;//是否全村覆盖
	private String operate_time;
	private String operator;
	private String cid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIs_ydxh() {
		return is_ydxh;
	}
	public void setIs_ydxh(String is_ydxh) {
		this.is_ydxh = is_ydxh;
	}
	public String getIs_ltxh() {
		return is_ltxh;
	}
	public void setIs_ltxh(String is_ltxh) {
		this.is_ltxh = is_ltxh;
	}
	public String getIs_dxxh() {
		return is_dxxh;
	}
	public void setIs_dxxh(String is_dxxh) {
		this.is_dxxh = is_dxxh;
	}
	
	public String getIs_qcfg() {
		return is_qcfg;
	}
	public void setIs_qcfg(String is_qcfg) {
		this.is_qcfg = is_qcfg;
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
		return "Country_communication [id=" + id + ", is_ydxh=" + is_ydxh
				+ ", is_ltxh=" + is_ltxh + ", is_dxxh=" + is_dxxh
				+ ", is_qcfg=" + is_qcfg + ", operate_time=" + operate_time
				+ ", operator=" + operator + ", cid=" + cid + "]";
	}
	
}
