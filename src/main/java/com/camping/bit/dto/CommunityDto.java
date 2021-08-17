package com.camping.bit.dto;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Setter
@Getter
@NoArgsConstructor
@ToString
public class CommunityDto implements Serializable{
	 private int community_seq;	
	 private String user_id;			// 작성자
	 private String nickname;
	 private String bbstype;	// 작성글 구분(자유게시판, 캠핑후기, 가입인사, 캠퍼구인, 삽니다, 팝니다)

	 private String title;		// 제목
	 private String content;	// 내용
	 private String wdate;		// 작성일자
	 			
	 private int del;			// 삭제
	 private int readcount;		// 조회수
}
