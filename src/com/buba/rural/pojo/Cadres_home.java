package com.buba.rural.pojo;

public class Cadres_home {
	private String id;
	private String gbname;
	private String rhtime;
	private String jjwtqk;
	private String fid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGbname() {
		return gbname;
	}
	public void setGbname(String gbname) {
		this.gbname = gbname;
	}
	public String getRhtime() {
		return rhtime;
	}
	public void setRhtime(String rhtime) {
		this.rhtime = rhtime;
	}
	public String getJjwtqk() {
		return jjwtqk;
	}
	public void setJjwtqk(String jjwtqk) {
		this.jjwtqk = jjwtqk;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	@Override
	public String toString() {
		return "Cadres_home [id=" + id + ", gbname=" + gbname + ", rhtime="
				+ rhtime + ", jjwtqk=" + jjwtqk + ", fid=" + fid + "]";
	}
}
