package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CommunityDao;
import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityCommentParam;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityLikeDto;
import com.camping.bit.dto.CommunityParam;

@Service
public class CommunityServiceImpl implements CommunityService{

	@Autowired
	CommunityDao dao;
	
	// 가입인사 리스트
	@Override
	public List<CommunityDto> helloList(CommunityParam param) {
		
		return dao.helloList(param);
	}
	
	// 가입인사 게시글 총수
	@Override
	public int helloBoardCount(CommunityParam param) {
		
		return dao.helloBoardCount(param);
	}
	
	// dto값을 받아서 dao로 넘겨 : 구체적인 내용
	// 가입인사 글 작성
	@Override
	public void helloWrite(CommunityDto dto) {
		
		dao.helloWrite(dto);
	}
	
	// 게시글 상세보기
	@Override
	public CommunityDto helloDetail(CommunityDto dto) {
		
		CommunityDto data = dao.helloDetail(dto);
		return data;
	}
	
	// 가입인사 글 수정
	@Override
	public void helloUpdate(CommunityDto dto) {
		
		dao.helloUpdate(dto);
	}
	
	// 조회수
	@Override
	public void readCount(int community_seq) {
		
		dao.readCount(community_seq);
	}
	
	// 글 삭제
	@Override
	public void boardDelete(CommunityDto dto) {
		
		dao.boardDelete(dto);
	}
	
	// 좋아요 정보
	@Override
	public int likeCount(int community_seq) {
		
		return dao.likeCount(community_seq);
	}

	// 좋아요 저장
	@Override 
	public void likeUp(CommunityLikeDto dto) {
		
		dao.likeUp(dto);
	}
	
	// 좋아요 취소
	@Override 
	public void likeDown(CommunityLikeDto dto) {
	    
		dao.likeDown(dto);
	}
	
	// 좋아요 확인
    @Override
    public boolean likeCheck(CommunityLikeDto dto) {
        
    	return dao.likeCheck(dto);
    }
	
	// 자유게시판 리스트
	@Override
	public List<CommunityDto> freeList(CommunityParam param) {
		
		return dao.freeList(param);
	}
	
	// 자유게시판 총수
	@Override
	public int freeBoardCount(CommunityParam param) {
		
		return dao.freeBoardCount(param);
	}
	
	// 자유게시판 글 내용 저장
	@Override
	public void freeWrite(CommunityDto dto) {
		
		dao.freeWrite(dto);
	}
	
	// 자유게시글 상세보기
	@Override
	public CommunityDto freeDetail(CommunityDto dto) {
		
		CommunityDto data = dao.freeDetail(dto);
		return data;
	}
	
	// 자유게시판 글 수정
	@Override
	public void freeUpdate(CommunityDto dto) {
		
		dao.freeUpdate(dto);
	}
	
	// 캠퍼모집 리스트
	@Override
	public List<CommunityDto> findList(CommunityParam param) {
		
		return dao.findList(param);
	}
	
	// 캠퍼모집 총수
	@Override
	public int findBoardCount(CommunityParam param) {
		
		return dao.findBoardCount(param);
	}
	
	// 캠퍼모집 글 내용 저장
	@Override
	public void findWrite(CommunityDto dto) {
		
		dao.findWrite(dto);
	}
	
	// 캠퍼모집 상세보기
	@Override
	public CommunityDto findDetail(CommunityDto dto) {
		
		CommunityDto data = dao.findDetail(dto);
		return data;
	}
	
	// 캠퍼모집 글 수정
	@Override
	public void findUpdate(CommunityDto dto) {
		
		dao.findUpdate(dto);
	}
	
	// 중고거래 리스트
	@Override
	public List<CommunityDto> dealList(CommunityParam param) {
		
		return dao.dealList(param);
	}
	
	// 중고거래 게시글 총수
	@Override
	public int dealBoardCount(CommunityParam param) {
		
		return dao.dealBoardCount(param);
	}
	
	// dto값을 받아서 dao로 넘겨 : 구체적인 내용
	// 중고거래 글 작성
	@Override
	public void dealWrite(CommunityDto dto) {
		
		dao.dealWrite(dto);
	}
	
	// 중고거래 상세보기
	@Override
	public CommunityDto dealDetail(CommunityDto dto) {
		
		CommunityDto data = dao.dealDetail(dto);
		return data;
	}
	
	// 중고거래 글 수정
	@Override
	public void dealUpdate(CommunityDto dto) {
		
		dao.dealUpdate(dto);
	}
	
	// 거래완료
	@Override
	public void soldout(int community_seq) {
		
		dao.soldout(community_seq);
	}
	
	// 캠핑후기 리스트
	@Override
	public List<CommunityDto> reviewList(CommunityParam param) {
		
		return dao.reviewList(param);
	}
	
	// 캠핑후기 게시글 총수
	@Override
	public int reviewBoardCount(CommunityParam param) {
		
		return dao.reviewBoardCount(param);
	}
	
	// dto값을 받아서 dao로 넘겨 : 구체적인 내용
	// 캠핑후기 글 작성
	@Override
	public void reviewWrite(CommunityDto dto) {
		
		dao.reviewWrite(dto);
	}
	
	// 캠핑후기 상세보기
	@Override
	public CommunityDto reviewDetail(CommunityDto dto) {
		
		CommunityDto data = dao.reviewDetail(dto);
		return data;
	}
	
	// 캠핑후기 글 수정
	@Override
	public void reviewUpdate(CommunityDto dto) {
		
		dao.reviewUpdate(dto);
	}
	
	// 댓글 리스트
	@Override
	public List<CommunityCommentDto> getCommentList(CommunityCommentParam param) {

		return dao.getCommentList(param);
	}
	
	// 댓글 총합
	@Override
	public int getCommentCount(CommunityCommentParam param) {
		
		return dao.getCommentCount(param);
	}
	
	// 댓글
	@Override
	public int answerComment(CommunityCommentDto comment) {
		
		return dao.answerComment(comment);
	}
	
	// 댓글 작성
	@Override
	public int writeComment(CommunityCommentDto comment) {
		
		return dao.writeComment(comment);
	}
	
	// 댓글 수정
	@Override
	public int updateComment(CommunityCommentDto comment) {
		
		return dao.updateComment(comment);
	}
	
	// 댓글 삭제
	@Override
	public int deleteComment(int comment_seq) {
		
		return dao.deleteComment(comment_seq);
	}
	
}
