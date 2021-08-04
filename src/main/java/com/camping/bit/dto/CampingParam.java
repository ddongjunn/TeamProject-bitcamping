package com.camping.bit.dto;

import java.io.Serializable;

public class CampingParam implements Serializable{
	
	private int pageNumber;
	private int start;
	private int end;
	
	public CampingParam() {
		
	}

	public CampingParam(int pageNumber, int start, int end) {
		super();
		this.pageNumber = pageNumber;
		this.start = start;
		this.end = end;
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

	@Override
	public String toString() {
		return "CampingParam [pageNumber=" + pageNumber + ", start=" + start + ", end=" + end + "]";
	}

}
