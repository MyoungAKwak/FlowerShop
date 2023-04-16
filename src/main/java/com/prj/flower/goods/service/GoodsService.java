package com.prj.flower.goods.service;

import java.util.List;
import java.util.Map;

import com.prj.flower.goods.vo.GoodsVO;
import com.prj.flower.goods.vo.ImageFileVO;



public interface GoodsService {
	
	public Map<String,List<GoodsVO>> listGoods() throws Exception;
	
	public Map goodsDetail(String _goods_id) throws Exception;
	
	public List<String> keywordSearch(String keyword) throws Exception;
	
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
	
	public int selectGoodsId(String goods_title) throws Exception;
}
