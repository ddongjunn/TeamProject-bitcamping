package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityParam;

public interface CommunityService {
	
	// 가인인사게시판 리스트
	public List<CommunityDto> helloList(CommunityParam param);
	
	// 가입인사 게시글 총수
	int helloBoardCount(CommunityParam param);
	
	// 가입인사 dto값을 받아서 dao로 넘겨 : 함수명만
	public void helloWrite(CommunityDto dto);
	
	// 가입인사글 상세보기 
	public CommunityDto helloDetail(int community_seq);
	
	// 조회수
	void readCount(int community_seq);

	// 글 삭제
	public void boardDelete(CommunityDto dto);

	// 글 수정
	public void helloUpdate(CommunityDto dto);
	
	// 댓글 리스트
	public List<CommunityCommentDto> commentList(int community_seq);
	
	// 댓글 입력
	public void commentWrite(CommunityCommentDto dto);
}
