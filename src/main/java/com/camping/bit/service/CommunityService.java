package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityLikeDto;
import com.camping.bit.dto.CommunityParam;

public interface CommunityService {
	
	// 가인인사게시판 리스트
	public List<CommunityDto> helloList(CommunityParam param);
	
	// 가입인사 게시글 총수
	public int helloBoardCount(CommunityParam param);
	
	// 가입인사 dto값을 받아서 dao로 넘겨 : 함수명만
	public void helloWrite(CommunityDto dto);
	
	// 가입인사글 상세보기 
	public CommunityDto helloDetail(CommunityDto dto);
	
	// 조회수
	public void readCount(int community_seq);

	// 글 삭제
	public void boardDelete(CommunityDto dto);

	// 글 수정
	public void helloUpdate(CommunityDto dto);
	
	// 좋아요 정보
	public int likeCount(int community_seq);

	// 좋아요 저장
	public void likeUp(CommunityLikeDto dto);
	
	// 좋아요 취소
	public void deleteLike(CommunityLikeDto dto);

	// 댓글 리스트
	public List<CommunityCommentDto> commentList(int community_seq);
	
	// 댓글 입력
	public void commentWrite(CommunityCommentDto dto);
}
