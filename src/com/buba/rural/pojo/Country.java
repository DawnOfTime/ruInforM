package com.buba.rural.pojo;
/**
 * 组织机构（县、乡镇、村）
 * @author john
 *
 */
public class Country {
	private String id;
	private String num;
	private String name;
	private String father_num;
	private String level;
	private int checked;//是否 选中
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFather_num() {
		return father_num;
	}
	public void setFather_num(String father_num) {
		this.father_num = father_num;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public int getChecked() {
		return checked;
	}
	public void setChecked(int checked) {
		this.checked = checked;
	}
	@Override
	public String toString() {
		return "Country [id=" + id + ", num=" + num + ", name=" + name + ", father_num=" + father_num + ", level="
				+ level + ", checked=" + checked + "]";
	}
}
