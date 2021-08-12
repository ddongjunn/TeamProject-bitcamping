package com.camping.bit.dto;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;

import org.springframework.web.util.UriComponentsBuilder;

public class CampingParam implements Serializable{
	
	private int pageNumber;

	private int start;
	private int end;
	
	private String sorting;
	
	private String[] searchDo;
	private String[] searchCl;
	private String[] lctCl;
	private String[] induty;
	private String[] resveCl;
	private String eqpmnLendCl;
	private String exprnProgrm;
	private String[] animalCmgCl;
	private String[] sbrsCl;
	
	public CampingParam() {
		
	}


	public CampingParam(int pageNumber, int start, int end, String sorting, String[] searchDo, String[] searchCl,
			String[] lctCl, String[] induty, String[] resveCl, String eqpmnLendCl, String exprnProgrm,
			String[] animalCmgCl, String[] sbrsCl) {
		super();
		this.pageNumber = pageNumber;
		this.start = start;
		this.end = end;
		this.sorting = sorting;
		this.searchDo = searchDo;
		this.searchCl = searchCl;
		this.lctCl = lctCl;
		this.induty = induty;
		this.resveCl = resveCl;
		this.eqpmnLendCl = eqpmnLendCl;
		this.exprnProgrm = exprnProgrm;
		this.animalCmgCl = animalCmgCl;
		this.sbrsCl = sbrsCl;
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

	public String[] getSearchCl() {
		return searchCl;
	}

	public void setSearchCl(String[] searchCl) {
		this.searchCl = searchCl;
	}

	public String[] getLctCl() {
		return lctCl;
	}

	public void setLctCl(String[] lctCl) {
		this.lctCl = lctCl;
	}


	public String[] getInduty() {
		return induty;
	}


	public void setInduty(String[] induty) {
		this.induty = induty;
	}


	public String[] getResveCl() {
		return resveCl;
	}


	public void setResveCl(String[] resveCl) {
		this.resveCl = resveCl;
	}


	public String getEqpmnLendCl() {
		return eqpmnLendCl;
	}


	public void setEqpmnLendCl(String eqpmnLendCl) {
		this.eqpmnLendCl = eqpmnLendCl;
	}


	public String getExprnProgrm() {
		return exprnProgrm;
	}


	public void setExprnProgrm(String exprnProgrm) {
		this.exprnProgrm = exprnProgrm;
	}


	public String[] getAnimalCmgCl() {
		return animalCmgCl;
	}


	public void setAnimalCmgCl(String[] animalCmgCl) {
		this.animalCmgCl = animalCmgCl;
	}


	public String[] getSbrsCl() {
		return sbrsCl;
	}


	public void setSbrsCl(String[] sbrsCl) {
		this.sbrsCl = sbrsCl;
	}
}
