package com.camping.bit.service;

import java.util.List;

import com.camping.bit.dto.ProductDetailDto;

public interface RentService {

	public List<ProductDetailDto> getProductList();

	public void regiAf(ProductDetailDto dto);

	public ProductDetailDto getproductDetail(int productSeq);
}
