package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityParam;

public interface CommunityService {
	
	// 가인인사게시판 리스트
	public List<CommunityDto> helloList(CommunityParam param);
	
	// 가입인사 게시글 총수
	int helloListCount(CommunityParam param);
	
	// 가입인사 dto값을 받아서 dao로 넘겨 : 함수명만
	public void helloWriteAf(CommunityDto dto);
	
	// 가입인사글 상세보기 
	public CommunityDto helloDetail(int community_seq);
	
	// 조회수
	void readcount(int community_seq);
}
