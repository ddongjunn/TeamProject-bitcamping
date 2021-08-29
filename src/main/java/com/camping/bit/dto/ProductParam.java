package com.camping.bit.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductParam {

    private int start;
    private int end;
    private int pageNumber;

    private int product_Seq;

    private String id;
}
