package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.CsDao;
import com.camping.bit.dto.CsCommentParam;
import com.camping.bit.dto.CsNoticeCommentDto;
import com.camping.bit.dto.CsNoticeDto;
import com.camping.bit.dto.CsParam;
import com.camping.bit.dto.CsQnaDto;

@Service
public class CsServiceImpl implements CsService{
	
	@Autowired
	CsDao dao;

	@Override
	public void noticeWriteAf(CsNoticeDto notice) {
		
		dao.noticeWriteAf(notice);
	}

	@Override
	public List<CsNoticeDto> getNoticeList(CsParam param) {
		
		return dao.getNoticeList(param);
	}

	@Override
	public CsNoticeDto getNoticeDetail(int notice_Seq) {
		
		return dao.getNoticeDetail(notice_Seq);
	}

	@Override
	public void downcount(int notice_Seq) {
		
		dao.downcount(notice_Seq);	
	}

	@Override
	public void noticeUpdateAf(CsNoticeDto dto) {
		
		dao.noticeUpdateAf(dto);
		
	}

	@Override
	public int getNoticeCount(CsParam param) {

		return dao.getNoticeCount(param);
	}

	@Override
	public void noticeReadcount(int notice_Seq) {
		
		dao.noticeReadcount(notice_Seq);
		
	}

	@Override
	public int writeComment(CsNoticeCommentDto comment) {
		
		return dao.writeComment(comment);
	}

	@Override
	public List<CsNoticeCommentDto> getCommentList(CsCommentParam param) {

		return dao.getCommentList(param);
	}

	@Override
	public void noticeDelete(int notice_Seq) {

		dao.noticeDelete(notice_Seq);
	}

	@Override
	public List<CsQnaDto> getQnaList(CsParam param) {
		
		return dao.getQnaList(param);
	}

	@Override
	public int getQnaCount(CsParam param) {
		
		return dao.getQnaCount(param);
	}

	@Override
	public void qnaWriteAf(CsQnaDto qna) {
		
		dao.qnaWriteAf(qna);
	}

	@Override
	public CsQnaDto getQnaDetail(int qna_Seq) {
		
		return dao.getQnaDetail(qna_Seq);
	}

	@Override
	public void qnaAnswerAf(CsQnaDto answer) {
		
		dao.qnaAnswerAf(answer);
	}

	@Override
	public void answerStatus(int ref) {
		
		dao.answerStatus(ref);
	}

	@Override
	public CsQnaDto getAnswerDetail(int qna_Seq) {
		
		return dao.getAnswerDetail(qna_Seq);
	}

	@Override
	public int updateComment(CsNoticeCommentDto comment) {
		
		return dao.updateComment(comment);
	}

	@Override
	public int answerComment(CsNoticeCommentDto comment) {
		
		return dao.answerComment(comment);
	}

	@Override
	public int deleteComment(int comment_Seq) {
		
		return dao.deleteComment(comment_Seq);
	}

	@Override
	public void qnaReadcount(int qna_Seq) {
		
		dao.qnaReadcount(qna_Seq);
	}

	@Override
	public int getCommentCount(CsCommentParam param) {
		
		return dao.getCommentCount(param);
	}

	@Override
	public void qnaUpdateAf(CsQnaDto qna) {

		dao.qnaUpdateAf(qna);
	}

	@Override
	public void qnaDelete(int qna_Seq) {

		dao.qnaDelete(qna_Seq);
	}

	@Override
	public void qnaAnswerDelete(int qna_Seq) {
		
		dao.qnaAnswerDelete(qna_Seq);
	}

	@Override
	public int answerStatusWait(int qna_Seq) {
		
		return dao.answerStatusWait(qna_Seq);
	}
}
