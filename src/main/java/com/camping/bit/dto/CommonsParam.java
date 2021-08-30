package com.camping.bit.dto;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonsParam implements Serializable  {
	
	private String kind;
	private String search;
	private String choice;
	private int pageNumber;
	
	private int start;
	private int end;
}
