package com.prj.flower.r_board.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.prj.flower.r_board.vo.ReviewVO;



public interface BoardDAO {
	
	//paging
	public int selectTotArticles();
	//리뷰목록
	public List<ReviewVO> selectAllReviewList(Map pagingMap) throws DataAccessException;
	
	
	//리뷰작
	public int insertNewReview(Map reviewMap) throws DataAccessException;
	//public void insertNewImage(Map reviewMap) throws DataAccessException;
	//리뷰보기
	public ReviewVO selectReview(int review_no) throws DataAccessException;
	//리뷰수정
	public void updateReview(Map reviewMap) throws DataAccessException;
	//리뷰삭제
	public void deleteReview(int review_no) throws DataAccessException;
	//적립포인트
	public void updatePoint(Map map) throws DataAccessException;
	
	//평점으로 리뷰리스트 출력
	public List<ReviewVO> selectReviewStar(String review_star) throws DataAccessException;

	//상품 번호로 리뷰 리스트 출력
	public List<ReviewVO> selectGoodsid(int goods_id) throws DataAccessException;
	
	//조회수 증가
	public void updatecnt(int review_no) throws DataAccessException;
	
	//상품으로 검색
	public List<ReviewVO> goodsSearch(String detail) throws DataAccessException;
	
	//작성자로 검색
	public List<ReviewVO> memberSearch(String detail) throws DataAccessException;
}