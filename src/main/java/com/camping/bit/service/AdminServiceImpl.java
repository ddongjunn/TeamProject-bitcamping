package com.camping.bit.service;

import com.camping.bit.dao.AdminDao;
import com.camping.bit.dto.MemberDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService{

    @Autowired
    AdminDao dao;

    @Override
    public List<MemberDto> allMember() {
        return dao.allMember();
    }

    @Override
    public int memberCount() {
        return dao.memberCount();
    }


}
