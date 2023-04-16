package com.prj.flower.cart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.prj.flower.cart.vo.CartVO;
import com.prj.flower.goods.vo.GoodsVO;



public interface CartDAO {
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList, String member_id) throws DataAccessException;
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;
	public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException;
	public void deleteCartGoods(int cart_id) throws DataAccessException;
	public int getQty(String member_id);

	
	

}