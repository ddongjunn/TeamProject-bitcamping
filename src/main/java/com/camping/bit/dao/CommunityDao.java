package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityParam;

public interface CommunityDao {
	
	// 가입인사 게시글 리스트 
	public List<CommunityDto> helloList(CommunityParam param);
	
	// 게시글 총수
	int helloBoardCount(CommunityParam param);
	
	// service같이 함수명만 적어줌 
	public void helloWrite(CommunityDto dto);

	// 게시글 상세보기 
	public CommunityDto helloDetail(int community_seq);
	
	// 조회수
	public void readCount(int community_seq);
	
	// 글 삭제
	public void boardDelete(CommunityDto dto);
	
	// 글 수정
	public void helloUpdate(CommunityDto dto);
	
	// 댓글 리스트
	public List<CommunityCommentDto> commentList(int community_seq);
	
	// 댓글 입력
	public void commentWrite(CommunityCommentDto dto);
}
