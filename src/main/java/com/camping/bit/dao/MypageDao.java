package com.camping.bit.dao;

import com.camping.bit.dto.CommunityDto;

import java.util.List;

public interface MypageDao {

    public List<CommunityDto> getMyCommunity(CommunityDto dto);
}
