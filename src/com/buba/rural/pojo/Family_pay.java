package com.buba.rural.pojo;

public class Family_pay {
	private String id;
	private Float shkz;
	private Float ylkz;
	private Float jykz;
	private Float zfkz;
	private Float jtkz;
	private Float qtkz;
	private String fid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Float getShkz() {
		return shkz;
	}
	public void setShkz(Float shkz) {
		this.shkz = shkz;
	}
	public Float getYlkz() {
		return ylkz;
	}
	public void setYlkz(Float ylkz) {
		this.ylkz = ylkz;
	}
	public Float getJykz() {
		return jykz;
	}
	public void setJykz(Float jykz) {
		this.jykz = jykz;
	}
	public Float getZfkz() {
		return zfkz;
	}
	public void setZfkz(Float zfkz) {
		this.zfkz = zfkz;
	}
	public Float getJtkz() {
		return jtkz;
	}
	public void setJtkz(Float jtkz) {
		this.jtkz = jtkz;
	}
	public Float getQtkz() {
		return qtkz;
	}
	public void setQtkz(Float qtkz) {
		this.qtkz = qtkz;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	@Override
	public String toString() {
		return "Family_pay [id=" + id + ", shkz=" + shkz + ", ylkz=" + ylkz
				+ ", jykz=" + jykz + ", zfkz=" + zfkz + ", jtkz=" + jtkz
				+ ", qtkz=" + qtkz + ", fid=" + fid + "]";
	}
}
