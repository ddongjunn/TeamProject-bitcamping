package com.camping.bit.dto;

import java.io.Serializable;
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
public class CampingBbsDto implements Serializable{

	private int review_seq;
	private int contentid;
	private String title;
	private String content;
	private Date wdate;
	private int readcount;
	private String user_id;
	private int revisit;
	private int like_count;
}
