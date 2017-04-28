package com.buba.rural.pojo;

import java.util.Arrays;

public class Menu {
	private String id;
	private String num;
	private String name;
	private String father_num;
	private String level;
	private String menuurl;
	private int checked;
	private String [] children;
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
	public String getMenuurl() {
		return menuurl;
	}
	public void setMenuurl(String menuurl) {
		this.menuurl = menuurl;
	}
	public int getChecked() {
		return checked;
	}
	public void setChecked(int checked) {
		this.checked = checked;
	}
	public String[] getChildren() {
		return children;
	}
	public void setChildren(String[] children) {
		this.children = children;
	}
	@Override
	public String toString() {
		return "Menu [id=" + id + ", num=" + num + ", name=" + name
				+ ", father_num=" + father_num + ", level=" + level
				+ ", menuurl=" + menuurl + ", checked=" + checked
				+ ", children=" + Arrays.toString(children) + "]";
	}
}
