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
	
	private String doNm;
	private String sigunguNm;
	
	private String searchWord;
	
	private String[] searchDo;
	private String[] searchCl;
	private String[] lctCl;
	private String[] induty;
	private String[] resveCl;
	private String eqpmnLendCl;
	private String exprnProgrm;
	private String[] animalCmgCl;
	private String[] sbrsCl;
	private String siteBottomCl1;
	private String siteBottomCl2;
	private String siteBottomCl3;
	private String siteBottomCl4;
	private String siteBottomCl5;
	
	private String choice;
	private String search;
	private String reviewsorting;
	
	private int contentid;
	private String id;
	private String nickname;
	
	public CampingParam() {
		
	}

	public CampingParam(int pageNumber, int start, int end, String sorting, String doNm, String sigunguNm,
			String searchWord, String[] searchDo, String[] searchCl, String[] lctCl, String[] induty, String[] resveCl,
			String eqpmnLendCl, String exprnProgrm, String[] animalCmgCl, String[] sbrsCl, String siteBottomCl1,
			String siteBottomCl2, String siteBottomCl3, String siteBottomCl4, String siteBottomCl5, String choice,
			String search, String reviewsorting, int contentid) {
		super();
		this.pageNumber = pageNumber;
		this.start = start;
		this.end = end;
		this.sorting = sorting;
		this.doNm = doNm;
		this.sigunguNm = sigunguNm;
		this.searchWord = searchWord;
		this.searchDo = searchDo;
		this.searchCl = searchCl;
		this.lctCl = lctCl;
		this.induty = induty;
		this.resveCl = resveCl;
		this.eqpmnLendCl = eqpmnLendCl;
		this.exprnProgrm = exprnProgrm;
		this.animalCmgCl = animalCmgCl;
		this.sbrsCl = sbrsCl;
		this.siteBottomCl1 = siteBottomCl1;
		this.siteBottomCl2 = siteBottomCl2;
		this.siteBottomCl3 = siteBottomCl3;
		this.siteBottomCl4 = siteBottomCl4;
		this.siteBottomCl5 = siteBottomCl5;
		this.choice = choice;
		this.search = search;
		this.reviewsorting = reviewsorting;
		this.contentid = contentid;
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

	public String getDoNm() {
		return doNm;
	}

	public void setDoNm(String doNm) {
		this.doNm = doNm;
	}

	public String getSigunguNm() {
		return sigunguNm;
	}

	public void setSigunguNm(String sigunguNm) {
		this.sigunguNm = sigunguNm;
	}
	
	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
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

	public String getSiteBottomCl1() {
		return siteBottomCl1;
	}

	public void setSiteBottomCl1(String siteBottomCl1) {
		this.siteBottomCl1 = siteBottomCl1;
	}

	public String getSiteBottomCl2() {
		return siteBottomCl2;
	}

	public void setSiteBottomCl2(String siteBottomCl2) {
		this.siteBottomCl2 = siteBottomCl2;
	}

	public String getSiteBottomCl3() {
		return siteBottomCl3;
	}

	public void setSiteBottomCl3(String siteBottomCl3) {
		this.siteBottomCl3 = siteBottomCl3;
	}

	public String getSiteBottomCl4() {
		return siteBottomCl4;
	}

	public void setSiteBottomCl4(String siteBottomCl4) {
		this.siteBottomCl4 = siteBottomCl4;
	}

	public String getSiteBottomCl5() {
		return siteBottomCl5;
	}

	public void setSiteBottomCl5(String siteBottomCl5) {
		this.siteBottomCl5 = siteBottomCl5;
	}

	public String getChoice() {
		return choice;
	}

	public void setChoice(String choice) {
		this.choice = choice;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getReviewsorting() {
		return reviewsorting;
	}

	public void setReviewsorting(String reviewsorting) {
		this.reviewsorting = reviewsorting;
	}

	public int getContentid() {
		return contentid;
	}

	public void setContentid(int contentid) {
		this.contentid = contentid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
