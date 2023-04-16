package com.prj.flower.q_board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.prj.flower.q_board.dao.BoardDAO;
import com.prj.flower.q_board.vo.ArticleVO;



@Service("q_boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl  implements BoardService{
	@Autowired
	BoardDAO boardDAO;
	
	@Override
	public Map listArticles(Map pagingMap) throws Exception {
		Map articlesMap = new HashMap();
		List<ArticleVO> articlesList = boardDAO.selectAllArticlesList(pagingMap);
		int totArticles = boardDAO.selectTotArticles();
		articlesMap.put("articlesList", articlesList);
		articlesMap.put("totArticles", totArticles);
		return articlesMap;
	}
	
	@Override
	public List<ArticleVO> listNotice() throws Exception {
		List<ArticleVO> noticeList =  boardDAO.selecnoticeList();
        return noticeList;
	}
	
	//단일 이미지 추가하기
	@Override
	public int addNewArticle(Map articleMap) throws Exception{
		
		return boardDAO.insertNewArticle(articleMap);
	}
	
	
	 //단일 파일 보이기
	@Override
	public ArticleVO viewArticle(int articleNO) throws Exception {
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		boardDAO.updateCnt(articleNO);
		return articleVO;
	}
	
	@Override
	public void modArticle(Map articleMap) throws Exception {
		boardDAO.updateArticle(articleMap);
	}
	
	@Override
	public void removeArticle(int articleNO) throws Exception {
		boardDAO.deleteArticle(articleNO);
	}



	@Override
	public void updateCnt(int articleNO) throws Exception {
		boardDAO.updateCnt(articleNO);
	}

	

	




	
}