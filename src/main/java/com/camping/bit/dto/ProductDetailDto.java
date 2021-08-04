package com.camping.bit.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ProductDetailDto {

	// 상품 SEQ 
    private int productSeq;

    // 상품 이름 
    private String productName;

    // 상품 한줄 설명 
    private String productDesc;

    // 기본 구성 상품명 
    private String baseItem;

    // 상품 가격 
    private int productPrice;

    // 상품 재고 
    private int productStock;

    // 썸네일 이미지 파일명 
    private String thumbnailName;

    // 변환된 이미지 파일명 
    private String newThumbnailName;

    // 상품 상세 설명 
    private String content;

    // 상품 상세 이미지 SEQ 
    private int imgSeq;

    // 조명 옵션 포함 여부 
    private int includeLight;

    // 화로 옵션 포함 여부 
    private int includeGrill;

    // 대여료 유형 
    private int rentType;

    // 상품 등록일 
    private String wdate;

    // 상품 삭제 
    private int del;
}
