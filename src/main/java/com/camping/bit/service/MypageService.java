package com.camping.bit.service;

import com.camping.bit.dto.*;

import java.util.List;

public interface MypageService {

    public List<CommunityDto> getMyCommunity(MypageParam param);
    public int getMyCommunityCount(MypageParam param);

    public void modifyInfo(MemberDto dto);

    public String getPassword(String id);

    public void withdrawal(String id);
    
	public List<ProductOrderDto> getMyOrderList(MypageParam param);
	public int getMyOrderCount(MypageParam param);

    public List<CommunityDto> dealList(MypageParam param);
    public int dealCount(MypageParam param);

    public List<CampingBbsDto> campingReviewList(CampingParam param);
    public int campingReviewCount (CampingParam param);

    public List<ProductReviewDto> productReview(MypageParam param);
    public int productReviewCount(MypageParam param);

    public List<ProductQnaDto> productQna(MypageParam param);
    public int productQnaCount(MypageParam param);

    public List<CsQnaDto> csQna(MypageParam param);
    public int csQnaCount(MypageParam param);

    public ProductReviewDto getProductReview(int review_Seq);
    public void updateProductReview(ProductReviewDto dto);
    public void deleteProductReview(int review_Seq);
    
	public int getMyPostCount(MypageParam param);
	public int getMyCommentCount(MypageParam param);
	public int getMyorderStatus(MypageParam param);
	public List<CommunityDto> getMyAllCommunity(MypageParam param);
	public List<CsQnaDto> getMyAllQna(MypageParam param);

}
