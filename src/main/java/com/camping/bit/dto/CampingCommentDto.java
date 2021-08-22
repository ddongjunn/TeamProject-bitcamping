package com.camping.bit.dto;

import java.util.Date;

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
public class CampingCommentDto {

	private int comment_seq;
	private int review_seq;
	private String user_id;
	private String content;
	private Date wdate;
	private int ref;
	private int step;
	private int depth;
}
