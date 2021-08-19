package com.camping.bit.service;

import com.camping.bit.dto.MemberDto;

import java.util.List;

public interface AdminService {

    public List<MemberDto> allMember();
    public int memberCount();
}
