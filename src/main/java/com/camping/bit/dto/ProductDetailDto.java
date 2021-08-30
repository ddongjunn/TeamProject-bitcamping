package com.camping.bit.dto;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ProductDetailDto implements Serializable{

	// 상품 SEQ 
    private int product_Seq;

    // 상품 이름
    private String product_Name;

    // 상품 한줄 설명
    private String product_Desc;

    // 기본 구성 상품명
    private String base_Item;

    // 상품 가격
    private int product_Price;

    // 상품 재고
    private int product_Stock;

    // 썸네일 이미지 파일명
    private String thumbnail_Name;

    // 상품 상세 설명
    private String content;

    // 조명 옵션 포함 여부
    private int include_Light;

    // 화로 옵션 포함 여부
    private int include_Grill;

    // 대여료 유형
    private int rent_Type;

    // 상품 등록일 
    private String wdate;

    // 상품 삭제 
    private int del;
    
    // 상품 평균 별점
    private double rate;

    public ProductDetailDto(String product_Name, String product_Desc, String base_Item, int product_Price, int product_Stock, String thumbnail_Name, String content, int include_Light, int include_Grill, int rent_Type) {
        this.product_Name = product_Name;
        this.product_Desc = product_Desc;
        this.base_Item = base_Item;
        this.product_Price = product_Price;
        this.product_Stock = product_Stock;
        this.thumbnail_Name = thumbnail_Name;
        this.content = content;
        this.include_Light = include_Light;
        this.include_Grill = include_Grill;
        this.rent_Type = rent_Type;
    }
}
