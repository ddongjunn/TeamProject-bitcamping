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
public class CampingListDto implements Serializable{

	private int contentid;
	private String facltnm;
	private String donm;
	private String sigungunm;
	private String addr1;
	private String addr2;
	private String tel;
	private String lineintro;
	
	private String facltdivnm;
	private String induty;
	private String homepage;
	private String lctcl;
	private int sitebottomcl1;
	private int sitebottomcl2;
	private int sitebottomcl3;
	private int sitebottomcl4;
	private int sitebottomcl5;
	
	private String resvecl;
	private String sbrscl;
	private String eqpmnlendcl;
	private String exprnprogramat;
	private String animalcmgcl;
	private String firstimageurl;
	private Date createdtime;
	private Date modifiedtime;
	
	private int readcount;
	private int likecount;

}
