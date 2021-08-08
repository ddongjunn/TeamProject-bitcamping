package com.camping.bit.dto;

import lombok.*;

@AllArgsConstructor
@Setter
@Getter
@NoArgsConstructor
@ToString
public class MemberDto {

 private String id;
 private String pwd;
 private String username;
 private String nickname;
 private String phone;
 private String email;
 private String create_Date;
 private String sns_Type;
 private int auth;

}