package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.dto.ProductOptionDto;
import com.camping.bit.dto.ProductRentDto;

public interface RentService {

	public List<ProductDetailDto> getProductList();

	public void regiAf(ProductDetailDto dto);

	public ProductDetailDto getProductDetail(int product_Seq);

	public List<ProductRentDto> getRentList(int product_Seq);
	
	public List<ProductOptionDto> getOptionList();

	public ProductOptionDto getOptionDetail(int option_Seq);
}
