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
public class ProductReviewDto implements Serializable{

	// 상품 후기 SEQ 
    private int review_Seq;

    // 상품 SEQ 
    private int product_Seq;

    // 작성자 ID 
    private String user_Id;
    
    // 작성자 닉네임 
    private String nickname;

    // 주문 SEQ 
    private int order_Seq;

    // 제목 
    private String title;

    // 후기 내용 
    private String content;
    
    // 이미지 파일명 
    private String image;

    // 별점 
    private int rate;

    // 작성일 
    private String wdate;

    // 삭제 
    private int del;

    // 답변 상태 
    private int status;
}
