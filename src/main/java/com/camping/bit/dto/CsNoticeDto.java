package com.camping.bit.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class CsNoticeDto {
	
	// 공지사항 SEQ 
    private int notice_Seq;

    // 작성자 ID 
    private String user_Id;
    
    // 작성자 닉네임
    private String nickname;

    // 공지사항 제목 
    private String title;

    // 공지사항 내용 
    private String content;

    // 첨부파일명 
    private String filename;

    // 첨부파일명(변환) 
    private String newfilename;

    // 작성일 
    private String wdate;

    // 조회수 
    private int readcount;

    // 다운로드수 
    private int downcount;

    // 삭제 
    private int del;
    
    // 댓글수
    private int commentcount;
}
