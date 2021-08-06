package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.MemberDao;
import com.camping.bit.dto.MemberDto;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberDao dao;

	@Override
	public List<MemberDto> getMember() {
		return dao.getMember();
	}

	@Override
	public boolean idCheck(String id) {
		return dao.idCheck(id);
	}

	@Override
	public boolean nicknameCheck(String nickname) {
		return dao.nicknameCheck(nickname);
	}

	@Override
	public boolean emailCheck(String email) {
		return dao.emailCheck(email);
	}
}
