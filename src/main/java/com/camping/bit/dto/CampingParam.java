package com.camping.bit.dto;

import java.io.Serializable;

public class CampingParam implements Serializable{
	
	private int pageNumber;
	private int start;
	private int end;
	private String sorting;
	
	public CampingParam() {
		
	}

	public CampingParam(int pageNumber, int start, int end, String sorting) {
		super();
		this.pageNumber = pageNumber;
		this.start = start;
		this.end = end;
		this.sorting = sorting;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}
	
	public String getSorting() {
		return sorting;
	}

	public void setSorting(String sorting) {
		this.sorting = sorting;
	}

	@Override
	public String toString() {
		return "CampingParam [pageNumber=" + pageNumber + ", start=" + start + ", end=" + end + ", sorting=" + sorting
				+ "]";
	}
}
