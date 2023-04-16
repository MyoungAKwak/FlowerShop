package com.prj.flower.goods.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.prj.flower.goods.vo.GoodsVO;
import com.prj.flower.goods.vo.ImageFileVO;
import com.prj.flower.r_board.vo.ReviewVO;



@Repository("goodsDAO")
public class GoodsDAOImpl  implements GoodsDAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException {
		List<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsList",goodsStatus);
	   return goodsList;	
     
	}
	@Override
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException {
	   List<String> list=(ArrayList)sqlSession.selectList("mapper.goods.selectKeywordSearch",keyword);
	   return list;
	}
	
	@Override
	public ArrayList selectGoodsBySearchWord(String searchWord) throws DataAccessException{
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsBySearchWord",searchWord);
		 return list;
	}
	
	@Override
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException{
		GoodsVO goodsVO=(GoodsVO)sqlSession.selectOne("mapper.goods.selectGoodsDetail",goods_id);
		return goodsVO;
	}
	
	@Override
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException{
		List<ImageFileVO> imageList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsDetailImage",goods_id);
		return imageList;
	}
	
	
	//꽃말
	@Override
	public List<ImageFileVO> selectGoodsDetaillenImage(String goods_id) throws DataAccessException {
		List<ImageFileVO> lenList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsDetaillenImage",goods_id);
		return lenList;
	}

  //리뷰
	@Override
	public List<ReviewVO> selectReview(String goods_id) throws DataAccessException {
		 List<ReviewVO> reviewList= sqlSession.selectList("mapper.goods.selectReview",goods_id);
		return reviewList;
	}
	@Override
	public int selectGoodsTitle(String goods_title) throws DataAccessException {
		int goods_id = sqlSession.selectOne("mapper.goods.selectGoodsId", goods_title);
		return goods_id;
	}

	
	
}
