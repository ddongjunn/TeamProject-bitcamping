package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.dto.ProductOptionDto;
import com.camping.bit.dto.ProductOrderDto;
import com.camping.bit.dto.ProductQnaDto;
import com.camping.bit.dto.ProductRentDto;
import com.camping.bit.dto.ProductReviewDto;

public interface RentDao {
	
	// 상품 등록
	public void regiAf(ProductDetailDto dto);

	public List<ProductDetailDto> getProductList();

	public ProductDetailDto getProductDetail(int product_Seq);

	public List<ProductRentDto> getRentList(int product_Seq);

	public List<ProductOptionDto> getOptionList();
	
	public ProductOptionDto getOptionDetail(int option_Seq);

	public ProductRentDto getRentDetail(int rent_Seq);

	public void writeReviewAf(ProductReviewDto review);
	
	public List<ProductReviewDto> getReviewList(int product_Seq);
	
	public int getReviewCount(int product_Seq);

	public void writeQnaAf(ProductQnaDto qna);

	public List<ProductQnaDto> getQnaList(int product_Seq);

	public int getQnaCount(int product_Seq);

	public int paymentAf(ProductOrderDto dto);

	public ProductOrderDto getOrderInfo(String merchant_Uid);

	public void reviewStatus(int order_Seq);

	public void productUpdateAf(ProductDetailDto dto);

	public void productDelete(int product_Seq);

	public void reduceStock(ProductOrderDto order);
	 
}
