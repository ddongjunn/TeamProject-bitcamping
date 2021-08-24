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
public class CsParam implements Serializable {
	private String kind;
	private String search;
	private String choice;
	private int pageNumber;
	
	private int start;
	private int end;
	
}
