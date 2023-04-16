package com.prj.flower.q_board.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.prj.flower.q_board.vo.ArticleVO;


@Repository("q_boardDAO")
public  class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int selectTotArticles() {
		int totArticles = sqlSession.selectOne("mapper.board.selectTotArticles");
		return totArticles;
	}

	@Override
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.board.selectAllArticlesList",pagingMap);
		return articlesList;
	}
	
	@Override
	public List selecnoticeList() throws DataAccessException {
		List<ArticleVO> noticeList = sqlSession.selectList("mapper.board.selectNotice");
		return noticeList;
	}


	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.board.insertNewArticle",articleMap);
		return articleNO;
	}
	
	
	@Override
	public ArticleVO selectArticle(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectArticle", articleNO);
	}

	@Override
	public void updateArticle(Map articleMap) throws DataAccessException {
		sqlSession.update("mapper.board.updateArticle", articleMap);
	}

	@Override
	public void deleteArticle(int articleNO) throws DataAccessException {
		sqlSession.delete("mapper.board.deleteArticle", articleNO);
		
	}
	
	private int selectNewArticleNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewArticleNO");
	}

	@Override
	public void updateCnt(int articleNO) throws DataAccessException {
		sqlSession.update("mapper.board.update_cnt",articleNO);
    }

	




	





}