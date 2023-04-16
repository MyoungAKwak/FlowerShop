package com.prj.flower.r_board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.prj.flower.r_board.vo.ReviewVO;




public interface BoardController {
	
	//리뷰목록
	public ModelAndView listReviews(@RequestParam Map<String, String> dateMap,HttpServletRequest request,HttpServletResponse response) throws Exception;
	
	//리뷰쓰기
	public ResponseEntity addNewReview(MultipartHttpServletRequest multipartRequest,HttpServletResponse response) throws Exception;
	
	//리뷰보기
	public ModelAndView viewReview(@RequestParam("review_no") int review_no,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//리뷰수정
	public ResponseEntity modReview(MultipartHttpServletRequest multipartRequest,  HttpServletResponse response) throws Exception;
	
	//리뷰삭제
	public ResponseEntity  removeReview(@RequestParam("review_no") int review_no,
                              HttpServletRequest request, HttpServletResponse response) throws Exception;

	//상품번호로 리스트 출력
	public List selectGoodsid(@RequestParam("goods_id")int goods_id,
										HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//상품 or 작성자 검색
	public ModelAndView searchReview(@RequestParam("search") String search,@RequestParam("detail") String detail, HttpServletRequest request, HttpServletResponse response ) throws Exception;
	
}