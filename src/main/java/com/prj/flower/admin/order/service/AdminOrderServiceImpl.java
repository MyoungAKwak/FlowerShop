package com.prj.flower.admin.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.prj.flower.admin.order.dao.AdminOrderDAO;
import com.prj.flower.member.vo.MemberVO;
import com.prj.flower.order.vo.OrderVO;




@Service("adminOrderService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminOrderServiceImpl implements AdminOrderService {
	@Autowired
	private AdminOrderDAO adminOrderDAO;
	
	public List<OrderVO>listNewOrder(Map condMap) throws Exception{
		return adminOrderDAO.selectNewOrderList(condMap);
	}
	@Override
	public void  modifyDeliveryState(Map deliveryMap) throws Exception{
		adminOrderDAO.updateDeliveryState(deliveryMap);
	}
	@Override
	public Map orderDetail(int order_id) throws Exception{
		Map orderMap=new HashMap();
		ArrayList<OrderVO> orderList =adminOrderDAO.selectOrderDetail(order_id);
		OrderVO deliveryInfo=(OrderVO)orderList.get(0);
		String member_id=(String)deliveryInfo.getMember_id();
		MemberVO orderer=adminOrderDAO.selectOrderer(member_id);
		orderMap.put("orderList",orderList);
		orderMap.put("deliveryInfo",deliveryInfo);
		orderMap.put("orderer", orderer);
		return orderMap;
	}

	
	

}
