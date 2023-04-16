package com.prj.flower.cart.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.prj.flower.cart.vo.CartVO;
import com.prj.flower.goods.vo.GoodsVO;


@Repository("cartDAO")
public class CartDAOImpl  implements  CartDAO{
	@Autowired
	private SqlSession sqlSession;
	
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
		List<CartVO> cartList =(List)sqlSession.selectList("mapper.cart.selectCartList",cartVO);
		return cartList;
	}

//♣♣♣♣ 시작(개별 수량 변경 이상했던거 Cart.xml과 관련있음)
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList,String member_id) throws DataAccessException {
		
		List<GoodsVO> myGoodsList;
		Map<String,Object> map = new HashMap();
		map.put("cartList",cartList);
		map.put("member_id",member_id);
		myGoodsList = sqlSession.selectList("mapper.cart.selectGoodsList",map);
		return myGoodsList;
	}
//♣♣♣♣ 끝

	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
		String  result =sqlSession.selectOne("mapper.cart.selectCountInCart",cartVO);
		return Boolean.parseBoolean(result);
	}

	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException{
		int cart_id=selectMaxCartId();
		cartVO.setCart_id(cart_id);
		sqlSession.insert("mapper.cart.insertGoodsInCart",cartVO);
	}
	
	public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException{
		sqlSession.insert("mapper.cart.updateCartGoodsQty",cartVO);
	}
	
	public void deleteCartGoods(int cart_id) throws DataAccessException{
		sqlSession.delete("mapper.cart.deleteCartGoods",cart_id);
	}

	private int selectMaxCartId() throws DataAccessException{
		int cart_id =sqlSession.selectOne("mapper.cart.selectMaxCartId");
		return cart_id;
	}


	  @Override public int getQty(String member_id) { int qty =
	  sqlSession.selectOne("mapper.cart.selectSumQty",member_id); return qty;
	  }
	 

}