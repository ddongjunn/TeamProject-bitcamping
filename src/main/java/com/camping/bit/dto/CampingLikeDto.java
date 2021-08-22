package com.camping.bit.dto;

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
public class CampingLikeDto {

	private int like_auto_seq;
	private int contentid;
	private String user_id;
	private int content_type;
	
	private String login_id;
	//1이면 캠핑장, 2이면 리뷰, 3이면 댓글

}
