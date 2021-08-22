package com.camping.bit.dto;

import java.io.Serializable;

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
public class CsNoticeCommentDto implements Serializable{
	
    // 댓글 SEQ 
    private int comment_Seq;

    // 공지사항 SEQ 
    private int notice_Seq;

    // 작성자 ID 
    private String user_Id;
    
    // 작성자 닉네임 
    private String nickname;

    // 댓글 내용 
    private String content;

    // 그룹번호 
    private int ref;

    // 행번호 
    private int step;

    // 깊이 
    private int depth;

    // 작성일 
    private String wdate;

    // 삭제 
    private int del;
    
    // private String parent_Nickname;
}
