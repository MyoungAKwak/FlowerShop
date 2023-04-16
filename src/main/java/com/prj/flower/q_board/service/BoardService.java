package com.prj.flower.q_board.service;

import java.util.List;
import java.util.Map;

import com.prj.flower.q_board.vo.ArticleVO;


public interface BoardService {
	//목록 
	public Map listArticles(Map pagingMap) throws Exception;
	public List<ArticleVO> listNotice() throws Exception;
	//글쓰기
    public int addNewArticle(Map articleMap) throws Exception;
    //글보기 
	public ArticleVO viewArticle(int articleNO) throws Exception;
	//수정
	public void modArticle(Map articleMap) throws Exception;
	//삭제
	public void removeArticle(int articleNO) throws Exception;
	//조회수
	public void updateCnt(int articleNO) throws Exception;
	
}