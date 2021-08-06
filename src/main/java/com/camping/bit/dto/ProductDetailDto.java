package com.camping.bit.dto;

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
public class ProductDetailDto {

	// 상품 SEQ 
    private int productSeq;

    // 상품 이름 
    @NonNull
    private String productName;

    // 상품 한줄 설명 
    @NonNull
    private String productDesc;

    // 기본 구성 상품명
    @NonNull
    private String baseItem;

    // 상품 가격 
    @NonNull
    private int productPrice;

    // 상품 재고 
    @NonNull
    private int productStock;

    // 썸네일 이미지 파일명 
    @NonNull
    private String thumbnailName;

    // 변환된 이미지 파일명 
    private String newThumbnailName;

    // 상품 상세 설명 
    @NonNull
    private String content;

    // 상품 상세 이미지 SEQ 
    private int imgSeq;

    // 조명 옵션 포함 여부 
    @NonNull
    private int includeLight;

    // 화로 옵션 포함 여부 
    @NonNull
    private int includeGrill;

    // 대여료 유형 
    @NonNull
    private int rentType;

    // 상품 등록일 
    private String wdate;

    // 상품 삭제 
    private int del;
}
