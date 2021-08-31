package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.RentDao;
import com.camping.bit.dto.CommonsParam;
import com.camping.bit.dto.CsParam;
import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.dto.ProductOptionDto;
import com.camping.bit.dto.ProductOrderDto;
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
	public List<ProductDetailDto> getProductList(CommonsParam param) {
		
		return dao.getProductList(param);
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
	public List<ProductReviewDto> getReviewList(ProductParam param) {
		
		return dao.getReviewList(param);
	}

	@Override
	public int getReviewCount(ProductParam param) {

		
		return dao.getReviewCount(param);
	}

	@Override
	public void writeQnaAf(ProductQnaDto qna) {
		
		dao.writeQnaAf(qna);
	}

	@Override
	public List<ProductQnaDto> getQnaList(ProductParam param) {
		
		return dao.getQnaList(param);
	}

	@Override
	public int getQnaCount(ProductParam param) {

		return dao.getQnaCount(param);
	}

	@Override
	public int paymentAf(ProductOrderDto order) {
		
		return dao.paymentAf(order);
	}

	@Override
	public ProductOrderDto getOrderInfo(String merchant_Uid) {
		
		return dao.getOrderInfo(merchant_Uid);
	}

	@Override
	public void reviewStatus(int order_Seq) {
		
		dao.reviewStatus(order_Seq);
	}

	@Override
	public void productUpdateAf(ProductDetailDto dto) {
		
		dao.productUpdateAf(dto);
	}

	@Override
	public void productDelete(int product_Seq) {
		
		dao.productDelete(product_Seq);
	}

	@Override
	public void reduceStock(ProductOrderDto order) {
		
		dao.reduceStock(order);
	}

	@Override
	public int getProductCount(CommonsParam param) {

		return dao.getProductCount(param);
	}

	@Override
	public void updateProductQnaStatus(ProductQnaDto dto) {
		dao.updateProductQnaStatus(dto);
	}

	@Override
	public void productQnaAnswer(ProductQnaDto dto) {
		dao.productQnaAnswer(dto);
	}

	@Override
	public void updateCsQnaStatus(CsQnaDto dto) {
		dao.updateCsQnaStatus(dto);
	}

	@Override
	public void csQnaAnswer(CsQnaDto dto) {
		dao.csQnaAnswer(dto);
	}
}
