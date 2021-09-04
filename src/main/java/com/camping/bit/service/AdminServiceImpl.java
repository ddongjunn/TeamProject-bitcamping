package com.camping.bit.service;

import com.camping.bit.dao.AdminDao;
import com.camping.bit.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService{

    @Autowired
    AdminDao dao;

    @Override
    public List<MemberDto> allMemberList(MypageParam param) {
        return dao.allMemberList(param);
    }

    @Override
    public int memberCountSearch(MypageParam param) {
        return dao.memberCountSearch(param);
    }

    @Override
    public int memberCount() {
        return dao.memberCount();
    }

    @Override
    public List<CommunityDto> getCommunity(MypageParam param) {
        return dao.getCommunity(param);
    }

    @Override
    public int getCommunityCount(MypageParam param) {
        return dao.getCommunityCount(param);
    }

    @Override
    public int getCommunityTotalCount() {
        return dao.getCommunityTotalCount();
    }

    @Override
    public int getQnaWaitTotalCount() {
        return dao.getQnaWaitTotalCount();
    }

    @Override
    public Map<String, Object> regiPathCount() {
        return dao.regiPathCount();
    }

    @Override
    public List<CommunityDto> recentCommunity() {
        return dao.recentCommunity();
    }

    @Override
    public List<CommunityDto> dealList(MypageParam param) {
        return dao.dealList(param);
    }

    @Override
    public int dealCount(MypageParam param) {
        return dao.dealCount(param);
    }

    @Override
    public List<CampingBbsDto> campingReviewList(CampingParam param) {
        return dao.campingReviewList(param);
    }

    @Override
    public int campingReviewCount(CampingParam param) {
        return dao.campingReviewCount(param);
    }

    @Override
    public List<ProductOrderDto> orderList(MypageParam param) {
        return dao.orderList(param);
    }

    @Override
    public int orderListCount(MypageParam param) {
        return dao.orderListCount(param);
    }

    @Override
    public ProductOrderDto getOrderInfo(String merchant_Uid) {
        return dao.getOrderInfo(merchant_Uid);
    }

    @Override
    public List<ProductQnaDto> productQnaList(CsParam param) {
        return dao.productQnaList(param);
    }

    @Override
    public int productQnaListCount(CsParam param) {
        return dao.productQnaListCount(param);
    }

    @Override
    public List<CsQnaDto> csQnaList(CsParam param) {
        return dao.csQnaList(param);
    }

    @Override
    public int csQnaListCount(CsParam param) {
        return dao.productQnaListCount(param);
    }

    @Override
    public String getTodaySales() {
        return dao.getTodaySales();
    }

    @Override
    public Map<String, Object> weeklySales() {
        return dao.weeklySales();
    }

    @Override
    public List<CampingListDto> recommendCampingSite() {
    	return dao.recommendCampingSite();
    }

    @Override
    public CommunityDto getCommunityDetail(int community_seq) {
        return dao.getCommunityDetail(community_seq);
    }

    @Override
    public String getCommunityType(int community_seq) {
        return dao.getCommunityType(community_seq);
    }

    @Override
    public void stopMember(String id) {
        dao.stopMember(id);
    }

    @Override
    public void restoreMember(String id) {
        dao.restoreMember(id);
    }

    @Override
    public void updateOrderStatus(ProductOrderDto dto) {
        dao.updateOrderStatus(dto);
    }

    @Override
    public void insertOrderInvoiceNumber(ProductOrderDto dto) {
        dao.insertOrderInvoiceNumber(dto);
    }
}
