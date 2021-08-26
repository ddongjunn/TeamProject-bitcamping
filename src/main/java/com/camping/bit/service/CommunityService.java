package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityCommentParam;
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
	public void likeDown(CommunityLikeDto dto);

	// 좋아요 확인
	public boolean likeCheck(CommunityLikeDto dto);
	
	// 자유게시판 리스트
	public List<CommunityDto> freeList(CommunityParam param);

	// 자유게시판 총수
	public int freeBoardCount(CommunityParam param);

	// 자유게시판 글 내용 저장
	public void freeWrite(CommunityDto dto);

	// 자유게시판 상세보기
	public CommunityDto freeDetail(CommunityDto dto);

	// 자유게시판 글 수정
	public void freeUpdate(CommunityDto dto);
	
	// 캠퍼모집 리스트
	public List<CommunityDto> findList(CommunityParam param);

	// 캠퍼모집 총수
	public int findBoardCount(CommunityParam param);

	// 캠퍼모집 글 내용 저장
	public void findWrite(CommunityDto dto);

	// 캠퍼모집 상세보기
	public CommunityDto findDetail(CommunityDto dto);

	// 캠퍼모집 글 수정
	public void findUpdate(CommunityDto dto);
	
	// 중고거래 리스트
	public List<CommunityDto> dealList(CommunityParam param);
	
	// 중고거래 총수
	public int dealBoardCount(CommunityParam param);

	// 중고거래 글 내용 저장
	public void dealWrite(CommunityDto dto);
	
	// 중고거래 상세보기
	public CommunityDto dealDetail(CommunityDto dto);
	
	// 중고거래 글 수정
	public void dealUpdate(CommunityDto dto);
	
	// 캠핑후기 리스트
	public List<CommunityDto> reviewList(CommunityParam param);
	
	// 캠핑후기 총수
	public int reviewBoardCount(CommunityParam param);

	// 캠핑후기 글 내용 저장
	public void reviewWrite(CommunityDto dto);
	
	// 캠핑후기 상세보기
	public CommunityDto reviewDetail(CommunityDto dto);
	
	// 캠핑후기 글 수정
	public void reviewUpdate(CommunityDto dto);

	// 댓글 리스트
	public List<CommunityCommentDto> getCommentList(CommunityCommentParam param);

	// 댓글 총수
	public int getCommentCount(CommunityCommentParam param);
	
	// 댓글 작성
	public int writeComment(CommunityCommentDto comment);
	
	// 대댓글 
	public int answerComment(CommunityCommentDto comment);
	
	// 댓글 수정
	public int updateComment(CommunityCommentDto comment);
	
	// 댓글 삭제
	public int deleteComment(int comment_seq);

	// 거래완료
	public void soldout(int community_seq);
}
