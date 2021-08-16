package com.camping.bit.service;

import com.camping.bit.dto.CommunityDto;

import java.util.List;

public interface MypageService {

    public List<CommunityDto> getMyCommunity(CommunityDto dto);
}
