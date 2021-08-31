package com.camping.bit.service;

import com.camping.bit.dao.MypageDao;
import com.camping.bit.dto.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageServieImpl implements  MypageService{

    @Autowired
    MypageDao dao;

    @Override
    public List<CommunityDto> getMyCommunity(MypageParam param) {
        return dao.getMyCommunity(param);
    }

    @Override
    public int getMyCommunityCount(MypageParam param) {
        return dao.getMyCommunityCount(param);
    }

    @Override
    public void modifyInfo(MemberDto dto) {
        dao.modifyInfo(dto);
    }

    @Override
    public String getPassword(String id) {
        return dao.getPassword(id);
    }

    @Override
    public void withdrawal(String id) {
        dao.withdrawal(id);
    }
    
	@Override
	public List<ProductOrderDto> getMyOrderList(MypageParam param) {
		
		return dao.getMyOrderList(param);
	}

	@Override
	public int getMyOrderCount(MypageParam param) {
		
		return dao.getMyOrderCount(param);
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
    public List<ProductReviewDto> productReview(MypageParam param) {
        return dao.productReview(param);
    }

    @Override
    public int productReviewCount(MypageParam param) {
        return dao.productReviewCount(param);
    }

    @Override
    public List<ProductQnaDto> productQna(MypageParam param) {
        return dao.productQna(param);
    }

    @Override
    public int productQnaCount(MypageParam param) {
        return dao.productQnaCount(param);
    }

    @Override
    public List<CsQnaDto> csQna(MypageParam param) {
        return dao.csQna(param);
    }

    @Override
    public int csQnaCount(MypageParam param) {
        return dao.csQnaCount(param);
    }

}
