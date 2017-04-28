package com.buba.rural.pojo;

public class Family_vehicle {
	private String id;
	private String car_type;
	private String car_brand;
	private Float car_price;
	private String car_getMode;
	private String car_license_plate;
	private String fid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCar_type() {
		return car_type;
	}
	public void setCar_type(String car_type) {
		this.car_type = car_type;
	}
	public String getCar_brand() {
		return car_brand;
	}
	public void setCar_brand(String car_brand) {
		this.car_brand = car_brand;
	}
	public Float getCar_price() {
		return car_price;
	}
	public void setCar_price(Float car_price) {
		this.car_price = car_price;
	}
	public String getCar_getMode() {
		return car_getMode;
	}
	public void setCar_getMode(String car_getMode) {
		this.car_getMode = car_getMode;
	}
	public String getCar_license_plate() {
		return car_license_plate;
	}
	public void setCar_license_plate(String car_license_plate) {
		this.car_license_plate = car_license_plate;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	@Override
	public String toString() {
		return "Family_vehicle [id=" + id + ", car_type=" + car_type
				+ ", car_brand=" + car_brand + ", car_price=" + car_price
				+ ", car_getMode=" + car_getMode + ", car_license_plate="
				+ car_license_plate + ", fid=" + fid + "]";
	}
}
