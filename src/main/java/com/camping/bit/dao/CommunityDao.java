package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.CommunityDto;

public interface CommunityDao {
	
	// 가입인사 게시글 리스트 
	public List<CommunityDto> helloboardlist();
	
	// service같이 함수명만 적어줌 
	public void boardwriteAf(CommunityDto dto);

	// 게시글 상세보기 
	public int boardDetail(int community_seq);
}
