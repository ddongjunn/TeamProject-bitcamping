package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityParam;

public interface CommunityDao {
	
	// 가입인사 게시글 리스트 
	public List<CommunityDto> helloList(CommunityParam param);
	
	// 가입인사 게시글 총수
	int helloListCount(CommunityParam param);
	
	// service같이 함수명만 적어줌 
	public void helloWriteAf(CommunityDto dto);

	// 게시글 상세보기 
	public CommunityDto helloDetail(int community_seq);
	
	// 조회수
	void readcount(int community_seq);
}
