package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CampingDao;
import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingListDto;

@Service
public class CampingServiceImpl implements CampingService {

	@Autowired
	CampingDao dao;
	
	@Override //캠핑장 리스트 뿌리기
	public List<CampingListDto> getCampingList(CampingListDto dto) {
		return dao.getCampingList(dto);
	}

	@Override
	public CampingDetailDto getCampingDetail(int contentid) {
		return dao.getCampingDetail(contentid);
	}
	
}
