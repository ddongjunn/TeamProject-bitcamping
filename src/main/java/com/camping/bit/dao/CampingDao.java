package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingListDto;

public interface CampingDao {

	//캠핑 전체 리스트 뿌리기
	public List<CampingListDto> getCampingList(CampingListDto dto);
	
	//캠핑장 별 디테일 화면 
	public CampingDetailDto getCampingDetail(int contentid);

}
