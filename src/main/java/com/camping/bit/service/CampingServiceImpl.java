package com.camping.bit.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CampingDao;
import com.camping.bit.dto.CampingBbsDto;
import com.camping.bit.dto.CampingCommentDto;
import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingLikeDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;

@Service
public class CampingServiceImpl implements CampingService {

	@Autowired
	CampingDao dao;
	
	@Override //캠핑장 리스트 뿌리기
	public List<CampingListDto> getCampingList(CampingParam param) {
		return dao.getCampingList(param);
	}

	@Override //캠핑장 상세화면 들어가기
	public CampingDetailDto getCampingDetail(int contentid) {
		dao.getCampingReadcount(contentid);
		return dao.getCampingDetail(contentid);
	}
	
	@Override //캠핑장 디테일용 리스트 가져오기
	public CampingListDto getCampingListForDetail(int contentid) {
		return dao.getCampingListForDetail(contentid);
	}

	@Override //캠핑장 갯수 구하기 
	public int getCampingCount(CampingParam param) {
		return dao.getCampingCount(param);
	}
	
	//캠핑장 검색 결과 개수 구하기
	public int getCampingSearchCount(CampingParam param) {
		return dao.getCampingSearchCount(param);
	}

	@Override //캠핑장 클릭시 조회수 증가
	public int getCampingReadcount(int contentid) {
		return dao.getCampingReadcount(contentid);
	}

	@Override //캠핑장 세부 사진 가져오기
	public List<CampingImageDto> getCampingImage(int contentid) {
		return dao.getCampingImage(contentid);
	}

	@Override //캠핑장 intro 가져오기
	public String getCampingIntro(int contentid) {
		return dao.getCampingIntro(contentid);
	}

	@Override //캠핑장 자동검색어
	public List<CampingListDto> autoSearch(String searchWord) {
		return dao.autoSearch(searchWord);
	}

	@Override //캠핑장 리뷰 가져오기
	public List<CampingBbsDto> getcampingreview(CampingParam param) {
		return dao.getcampingreview(param);
	}
	
	@Override //캠핑장 리뷰 갯수 세기
	public int getCampingReviewCount(int contentid) {
		return dao.getCampingReviewCount(contentid);
	}
	
	@Override //캠핑장 리뷰 더보기 가져오기
	public List<Map<String, Object>> campingMoreList(Map<String, Object> map) {
		return dao.campingMoreList(map);
	}

	@Override //캠핑장 리뷰 상세화면
	public CampingBbsDto campingdetailreview(CampingBbsDto cbsdto) {
		dao.getCampingReviewReadcount(cbsdto.getReview_seq());
		return dao.campingdetailreview(cbsdto);
	}
	
	@Override //캠핑장 리뷰 작성하기(후처리)
	public void campingwritereviewAf(CampingBbsDto cbsdto) {
		dao.campingwritereviewAf(cbsdto);
	}

	@Override //캠핑장 리뷰 조회수 
	public int getCampingReviewReadcount(int review_seq) {
		return dao.getCampingReviewReadcount(review_seq);
	}

	@Override //캠핑장 리뷰 수정하기(후처리)
	public void campingupdatereviewAf(CampingBbsDto cbsdto) {
		dao.campingupdatereviewAf(cbsdto);
	}

	@Override //캠핑장 리뷰 삭제하기
	public boolean campingdeletereview(int review_seq) {
		return dao.campingdeletereview(review_seq);
	}

	@Override //캠핑장 리뷰 검색하기
	public List<CampingBbsDto> campingSearchReview(CampingParam param) {
		return dao.campingSearchReview(param);
	}

	@Override //캠핑장 좋아요 뿌리기 
	public Map<String, Object> getCampingLike(Map<String, Object> contentidMap) {
	return dao.getCampingLike(contentidMap); 
	}
	
	@Override //좋아요 어쩌고 하기 위해 likecount검사하는 용
	public Map<String, Object> getCampingLikeInfo(int contentid) {
		return dao.getCampingLikeInfo(contentid);
	}
	
	@Override //캠핑장 좋아요 증가시키기
	public boolean plusCampingHeart(CampingLikeDto clike) {
		dao.plusCampingLikecount(clike.getContentid());
		return dao.plusCampingHeart(clike);
	}

	@Override //캠핑장 좋아요 감소시키기
	public boolean minusCampingHeart(CampingLikeDto clike) {
		dao.minusCampingLikecount(clike.getContentid());
		return dao.minusCampingHeart(clike);
	}

	@Override //캠핑장 좋아요 수 늘리기
	public void plusCampingLikecount(int contentid) {
		dao.plusCampingLikecount(contentid);
	}

	@Override //캠핑장 좋아요 수 줄이기
	public void minusCampingLikecount(int contentid) {
		dao.minusCampingLikecount(contentid);
	}
	
	@Override //캠핑장 좋아요 수 개수(likecount)
	public int getCampingLikecount(int contentid) {
		return dao.getCampingLikecount(contentid);
	}
	
	@Override //캠핑장 리뷰에 달린 댓글 뿌리기 
	public List<CampingCommentDto> getCampingReviewComment(CampingParam param) {
		return dao.getCampingReviewComment(param);
	}
	
	@Override //캠핑장 리뷰에 댓글 쓸때마다 갯수 증가시키기
	public void plusCommentCount(int review_seq) {
		dao.plusCommentCount(review_seq);
		
	}
	
	@Override //캠핑장 리뷰에 댓글 삭제하면 갯수 감소시키기
	public void minusCommentCount(int review_seq) {
		dao.minusCommentCount(review_seq);
		
	}
	
	@Override //캠핑장 리뷰 댓글 갯수세기
	public int getCampingReviewCommentCount(int review_seq) {
		return dao.getCampingReviewCommentCount(review_seq);
	}


	@Override //캠핑장 리뷰에 댓글 달기 
	public Boolean campingWriteComment(CampingCommentDto cc) {
		dao.plusCommentCount(cc.getReview_seq());
		return dao.campingWriteComment(cc);
	}

	@Override //캠핑장 리뷰에 댓글 삭제하기
	public Boolean campingDeleteComment(CampingCommentDto cc) {
		dao.minusCommentCount(cc.getReview_seq());
		return dao.campingDeleteComment(cc);
	}

	@Override //캠핑장 리뷰에 댓글 수정하기
	public Boolean campingUpdateComment(CampingCommentDto cc) {
		return dao.campingUpdateComment(cc);
	}

	@Override
	public List<CampingListDto> campingMainSearch(CampingParam param) {
		return dao.campingMainSearch(param);
	}

	@Override //캠핑장 리뷰 도움이 됐어요 likecount 가져오는 용
	public Map<String, Object> getCampingHelpInfo(int review_seq) {
		return dao.getCampingHelpInfo(review_seq);
	}

	@Override //해당 사용자가 도움이 됐어요 눌렀는지 아닌지 확인하는 용
	public Map<String, Object> getCampingHelp(Map<String, Object> reviewseqMap) {
		return dao.getCampingHelp(reviewseqMap);
	}

	@Override //캠핑장 도움이 됐어요 증가시키기
	public boolean plusCampingHelp(CampingLikeDto clike) {
		dao.plusCampingHelpcount(clike.getReview_seq());
		return dao.plusCampingHelp(clike);
	}

	@Override //캠핑장 도움 수 증가
	public void plusCampingHelpcount(int contentid) {
		dao.plusCampingHelpcount(contentid);
	}

	@Override //캠핑장 도움 수 세기 
	public int getCampingHelpcount(int reivew_seq) {
		return dao.getCampingHelpcount(reivew_seq);
	}

	@Override //캠핑장 리뷰 수 세기
	public int getCampingSearchReviewCount(CampingParam param) {
		return dao.getCampingSearchReviewCount(param);
	}

}
