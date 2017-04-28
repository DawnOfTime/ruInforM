package com.buba.rural.pojo;

public class Dictionary {
	private String dicid;//主键
	private String dictypecode;//类别代码
	private String dictypename;//类别名称
	private String dicname;//项目名称
	private String dicvalue;//项目值
	private String isenabled;//是否启用
	private String comm;//备注
	
	
	public String getDicid() {
		return dicid;
	}
	public void setDicid(String dicid) {
		this.dicid = dicid;
	}
	public String getDictypecode() {
		return dictypecode;
	}
	public void setDictypecode(String dictypecode) {
		this.dictypecode = dictypecode;
	}
	public String getDictypename() {
		return dictypename;
	}
	public void setDictypename(String dictypename) {
		this.dictypename = dictypename;
	}
	public String getDicname() {
		return dicname;
	}
	public void setDicname(String dicname) {
		this.dicname = dicname;
	}
	public String getDicvalue() {
		return dicvalue;
	}
	public void setDicvalue(String dicvalue) {
		this.dicvalue = dicvalue;
	}
	public String getIsenabled() {
		return isenabled;
	}
	public void setIsenabled(String isenabled) {
		this.isenabled = isenabled;
	}
	public String getComm() {
		return comm;
	}
	public void setComm(String comm) {
		this.comm = comm;
	}
	public Dictionary(String dicid, String dictypecode, String dictypename,
			String dicname, String dicvalue, String isenabled, String comm) {
		super();
		this.dicid = dicid;
		this.dictypecode = dictypecode;
		this.dictypename = dictypename;
		this.dicname = dicname;
		this.dicvalue = dicvalue;
		this.isenabled = isenabled;
		this.comm = comm;
	}
	public Dictionary() {
	}
	@Override
	public String toString() {
		return "Dictionary [dicid=" + dicid + ", dictypecode=" + dictypecode
				+ ", dictypename=" + dictypename + ", dicname=" + dicname
				+ ", dicvalue=" + dicvalue + ", isenabled=" + isenabled
				+ ", comm=" + comm + "]";
	}
}
