package com.camping.bit.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.annotations.Mapper;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProductQnaDto {

	// 상품 QNA SEQ 
    private int qna_Seq;

    // 상품 SEQ 
    private int product_Seq;

    // 작성자 ID 
    private String user_Id;
    
    // 작성자 닉네임
    private String nickname;
    
    // 제목 
    private String title;    

    // QNA 내용 
    private String content;
    
    // 작성일 
    private String wdate;

    // 비밀글 여부 
    private int secret;

    // 삭제 
    private int del;

    // 답변 상태 
    private int status;

    private String answercontent;
    private String answerwdate;

}
