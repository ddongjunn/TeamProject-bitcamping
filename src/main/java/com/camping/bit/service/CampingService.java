package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;

public interface CampingService {

	//캠핑장 전체 리스트
	public List<CampingListDto> getCampingList(CampingParam param);
	
	//각 캠핑장별 상세 화면
	public CampingDetailDto getCampingDetail(int contentid);
	
	//캠핑장 디테일용 리스트 가져오기
	public CampingListDto getCampingListForDetail(int contentid);
	
	//캠핑장 갯수 구하기 
	public int getCampingCount(CampingParam param);
	
	//캠핑장 클릭 조회수 증가
	public int getCampingReadcount(int contentid);
	
	//캠핑장 세부 사진 가져오기
	public List<CampingImageDto> getCampingImage(int contentid);
	
	//캠핑장 intro 가져오기
	public String getCampingIntro(int contentid);
	
	//캠핑장 자동검색어 만들기
	public List<CampingListDto> autoSearch(String searchWord);
	
}
