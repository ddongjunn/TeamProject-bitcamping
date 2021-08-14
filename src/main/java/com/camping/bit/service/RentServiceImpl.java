package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.RentDao;
import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.dto.ProductOptionDto;
import com.camping.bit.dto.ProductRentDto;

@Service
public class RentServiceImpl implements RentService {
	
	@Autowired
	RentDao dao;

	@Override
	public void regiAf(ProductDetailDto dto) {
		
		dao.regiAf(dto);
	}

	@Override
	public List<ProductDetailDto> getProductList() {
		
		List<ProductDetailDto> list = dao.getProductList();
		
		return list;
	}

	@Override
	public ProductDetailDto getProductDetail(int product_Seq) {

		ProductDetailDto detail = dao.getProductDetail(product_Seq);
		
		return detail;
	}

	@Override
	public List<ProductRentDto> getRentList(int product_Seq) {
		
		List<ProductRentDto> rent = dao.getRentList(product_Seq);

		return rent;
	}

	@Override
	public List<ProductOptionDto> getOptionList() {

		List<ProductOptionDto> option = dao.getOptionList();
		
		return option;
	}

	@Override
	public ProductOptionDto getOptionDetail(int option_Seq) {

		ProductOptionDto option = dao.getOptionDetail(option_Seq);
		
		return option;
	}

	@Override
	public ProductRentDto getRentDetail(int rent_Seq) {
		
		ProductRentDto rent = dao.getRentDetail(rent_Seq);
		
		return rent;
	}
}
