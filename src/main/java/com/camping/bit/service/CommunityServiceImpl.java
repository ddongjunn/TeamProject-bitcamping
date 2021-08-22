package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CommunityDao;
import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityLikeDto;
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
	public CommunityDto helloDetail(CommunityDto dto) {
		CommunityDto data = dao.helloDetail(dto);
		
		return data;
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
	
	// 글 수정
	@Override
	public void helloUpdate(CommunityDto dto) {
		dao.helloUpdate(dto);
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

	//좋아요 확인
	@Override
	public boolean likeCheck(CommunityLikeDto dto) {
		return dao.likeCheck(dto);
	}

	// 댓글 리스트
	@Override
	public List<CommunityCommentDto> commentList(int community_seq) {
		return dao.commentList(community_seq);
	}
	
	// 댓글 입력
	@Override
	public void commentWrite(CommunityCommentDto dto) {
		dao.commentWrite(dto);
	}
}
