package com.camping.bit.dao;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.MypageParam;

import java.util.List;

public interface MypageDao {

    public List<CommunityDto> getMyCommunity(MypageParam param);

    public int getMyCommunityCount(MypageParam param);

    public void modifyInfo(MemberDto dto);

    public String getPassword(String id);

    public void withdrawal(String id);
}
