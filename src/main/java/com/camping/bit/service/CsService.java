package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.CsCommentParam;
import com.camping.bit.dto.CsNoticeCommentDto;
import com.camping.bit.dto.CsNoticeDto;
import com.camping.bit.dto.CsParam;
import com.camping.bit.dto.CsQnaDto;

public interface CsService {

	public void noticeWriteAf(CsNoticeDto notice);

	public List<CsNoticeDto> getNoticeList(CsParam param);

	public CsNoticeDto getNoticeDetail(int notice_Seq);

	public void downcount(int notice_Seq);

	public void noticeUpdateAf(CsNoticeDto dto);

	public int getNoticeCount(CsParam param);

	public void noticeReadcount(int notice_Seq);

	public int writeComment(CsNoticeCommentDto comment);

	public List<CsNoticeCommentDto> getCommentList(CsCommentParam param);

	public void noticeDelete(int notice_Seq);

	public List<CsQnaDto> getQnaList(CsParam param);

	public int getQnaCount(CsParam param);

	public void qnaWriteAf(CsQnaDto qna);

	public CsQnaDto getQnaDetail(int qna_Seq);

	public void qnaAnswerAf(CsQnaDto answer);

	public void answerStatus(int ref);

	public CsQnaDto getAnswerDetail(int qna_Seq);

	public int updateComment(CsNoticeCommentDto comment);

	public int answerComment(CsNoticeCommentDto comment);

	public int deleteComment(int comment_Seq);

	public void qnaReadcount(int qna_Seq);

	public int getCommentCount(CsCommentParam param);

	public void qnaUpdateAf(CsQnaDto qna);

	public void qnaDelete(int qna_Seq);

}
