package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CommunityDao;
import com.camping.bit.dto.CommunityDto;

@Service
public class CommunityServiceImpl implements CommunityService{

	@Autowired
	CommunityDao dao;
	
	@Override
	public List<CommunityDto> helloboardlist() {
		return dao.helloboardlist();
	}
}
