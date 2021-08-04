package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CampingDao;
import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;

@Service
public class CampingServiceImpl implements CampingService {

	@Autowired
	CampingDao dao;
	
	@Override //캠핑장 리스트 뿌리기
	public List<CampingListDto> getCampingList(CampingParam param) {
		return dao.getCampingList(param);
	}

	@Override //캠핑장 상세화면 들어가기
	public CampingDetailDto getCampingDetail(int contentid) {
		return dao.getCampingDetail(contentid);
	}

	@Override //캠핑장 갯수 구하기 
	public int getCampingCount(CampingParam param) {
		return dao.getCampingCount(param);
	}
	
	
	
}
