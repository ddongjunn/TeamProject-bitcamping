package com.camping.bit.service;

import com.camping.bit.dao.AdminDao;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.MypageParam;
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


}
