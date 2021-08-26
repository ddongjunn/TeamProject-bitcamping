package com.camping.bit.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MypageParam implements Serializable {
    private String id;
    private String bbstype;
    private String dealType;

    private String choice;
    private String search;
    private int pageNumber;

    private int start;
    private int end;
}
