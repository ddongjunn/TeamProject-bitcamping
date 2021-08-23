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
public class CsCommentParam implements Serializable {
	
	private int notice_Seq;

	private int pageNumber;
	
	private int start;
	private int end;
	
}
