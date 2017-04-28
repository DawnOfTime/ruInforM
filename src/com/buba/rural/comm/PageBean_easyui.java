package com.buba.rural.comm;

import java.util.List;

public class PageBean_easyui {
	private int pagecode;//当前页码
	private int totalpage;//总页数
	private int totalrecord;//总记录数
	private int pagesize;//每页记录数
	private List beanList;//查到的数据
	private String url;
	private int startNum;//开始行
	private int endNum;//结束行
	public int getPagesize() {
		return pagesize;
	}
	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}
	public int getPagecode() {
		return pagecode;
	}
	public void setPagecode(int pagecode) {
		this.pagecode = pagecode;
	}
	public int getTotalpage() {
		totalpage=(totalrecord%pagesize==0)?(totalrecord/pagesize):((totalrecord/pagesize)+1);
		return totalpage;
	}
	public int getTotalrecord() {
		return totalrecord;
	}
	public void setTotalrecord(int totalrecord) {
		this.totalrecord = totalrecord;
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
	public int getStartNum() {
		startNum = (pagecode-1)*pagesize;
		return startNum;
	}
	public int getEndNum() {
		endNum = (pagecode-1)*pagesize+pagesize;
		return endNum;
	}
	@Override
	public String toString() {
		return "PageBean [pagecode=" + pagecode + ", totalpage=" + totalpage
				+ ", totalrecord=" + totalrecord + ", pagesize=" + pagesize
				+ ", beanList=" + beanList + ", url=" + url + ", startNum="
				+ startNum + ", endNum=" + endNum + "]";
	}
}