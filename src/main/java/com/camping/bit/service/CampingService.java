package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingListDto;

public interface CampingService {

	//캠핑장 전체 리스트
	public List<CampingListDto> getCampingList(CampingListDto dto);
	
	//각 캠핑장별 상세 화면
	public CampingDetailDto getCampingDetail(int contentid);
}
