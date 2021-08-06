package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;

public interface CampingDao {

	//캠핑 전체 리스트 뿌리기
	public List<CampingListDto> getCampingList(CampingParam param);
	
	//캠핑장 별 디테일 화면 
	public CampingDetailDto getCampingDetail(int contentid);

	//캠핑장 총 갯수
	public int getCampingCount(CampingParam param);

}
