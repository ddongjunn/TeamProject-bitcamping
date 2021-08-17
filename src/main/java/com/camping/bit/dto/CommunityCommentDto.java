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
public class CommunityCommentDto implements Serializable{
	private int community_seq;
	private int comment_seq;
	
	private String user_id;
	private String nickname;
	private String content;
	private String wdate;
	
	private int del;
}
