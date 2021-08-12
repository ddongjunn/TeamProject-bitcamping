package com.camping.bit.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.camping.bit.dto.MemberDto;

import javax.servlet.http.HttpServletResponse;

public interface MemberService {

	public MemberDto getMember(String id);

	public boolean idCheck(String id);

	public boolean nicknameCheck(String nickname);

	public boolean emailCheck(String email);

	public boolean login(MemberDto dto);

	public void addMember(MemberDto dto);

	public String findId(MemberDto dto);
	public String findPw(MemberDto dto);

	public void updatePw(MemberDto dto);

}
