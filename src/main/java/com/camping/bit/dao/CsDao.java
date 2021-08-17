package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.CsNoticeDto;

public interface CsDao {

	public void noticeWriteAf(CsNoticeDto notice);

	public List<CsNoticeDto> getNoticeList();

	public CsNoticeDto getNoticeDetail(int notice_Seq);

}
