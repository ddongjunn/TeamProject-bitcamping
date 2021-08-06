package com.camping.bit.service;

import org.springframework.stereotype.Service;

import com.camping.bit.dao.RentDao;
import com.camping.bit.dto.ProductDetailDto;

@Service
public class RentServiceImpl implements RentService {
	
	RentDao dao;

	@Override
	public void regiAf(ProductDetailDto dto) {
		dao.regiAf(dto);
	}
}
