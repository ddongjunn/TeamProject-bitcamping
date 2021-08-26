package com.camping.bit.dto;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class CommunityParam implements Serializable{
	
	private String choice;
	private String search;
	
	private int pageNumber;
	
	private int start;
	private int end; 
	
	private String bbstype;
	private String kind;
}
