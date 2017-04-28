package com.buba.rural.pojo;


import java.util.List;

public class PageBean {
	private int pagecode;//当前页码
	private int totalpage;//总页数
	private int totalrecord;//总记录数
	private int pagesize=15;//每页记录数(默认每页显示30条记录)
	private List beanList;//当前页的数据
	private int pageindex;//当前记录的索引
	private String url;
	
	public int getPagecode() {
		return pagecode;
	}
	public void setPagecode(int pagecode) {
		this.pagecode = pagecode;
	}
	public int getTotalpage() {
		totalpage = (totalrecord%pagesize==0)?(totalrecord/pagesize):((totalrecord/pagesize)+1);
		return totalpage;
	}
	public void setTotalpage(int totalpage) {
		this.totalpage = totalpage;
	}
	public int getTotalrecord() {
		return totalrecord;
	}
	public void setTotalrecord(int totalrecord) {
		this.totalrecord = totalrecord;
	}
	public int getPagesize() {
		return pagesize;
	}
	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}
	public List getBeanList() {
		return beanList;
	}
	public void setBeanList(List beanList) {
		this.beanList = beanList;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getPageindex() {
		return pageindex;
	}
	public void setPageindex(int pageindex) {
		this.pageindex = pageindex;
	}
	@Override
	public String toString() {
		return "PageBean [pagecode=" + pagecode + ", totalpage=" + totalpage
				+ ", totalrecord=" + totalrecord + ", pagesize=" + pagesize
				+ ", beanList=" + beanList + ", pageindex=" + pageindex
				+ ", url=" + url + "]";
	}
	public PageBean(int pagecode, int totalpage, int totalrecord, int pagesize,
			List beanList, int pageindex, String url) {
		super();
		this.pagecode = pagecode;
		this.totalpage = totalpage;
		this.totalrecord = totalrecord;
		this.pagesize = pagesize;
		this.beanList = beanList;
		this.pageindex = pageindex;
		this.url = url;
	}
	public PageBean() {
		super();
	}
	
}
