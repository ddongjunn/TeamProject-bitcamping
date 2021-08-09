package com.camping.bit.dto;

import java.io.Serializable;
import java.util.Arrays;

public class CampingParam implements Serializable{
	
	private int pageNumber;
	private int start;
	private int end;
	private String sorting;
	private String[] searchDo;
	
	public CampingParam() {
		
	}

	public CampingParam(int pageNumber, int start, int end, String sorting, String[] searchDo) {
		super();
		this.pageNumber = pageNumber;
		this.start = start;
		this.end = end;
		this.sorting = sorting;
		this.searchDo = searchDo;
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

	public String[] getSearchDo() {
		return searchDo;
	}

	public void setSearchDo(String[] searchDo) {
		this.searchDo = searchDo;
	}

	@Override
	public String toString() {
		return "CampingParam [pageNumber=" + pageNumber + ", start=" + start + ", end=" + end + ", sorting=" + sorting
				+ ", searchDo=" + Arrays.toString(searchDo) + "]";
	}

}
