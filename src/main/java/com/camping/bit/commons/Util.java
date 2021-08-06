package com.camping.bit.commons;

public class Util {
    public static String two(String msg) {
        return msg.trim().length()<2?"0"+msg.trim():msg.trim();
    }
}
