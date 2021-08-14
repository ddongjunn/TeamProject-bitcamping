package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CommunityDao;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityParam;

@Service
public class CommunityServiceImpl implements CommunityService{

	@Autowired
	CommunityDao dao;
	
	@Override
	public List<CommunityDto> helloList(CommunityParam param) {
		return dao.helloList(param);
	}
	
	// 게시글 총수
	@Override
	public int helloBoardCount(CommunityParam param) {
		return dao.helloBoardCount(param);
	}
	
	// dto값을 받아서 dao로 넘겨 : 구체적인 내용
	@Override
	public void helloWrite(CommunityDto dto) {
		dao.helloWrite(dto);
	}
	
	// 게시글 상세보기
	@Override
	public CommunityDto helloDetail(int community_seq) {
		CommunityDto data = dao.helloDetail(community_seq);
		
		return data;
	}
	
	// 조회수
	@Override
	public void readcount(int community_seq) {
		dao.readcount(community_seq);
	}
	
	// 글 삭제
	@Override
	public void boardDelete(CommunityDto dto) {
		dao.boardDelete(dto);
	}
	
	// 글 수정
	@Override
	public void helloUpdate(CommunityDto dto) {
		dao.helloUpdate(dto);
	}
}
