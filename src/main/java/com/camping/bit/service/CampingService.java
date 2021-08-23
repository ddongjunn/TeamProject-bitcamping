package com.camping.bit.service;

import java.util.List;
import java.util.Map;

import com.camping.bit.dto.CampingBbsDto;
import com.camping.bit.dto.CampingCommentDto;
import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingLikeDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;

public interface CampingService {

	//캠핑장 전체 리스트
	public List<CampingListDto> getCampingList(CampingParam param);
	
	//각 캠핑장별 상세 화면
	public CampingDetailDto getCampingDetail(int contentid);
	
	//캠핑장 디테일용 리스트 가져오기
	public CampingListDto getCampingListForDetail(int contentid);
	
	//캠핑장 갯수 구하기 
	public int getCampingCount(CampingParam param);
	
	//캠핑장 클릭 조회수 증가
	public int getCampingReadcount(int contentid);
	
	//캠핑장 세부 사진 가져오기
	public List<CampingImageDto> getCampingImage(int contentid);
	
	//캠핑장 intro 가져오기
	public String getCampingIntro(int contentid);
	
	//캠핑장 자동검색어 만들기
	public List<CampingListDto> autoSearch(String searchWord);
	
	//캠핑장 리뷰 리스트 가져오기
	public List<CampingBbsDto> campingreview(int contentid);
	
	//캠핑디테일 리뷰 상세화면
	public CampingBbsDto campingdetailreview(CampingBbsDto cbsdto);

	//캠핑장 리뷰 작성하기(후처리)
	public void campingwritereviewAf(CampingBbsDto cbsdto);
	
	//캠핑장 리뷰 조회수 
	public int getCampingReviewReadcount(int review_seq);
	
	//캠핑장 리뷰 수정하기(후처리)
	public void campingupdatereviewAf(CampingBbsDto cbsdto);
	
	//캠핑장 리뷰 삭제하기
	public boolean campingdeletereview(int review_seq);
	
	//캠핑장 리뷰 검색하기
	public List<CampingBbsDto> campingSearchReview(CampingParam param);
	
	//캠핑장 좋아요 뿌리기 
	public Map<String, Object> getCampingLike(Map<String, Object> contentidMap);
	
	//좋아요 어쩌고 하기 위해 likecount검사하는 용
	public Map<String, Object> getCampingLikeInfo(int contentid);
	
	//캠핑장 좋아요 증가시키기
	public boolean plusCampingHeart(CampingLikeDto clike);
	
	//캠핑장 좋아요 감소시키기
	public boolean minusCampingHeart(CampingLikeDto clike);
	
	//캠핑장 좋아요 늘리기
	public void plusCampingLikecount(int contentid);
		
	//캠핑장 좋아요 줄이기
	public void minusCampingLikecount(int contentid);
	
	//캠핑장 좋아요 수 증감(likecount)
	public int getCampingLikecount(int contentid);
	
	//캠핑장 리뷰 보여주기
	public List<CampingCommentDto> campingShowComment(int review_seq);
	
	//캠핑장 리뷰 댓글달기
	public Boolean campingWriteComment(CampingCommentDto cc);
	
	//캠핑장 리뷰 삭제하기
	public Boolean campingDeleteComment(int comment_seq);
	
	//캠핑장 리뷰 댓글 수정하기
	public Boolean campingUpdateComment(CampingCommentDto cc);
	
	
}
