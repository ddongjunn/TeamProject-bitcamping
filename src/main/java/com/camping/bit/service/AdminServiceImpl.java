package com.camping.bit.service;

import com.camping.bit.dao.AdminDao;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.MypageParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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


}
