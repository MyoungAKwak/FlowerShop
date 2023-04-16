package com.prj.flower.order.service;

import java.util.List;
import java.util.Map;

import com.prj.flower.order.vo.OrderVO;



public interface OrderService {
	public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception;
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception;
	public OrderVO findMyOrder(String order_id) throws Exception;
	public int updatePoint(Map<String, String> map);
	
	
}