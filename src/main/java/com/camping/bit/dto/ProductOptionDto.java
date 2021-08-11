package com.camping.bit.dto;

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
public class ProductOptionDto {
	
    // 옵션 SEQ 
    private int option_Seq;

    // 옵션 유형 
    private int option_Type;

    // 옵션 유형 이름 
    private String option_Type_Name;

    // 옵션 이름 
    private String option_Name;

    // 옵션 가격 
    private int option_Price;

    // 옵션 재고 
    private int option_Stock;
    
}
