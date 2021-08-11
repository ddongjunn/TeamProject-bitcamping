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
public class ProductOrderDto {

    // 주문 SEQ 
    private int order_Seq;

    // 회원 ID 
    private String user_Id;

    // 주문일시 
    private String order_Date;

    // 상품 SEQ 
    private int product_Seq;

    // 옵션 1 SEQ 
    private int option1_Seq;

    // 옵션 2 SEQ 
    private int option2_Seq;

    // 수량 
    private int quantity;

    // 대여 SEQ 
    private int rent_Seq;

    // 대여 시작일 
    private String rent_Sdate;

    // 대여 종료일 
    private String rent_Edate;

    // 상품금액 
    private int product_Price;

    // 배송비 
    private int shipping_Fee;

    // 총주문금액 
    private int total_Price;

    // 수령인 
    private String receiver;

    // 배송지 
    private String address;

    // 연락처 
    private String receiver_Phone;

    // 배송요청사항 
    private String memo;

    // 결제수단 
    private int payment;

    // 주문 상태 
    private int order_Status;

    // 리뷰 상태 
    private int review_Status;

}
