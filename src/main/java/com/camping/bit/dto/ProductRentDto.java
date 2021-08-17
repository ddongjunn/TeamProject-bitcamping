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
public class ProductRentDto implements Serializable {
	
    // 대여 SEQ 
    private int rent_Seq;

    // 대여료 유형 
    private int rent_Type;

    // 대여 옵션명 
    private String rent_Name;

    // 대여료 
    private int rent_Price;

    // 대여일수 
    private int rent_Days;
}
