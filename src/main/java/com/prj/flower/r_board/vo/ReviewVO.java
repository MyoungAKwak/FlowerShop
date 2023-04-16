package com.prj.flower.r_board.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("reviewVO")
public class ReviewVO {
	private int review_no;
	private String member_id;
	private int goods_id;
	private String review_content;
	private Date  review_date;
	private String review_star;
	private String fileName;
	private int cnt;
	private String reviewfilename;
	private String member_name;
	//리뷰테이블에서 굿즈이름에 필요하다.
	private String goods_title;
	
	public ReviewVO() {
		
	}

	

	public int getReview_no() {
		return review_no;
	}





	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}





	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	public int getGoods_id() {
		return goods_id;
	}


	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}


	public String getReview_content() {
		return review_content;
	}


	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public Date getReview_date() {
		return review_date;
	}


	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}


	



	public String getReview_star() {
		return review_star;
	}



	public void setReview_star(String review_star) {
		this.review_star = review_star;
	}



	public String getImageFileName() {
		try {
			if (fileName != null && fileName.length() != 0) {
				fileName = URLDecoder.decode(fileName, "UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return fileName;
	}

	public void setImageFileName(String filename) {
		try {
			if(filename!= null && filename.length()!=0) {
				this.fileName = URLEncoder.encode(filename,"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}





	public String getGoods_title() {
		return goods_title;
	}





	public void setGoods_title(String goods_title) {
		this.goods_title = goods_title;
	}



	public String getFileName() {
		return fileName;
	}



	public void setFileName(String fileName) {
		this.fileName = fileName;
	}



	public int getCnt() {
		return cnt;
	}



	public void setCnt(int cnt) {
		this.cnt = cnt;
	}



	public String getReviewfilename() {
		return reviewfilename;
	}



	public void setReviewfilename(String reviewfilename) {
		this.reviewfilename = reviewfilename;
	}



	public String getMember_name() {
		return member_name;
	}



	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}


	
	
	
	
	
	
	
	
	
}
