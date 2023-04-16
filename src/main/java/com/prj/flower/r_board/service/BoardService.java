package com.prj.flower.r_board.service;

import java.util.List;
import java.util.Map;

import com.prj.flower.r_board.vo.ReviewVO;



public interface BoardService {
	//목록 
	public Map listReviews(Map pagingMap) throws Exception;
	//상세보기
	public ReviewVO viewReview(int review_no) throws Exception;
	//수정 
	public void modReview(Map reveiwMap) throws Exception;
	//삭제
	public void removeReview(int review_no) throws Exception;
	//글쓰기
    public int addNewReview(Map reviewMap) throws Exception;
    //포인트 적립 
    public void addPoint(Map map) throws Exception;
    
    //평점 리스트 출력
    public List<ReviewVO> selectReviewStar(String review_star) throws Exception;
    
    //상품번호로 리뷰 리스트 출력
    public List<ReviewVO> selectGoodsid(int goods_id) throws Exception;

    public void updatecnt(int review_no) throws Exception;
    
    //상품으로 출력
    public List<ReviewVO> goodsSearch(String detail) throws Exception;
    
    //작성자로 출력
    public List<ReviewVO> memberSearch(String detail) throws Exception;
}