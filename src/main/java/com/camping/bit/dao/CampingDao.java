package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;

public interface CampingDao {

	//캠핑 전체 리스트 뿌리기
	public List<CampingListDto> getCampingList(CampingParam param);
	
	//캠핑장 별 디테일 화면 
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

}
