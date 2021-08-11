package com.camping.bit.commons;

public class Util {
    public static String two(String msg) {
        return msg.trim().length()<2?"0"+msg.trim():msg.trim();
    }

    public String hideId(int i){
        StringBuilder str = new StringBuilder();

        for(int y = 0; y < i; i++){
            str.append("*");
        }

        return str.toString();
    }
}
