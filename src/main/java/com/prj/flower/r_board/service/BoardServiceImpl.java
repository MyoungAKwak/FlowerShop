package com.prj.flower.r_board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.prj.flower.r_board.dao.BoardDAO;
import com.prj.flower.r_board.vo.ReviewVO;





@Service("r_boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl  implements BoardService{
	@Autowired
	BoardDAO boardDAO;
	
	public Map listReviews(Map pagingMap) throws Exception{
		Map reviewMap = new HashMap();
		List<ReviewVO> reviewList =  boardDAO.selectAllReviewList(pagingMap);
		int totArticles = boardDAO.selectTotArticles();
		reviewMap.put("reviewList", reviewList);
		reviewMap.put("totArticles", totArticles);
		
        return reviewMap;
	}
	
	//단일 이미지 추가하기
	@Override
	public int addNewReview(Map reviewMap) throws Exception{
		return boardDAO.insertNewReview(reviewMap);
	}

	 //단일 파일 보이기
	@Override
	public ReviewVO viewReview(int review_no) throws Exception {
		ReviewVO reviewVO = boardDAO.selectReview(review_no);
		return reviewVO;
	}
	
	@Override
	public void modReview(Map reviewMap) throws Exception {
		boardDAO.updateReview(reviewMap);
	}
	
	@Override
	public void removeReview(int review_no) throws Exception {
		boardDAO.deleteReview(review_no);
	}

	@Override
	public void addPoint(Map map) throws Exception {
		boardDAO.updatePoint(map);
		
	}

	@Override
	public List<ReviewVO> selectReviewStar(String review_star) throws Exception {
		List<ReviewVO> ReviewStarList = boardDAO.selectReviewStar(review_star);
		return ReviewStarList;
	}

	@Override
	public List<ReviewVO> selectGoodsid(int goods_id) throws Exception {
		List<ReviewVO> GoodsList = boardDAO.selectGoodsid(goods_id);
		return GoodsList;
	}

	@Override
	public void updatecnt(int review_no) throws Exception {
		boardDAO.updatecnt(review_no);
	}

	@Override
	public List<ReviewVO> goodsSearch(String detail) throws Exception {
		List<ReviewVO> reviewsList = boardDAO.goodsSearch(detail);
		return reviewsList;
	}

	@Override
	public List<ReviewVO> memberSearch(String detail) throws Exception {
		List<ReviewVO> reviewsList = boardDAO.memberSearch(detail);
		return reviewsList;
	}
	
	


}