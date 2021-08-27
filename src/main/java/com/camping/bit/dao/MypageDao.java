package com.camping.bit.dao;

import com.camping.bit.dto.*;

import java.util.List;

public interface MypageDao {

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
}
