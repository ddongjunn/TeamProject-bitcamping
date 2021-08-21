package com.camping.bit.dao;

import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.MypageParam;

import java.util.List;

public interface AdminDao {

    public List<MemberDto> allMemberList(MypageParam param);
    public int memberCountSearch(MypageParam param);

    public int memberCount();
}
