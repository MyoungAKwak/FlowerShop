package com.prj.flower.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.prj.flower.goods.vo.GoodsVO;
import com.prj.flower.goods.vo.ImageFileVO;
import com.prj.flower.r_board.vo.ReviewVO;



public interface GoodsDAO {
	public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException;
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;

	//리뷰
		public List<ReviewVO> selectReview(String goods_id) throws DataAccessException;

	//꽃말
		public List<ImageFileVO> selectGoodsDetaillenImage(String goods_id) throws DataAccessException;
	
	//리뷰게시판에서 사용 goods_title로 goods_id 검색
		public int selectGoodsTitle(String goods_title) throws DataAccessException;

}
