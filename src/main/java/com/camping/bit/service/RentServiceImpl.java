package com.camping.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camping.bit.dao.RentDao;
import com.camping.bit.dto.ProductDetailDto;

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
	public ProductDetailDto getproductDetail(int productSeq) {

		ProductDetailDto detail = dao.getproductDetail(productSeq);
		
		return detail;
	}
}
