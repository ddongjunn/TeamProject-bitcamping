package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.RentDao;
import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.dto.ProductOptionDto;
import com.camping.bit.dto.ProductQnaDto;
import com.camping.bit.dto.ProductRentDto;
import com.camping.bit.dto.ProductReviewDto;

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
		
		return dao.getProductList();
	}

	@Override
	public ProductDetailDto getProductDetail(int product_Seq) {

		return dao.getProductDetail(product_Seq);
	}

	@Override
	public List<ProductRentDto> getRentList(int product_Seq) {
		
		return dao.getRentList(product_Seq);
	}

	@Override
	public List<ProductOptionDto> getOptionList() {

		return dao.getOptionList();
	}

	@Override
	public ProductOptionDto getOptionDetail(int option_Seq) {

		return dao.getOptionDetail(option_Seq);
	}

	@Override
	public ProductRentDto getRentDetail(int rent_Seq) {
		
		return dao.getRentDetail(rent_Seq);
	}

	@Override
	public void writeReviewAf(ProductReviewDto review) {
		
		dao.writeReviewAf(review);
	}

	@Override
	public List<ProductReviewDto> getReviewList(int product_Seq) {
		
		return dao.getReviewList(product_Seq);
	}

	@Override
	public int getReviewCount(int product_Seq) {

		
		return dao.getReviewCount(product_Seq);
	}

	@Override
	public void writeQnaAf(ProductQnaDto qna) {
		
		dao.writeQnaAf(qna);
	}

	@Override
	public List<ProductQnaDto> getQnaList(int product_Seq) {
		
		return dao.getQnaList(product_Seq);
	}

	@Override
	public int getQnaCount(int product_Seq) {

		return dao.getQnaCount(product_Seq);
	}
}
