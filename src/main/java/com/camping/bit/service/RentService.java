package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.*;

public interface RentService {

	public List<ProductDetailDto> getProductList();

	public void regiAf(ProductDetailDto dto);

	public ProductDetailDto getProductDetail(int product_Seq);

	public List<ProductRentDto> getRentList(int product_Seq);
	
	public List<ProductOptionDto> getOptionList();

	public ProductOptionDto getOptionDetail(int option_Seq);

	public ProductRentDto getRentDetail(int rent_Seq);

	public void writeReviewAf(ProductReviewDto review);

	public List<ProductReviewDto> getReviewList(ProductParam param);

	public int getReviewCount(ProductParam param);

	public void writeQnaAf(ProductQnaDto qna);

	public List<ProductQnaDto> getQnaList(ProductParam param);

	public int getQnaCount(ProductParam param);

	public int paymentAf(ProductOrderDto order);

	public ProductOrderDto getOrderInfo(String merchant_Uid);

	public void reviewStatus(int order_Seq);

	public void productUpdateAf(ProductDetailDto dto);

	public void productDelete(int product_Seq);

	public void reduceStock(ProductOrderDto order);


}
