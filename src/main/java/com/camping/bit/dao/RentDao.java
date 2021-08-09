package com.camping.bit.dao;

import java.util.List;

import com.camping.bit.dto.ProductDetailDto;

public interface RentDao {
	
	// 상품 등록
	public void regiAf(ProductDetailDto dto);

	public List<ProductDetailDto> getProductList();

	public ProductDetailDto getproductDetail(int productSeq);
}
