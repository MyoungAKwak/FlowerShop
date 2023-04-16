package com.prj.flower.q_board.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.prj.flower.q_board.vo.ArticleVO;




public interface BoardDAO {
	
	//페이징
	public int selectTotArticles();
	//목록
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException;
	public List selecnoticeList() throws DataAccessException;
	
	//글쓰기
	public int insertNewArticle(Map articleMap) throws DataAccessException;
	
	// 글 보
	public ArticleVO selectArticle(int articleNO) throws DataAccessException;
	
	//글 수정
	public void updateArticle(Map articleMap) throws DataAccessException;
	
	//글삭제
	public void deleteArticle(int articleNO) throws DataAccessException;
	
	//조회수
	public void updateCnt(int articleNO) throws DataAccessException;
	

	
	
	


}