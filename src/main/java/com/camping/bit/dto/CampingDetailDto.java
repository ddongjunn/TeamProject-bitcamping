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
public class CampingDetailDto {

	private int contentid;
	private String intro;
	private String mapx;
	private String mapy;
	private int gnrlsiteco;
	private int autositeco;
	private int glampsiteco;
	private int caravsiteco;
	private int indvdlcaravsiteco;
	
	private int sitedstnc;
	private int sitemg1width;
	private int sitemg1vrticl;
	private int sitemg1co;
	private int sitemg2width;
	private int sitemg2vrticl;
	private int sitemg2co;
	
	private String resveurl;
	private String operpdcl;
	private String operdecl;
	private String exprnprogrm;
	private String trleracmpnyat;

}
