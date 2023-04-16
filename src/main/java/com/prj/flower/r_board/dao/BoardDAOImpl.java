package com.prj.flower.r_board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import com.prj.flower.r_board.vo.ReviewVO;



@Repository("r_boardDAO")
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	//리뷰목록
//	@Override
//	public List selectAllReviewList() throws DataAccessException {
//		List<ReviewVO> reviewList = sqlSession.selectList("mapper.r_board.selectAllReviewList");
//		return reviewList;
//	}
	
	//페이징 리뷰 조회
	@Override
	public int selectTotArticles() {
		int totArticles = sqlSession.selectOne("mapper.r_board.selectTotArticles");
		return totArticles;
	}

	@Override
	public List<ReviewVO> selectAllReviewList(Map pagingMap) throws DataAccessException {
		List<ReviewVO> reviewList = sqlSession.selectList("mapper.r_board.selectAllReviewList",pagingMap);
		return reviewList;
	}

	
	//리뷰작성
	@Override
	public int insertNewReview(Map reviewMap) throws DataAccessException {
		int review_no= selectNewReviewNO();
		reviewMap.put("review_no", review_no);
		System.out.println(reviewMap.toString());
		sqlSession.insert("mapper.r_board.insertNewReview",reviewMap);
		return review_no;
	}

	//리뷰보기
	@Override
	public ReviewVO selectReview(int review_no) throws DataAccessException {
		return sqlSession.selectOne("mapper.r_board.selectReview", review_no);
	}

	//리뷰수정
	@Override
	public void updateReview(Map reviewMap) throws DataAccessException {
		System.out.println(reviewMap.toString());
		sqlSession.update("mapper.r_board.updateReview", reviewMap);
	}
    
	//리뷰삭제
	@Override
	public void deleteReview(int review_no) throws DataAccessException {
		sqlSession.delete("mapper.r_board.deleteReview", review_no);
		
	}
	
	//리뷰번호
	private int selectNewReviewNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.r_board.selectNewReviewNO");
	}

	@Override
	public void updatePoint(Map map) throws DataAccessException {
		sqlSession.update("mapper.r_board.updatePoint", map);
		
	}
	
	//평점으로 리스트 반환
	@Override
	public List<ReviewVO> selectReviewStar(String review_star) throws DataAccessException {
		List<ReviewVO> ReviewStarList = sqlSession.selectList("mapper.r_board.selectReviewStar",review_star);
		return ReviewStarList;
	}

	@Override
	public List<ReviewVO> selectGoodsid(int goods_id) throws DataAccessException {
		List<ReviewVO> GoodsList = sqlSession.selectList("mapper.r_board.selectGoodsid",goods_id);
		return GoodsList;
	}

	@Override
	public void updatecnt(int review_no) throws DataAccessException {
		sqlSession.update("mapper.r_board.updatecnt", review_no);
	}

	@Override
	public List<ReviewVO> goodsSearch(String detail) throws DataAccessException {
		List<ReviewVO> reviewsList = sqlSession.selectList("mapper.r_board.goodssSearch", detail);
		return reviewsList;
	}

	@Override
	public List<ReviewVO> memberSearch(String detail) throws DataAccessException {
		List<ReviewVO> reviewsList = sqlSession.selectList("mapper.r_board.membersSearch", detail);
				return reviewsList;
	}

	
}