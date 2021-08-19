package com.camping.bit.controller;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingListDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String main() {

        return "adminmain.tiles";
    }
}
