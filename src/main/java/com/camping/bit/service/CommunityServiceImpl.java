package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CommunityDao;
import com.camping.bit.dto.CommunityDto;

@Service
public class CommunityServiceImpl implements CommunityService{

	@Autowired
	CommunityDao dao;
	
	@Override
	public List<CommunityDto> helloboardlist() {
		return dao.helloboardlist();
	}
	
	// dto값을 받아서 dao로 넘겨 : 구체적인 내용
	@Override
	public void boardwriteAf(CommunityDto dto) {
		dao.boardwriteAf(dto);
	}
	
	// 게시글 상세보기
	@Override
	public int boardDetail(int community_seq) {
		return dao.boardDetail(community_seq);
	}
}
