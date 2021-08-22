package com.camping.bit.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class CsQnaDto {
	
	// QNA게시판 SEQ 
    private int qna_Seq;

    // 작성자 ID 
    private String user_Id;
    
    // 작성자 닉네임
    private String nickname;

    // 그룹번호 
    private int ref;

    // 행번호 
    private int step;

    // 깊이 
    private int depth;

    // QNA게시판 제목 
    private String title;

    // QNA게시판 내용 
    private String content;

    // 작성일 
    private String wdate;

    // 조회수 
    private int readcount;

    // 상태 
    private int status;

    // 상단공지 
    private int notice;

    // QNA게시판 비밀글 여부 
    private int secret;

    // 삭제 
    private int del;
}
