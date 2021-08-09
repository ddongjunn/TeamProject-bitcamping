package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CommunityDto;

public interface CommunityService {
	
	// 가인인사게시판 리스트
	public List<CommunityDto> helloboardlist();

	// dto값을 받아서 dao로 넘겨 : 함수명만
	public void boardwriteAf(CommunityDto dto);
	
	// 게시글 상세보기 
	public int boardDetail(int community_seq);
	
}
