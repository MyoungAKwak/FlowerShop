package com.prj.flower.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.prj.flower.goods.dao.GoodsDAO;
import com.prj.flower.goods.vo.GoodsVO;
import com.prj.flower.goods.vo.ImageFileVO;
import com.prj.flower.r_board.vo.ReviewVO;



@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	
	public Map<String,List<GoodsVO>> listGoods() throws Exception {
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList=goodsDAO.selectGoodsList("bestseller");
		goodsMap.put("bestseller",goodsList);
		goodsList=goodsDAO.selectGoodsList("newbook");
		goodsMap.put("newbook",goodsList);
		
		goodsList=goodsDAO.selectGoodsList("steadyseller");
		goodsMap.put("steadyseller",goodsList);
		return goodsMap;
	}
	
	
	

	
	
	
	public Map goodsDetail(String _goods_id) throws Exception {
		Map goodsMap=new HashMap();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		
		List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		
		//꽃말
		List<ImageFileVO> lenList =goodsDAO.selectGoodsDetaillenImage(_goods_id);
		goodsMap.put("lenList", lenList);
		
		//리뷰
		List<ReviewVO> reviewList =goodsDAO.selectReview(_goods_id);
		goodsMap.put("reviewList", reviewList);
		
		
		return goodsMap;
	}
		
	
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}







	@Override
	public int selectGoodsId(String goods_title) throws Exception {
		int goods_id = goodsDAO.selectGoodsTitle(goods_title);
		return goods_id;
	}
	
	
}
