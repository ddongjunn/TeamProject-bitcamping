package com.camping.bit.service;

import com.camping.bit.dao.MypageDao;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MypageParam;
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
}
