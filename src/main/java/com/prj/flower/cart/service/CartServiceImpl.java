package com.prj.flower.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.prj.flower.cart.dao.CartDAO;
import com.prj.flower.cart.vo.CartVO;
import com.prj.flower.goods.vo.GoodsVO;

@Service("cartService")
@Transactional(propagation = Propagation.REQUIRED)
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDAO cartDAO;

//♣♣♣♣ 시작(개별 수량 변경 이상했던거 Cart.xml과 관련있음2)
	public Map<String, List> myCartList(CartVO cartVO) throws Exception {
		Map<String, List> cartMap = new HashMap<String, List>();
		List<CartVO> myCartList = cartDAO.selectCartList(cartVO);
		if (myCartList.size() == 0) { // 카트占쏙옙 占쏙옙占쏙옙占� 占쏙옙품占싱억옙占쏙옙 占쏙옙占�
			return null;
		}
		String member_id = cartVO.getMember_id();
		List<GoodsVO> myGoodsList = cartDAO.selectGoodsList(myCartList,member_id);
		cartMap.put("myCartList", myCartList);
		cartMap.put("myGoodsList", myGoodsList);
		return cartMap;
	}
//♣♣♣♣ 끝 

	public boolean findCartGoods(CartVO cartVO) throws Exception {
		return cartDAO.selectCountInCart(cartVO);

	}

	public void addGoodsInCart(CartVO cartVO) throws Exception {
		cartDAO.insertGoodsInCart(cartVO);
	}

	public boolean modifyCartQty(CartVO cartVO) throws Exception {
		boolean result = true;
		cartDAO.updateCartGoodsQty(cartVO);
		return result;
	}

	public void removeCartGoods(int cart_id) throws Exception {
		cartDAO.deleteCartGoods(cart_id);
	}


	  @Override 
	  public int getQty(String member_id) { 
		  int qty = cartDAO.getQty(member_id); 
		  return qty;
	  }
	 
}