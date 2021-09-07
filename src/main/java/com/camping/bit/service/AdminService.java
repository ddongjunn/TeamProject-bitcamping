package com.camping.bit.service;

import com.camping.bit.dto.*;

import java.util.List;
import java.util.Map;

public interface AdminService {

    public List<MemberDto> allMemberList(MypageParam param);
    public int memberCountSearch(MypageParam param);

    public int memberCount();

    public List<CommunityDto> getCommunity(MypageParam param);
    public int getCommunityCount(MypageParam param);

    public int getCommunityTotalCount();
    public int getQnaWaitTotalCount();
    public String getTodaySales();
    public Map<String,Object> weeklySales();

    public Map<String,Object> regiPathCount();

    public List<CommunityDto> recentCommunity();

    public List<CommunityDto> dealList(MypageParam param);
    public int dealCount(MypageParam param);

    public List<CampingBbsDto> campingReviewList(CampingParam param);
    public int campingReviewCount (CampingParam param);

    public List<ProductOrderDto> orderList(MypageParam param);
    public int orderListCount(MypageParam param);
    public ProductOrderDto getOrderInfo(String merchant_Uid);

    public List<ProductQnaDto> productQnaList(CsParam param);
    public int productQnaListCount (CsParam param);

    public List<CsQnaDto> csQnaList(CsParam param);
    public int csQnaListCount(CsParam param);

    public List<CampingListDto> recommendCampingSite();

    public CommunityDto getCommunityDetail(int community_seq);

    public String getCommunityType(int community_seq);

    public void stopMember(String id);
    public void restoreMember(String id);

    public void updateOrderStatus(ProductOrderDto dto);
    public void insertOrderInvoiceNumber(ProductOrderDto dto);

    public Map<String, Integer> getOrderStatus();

}
