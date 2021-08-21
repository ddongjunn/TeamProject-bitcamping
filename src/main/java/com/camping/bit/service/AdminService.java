package com.camping.bit.service;

import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.MypageParam;

import java.util.List;

public interface AdminService {

    public List<MemberDto> allMemberList(MypageParam param);
    public int memberCountSearch(MypageParam param);

    public int memberCount();
}
