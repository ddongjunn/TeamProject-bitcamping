package com.camping.bit.service;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MypageParam;

import java.util.List;

public interface MypageService {

    public List<CommunityDto> getMyCommunity(MypageParam param);
    public int getMyCommunityCount(MypageParam param);
}
