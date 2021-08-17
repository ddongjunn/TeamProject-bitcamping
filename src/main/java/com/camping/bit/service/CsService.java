package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CsNoticeDto;

public interface CsService {

	public void noticeWriteAf(CsNoticeDto notice);

	public List<CsNoticeDto> getNoticeList();

	public CsNoticeDto getNoticeDetail(int notice_Seq);
	

}
