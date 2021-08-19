package com.camping.bit.dao;

import com.camping.bit.dto.MemberDto;

import java.util.List;

public interface AdminDao {

    public List<MemberDto> allMember();
    public int memberCount();
}
