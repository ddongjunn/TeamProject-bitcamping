package com.camping.bit.dto;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ProductDetailDto implements Serializable{

	// 상품 SEQ 
    private int product_Seq;

    // 상품 이름 
    @NonNull
    private String product_Name;

    // 상품 한줄 설명 
    @NonNull
    private String product_Desc;

    // 기본 구성 상품명
    @NonNull
    private String base_Item;

    // 상품 가격 
    @NonNull
    private int product_Price;

    // 상품 재고 
    @NonNull
    private int product_Stock;

    // 썸네일 이미지 파일명 
    @NonNull
    private String thumbnail_Name;

    // 상품 상세 설명 
    @NonNull
    private String content;

    // 조명 옵션 포함 여부 
    @NonNull
    private int include_Light;

    // 화로 옵션 포함 여부 
    @NonNull
    private int include_Grill;

    // 대여료 유형 
    @NonNull
    private int rent_Type;

    // 상품 등록일 
    private String wdate;

    // 상품 삭제 
    private int del;
}
