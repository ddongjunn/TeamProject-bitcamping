package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CsDao;
import com.camping.bit.dto.CsNoticeDto;

@Service
public class CsServiceImpl implements CsService{
	
	@Autowired
	CsDao dao;

	@Override
	public void noticeWriteAf(CsNoticeDto notice) {
		
		dao.noticeWriteAf(notice);
	}

	@Override
	public List<CsNoticeDto> getNoticeList() {

		List<CsNoticeDto> notice = dao.getNoticeList();
		
		return notice;
	}

	@Override
	public CsNoticeDto getNoticeDetail(int notice_Seq) {

		CsNoticeDto notice = dao.getNoticeDetail(notice_Seq);
		
		return notice;
	}
}
