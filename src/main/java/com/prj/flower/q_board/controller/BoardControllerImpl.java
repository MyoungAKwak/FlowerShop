package com.prj.flower.q_board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.prj.flower.member.vo.MemberVO;
import com.prj.flower.q_board.service.BoardService;
import com.prj.flower.q_board.vo.ArticleVO;


@Controller("q_boardController")
public class BoardControllerImpl  implements BoardController{
	private static final String ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ArticleVO articleVO;
	
	//목록창
	@Override
	@RequestMapping(value= "/board/listArticles.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String _section = request.getParameter("section");
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt(((_section == null) ?"1" :_section));
		int pageNum = Integer.parseInt(((_pageNum == null) ?"1" :_pageNum));
		
		Map pagingMap = new HashMap();
		pagingMap.put("section", section);
		pagingMap.put("pageNum", pageNum);
		
		Map articlesMap = boardService.listArticles(pagingMap);
		articlesMap.put("section",section);
		articlesMap.put("pageNum", pageNum);
		
		
		String viewName = (String)request.getAttribute("viewName");
	
		List noticeList = boardService.listNotice();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("articlesMap", articlesMap);
		mav.addObject("noticeList", noticeList);
		return mav;
	}

	//글쓰기
	@RequestMapping(value="/board/addNewArticle.do" ,method = RequestMethod.POST)	
	@ResponseBody
	@Override
	public ResponseEntity addNewArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		Map<String,Object> articleMap = new HashMap<String, Object>();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			articleMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		articleMap.put("parentNO", 0);
		articleMap.put("member_id", member_id);
		
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.addNewArticle(articleMap);
			message = "<script>";
			message += " alert('새글을 추가했습니다.');";
			message += " location.href='"+multipartRequest.getContextPath()+"/board/listArticles.do'; ";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}catch(Exception e) {

			message = " <script>";
			message +=" alert('오류가 발생했습니다. 다시 시도해 주세요');');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/board/articleForm.do'; ";
			message +=" </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	//상세글보기
	@RequestMapping(value="/board/viewArticle.do" ,method = RequestMethod.GET)
    public ModelAndView viewArticle(@RequestParam("articleNO") int articleNO,
                                    HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		articleVO=boardService.viewArticle(articleNO);
		boardService.updateCnt(articleNO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("articleVO", articleVO);
		return mav;
	}
	
  //글 수정
    @RequestMapping(value="/board/modArticle.do" ,method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public ResponseEntity modArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception{
	   
    	multipartRequest.setCharacterEncoding("utf-8");
		Map<String,Object> articleMap = new HashMap<String, Object>();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			articleMap.put(name,value);
		}
		String imageFileName= upload(multipartRequest);
		articleMap.put("imageFileName", imageFileName);
		
		String articleNO=(String)articleMap.get("articleNO");
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
	    try {
	       boardService.modArticle(articleMap);
	       
	       if(imageFileName!=null && imageFileName.length()!=0) {
	         File srcFile = new File(ARTICLE_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
	         File destDir = new File(ARTICLE_IMAGE_REPO+"\\"+articleNO);
	         FileUtils.moveFileToDirectory(srcFile, destDir, true);
	         
	         String originalFileName = (String)articleMap.get("originalFileName");
	         File oldFile = new File(ARTICLE_IMAGE_REPO+"\\"+articleNO+"\\"+originalFileName);
	         oldFile.delete();
	       }	
	       message = "<script>";
		   message += " alert('글을 수정했습니다.');";
		   message += " location.href='"+multipartRequest.getContextPath()+"/board/viewArticle.do?articleNO="+articleNO+"';";
		   message +=" </script>";
	       resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	    }catch(Exception e) {
	      File srcFile = new File(ARTICLE_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
	      srcFile.delete();
	      message = "<script>";
		  message += " alert('오류가 발생했습니다.다시 수정해주세요');";
		  message += " location.href='"+multipartRequest.getContextPath()+"/board/viewArticle.do?articleNO="+articleNO+"';";
		  message +=" </script>";
	      resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	    }
	    return resEnt;
	  }
  //글 삭제
    @Override
    @RequestMapping(value="/board/removeArticle.do" ,method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity  removeArticle(@RequestParam("articleNO") int articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
    	response.setContentType("text/html; charset=UTF-8");
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.removeArticle(articleNO);
			File destDir = new File(ARTICLE_IMAGE_REPO+"\\"+articleNO);
			FileUtils.deleteDirectory(destDir);
			
			message = "<script>";
			message += " alert('글을 삭제했습니다.');";
			message += " location.href='"+request.getContextPath()+"/board/listArticles.do';";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		       
		}catch(Exception e) {
			message = "<script>";
			message += " alert('작업중 오류가 발생했습니다.다시 시도해 주세요.');";
			message += " location.href='"+request.getContextPath()+"/board/listArticles.do';";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		    e.printStackTrace();
		}
		return resEnt;
	  }  
  

	@RequestMapping(value = "/board/*Form.do", method =  {RequestMethod.GET,RequestMethod.POST} )
	private ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}

	//한개 이미지 업로드하기
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		String imageFileName= null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName=mFile.getOriginalFilename();
			File file = new File(ARTICLE_IMAGE_REPO +"\\"+"temp"+"\\" + fileName);
			if(mFile.getSize()!=0){ //File Null Check
				if(!file.exists()){ //경로상에 파일이 존재하지 않을 경우
					file.getParentFile().mkdirs();  //경로에 해당하는 디렉토리들을 생성
					mFile.transferTo(new File(ARTICLE_IMAGE_REPO +"\\"+"temp"+ "\\"+imageFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
				}
			}
			
		}
		return imageFileName;
	}
	
	//pro30 addReply
	//답글
	//답글
		@RequestMapping(value="/board/addReply.do" ,method = RequestMethod.POST)
		@ResponseBody
		@Override
		public ResponseEntity addReply(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)throws Exception {
			multipartRequest.setCharacterEncoding("utf-8");
			
			Map articleMap = new HashMap();
			Enumeration enu=multipartRequest.getParameterNames();
			
			while(enu.hasMoreElements()){
				String name=(String)enu.nextElement();
				String value=multipartRequest.getParameter(name);
				articleMap.put(name,value);
			}
			
			HttpSession session = multipartRequest.getSession();
			MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
			String id = memberVO.getMember_id();
			
			int parentNO= (Integer) session.getAttribute("parentNO");

			
	        System.out.println(parentNO);
			
			articleMap.put("parentNO", parentNO);
			articleMap.put("member_id",id);
			
			String message;
			ResponseEntity resEnt=null;
			HttpHeaders responseHeaders = new HttpHeaders();
		    responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		    
			try {
				int articleNO = boardService.addNewArticle(articleMap);
				    
				message = "<script>";
				message += " alert('새글을 추가했습니다.');";
				message += " location.href='"+multipartRequest.getContextPath()+"/board/listArticles.do'; ";
				message +=" </script>";
			    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			    
				 
			}catch(Exception e) {

				message = " <script>";
				message +=" alert('오류가 발생했습니다. 다시 시도해 주세요');');";
				message +=" location.href='"+multipartRequest.getContextPath()+"/board/articleForm.do'; ";
				message +=" </script>";
				resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
				e.printStackTrace();
			}
			return resEnt;
		  }


		
		@Override
		@RequestMapping(value= "/board/replyForm.do", method = {RequestMethod.GET, RequestMethod.POST})
		public ModelAndView replyForm(@RequestParam("parentNO")int parentNO, HttpServletRequest request,HttpServletResponse response) throws Exception {
			String viewName = (String)request.getAttribute("viewName");
			
			HttpSession session = request.getSession();
			session.setAttribute("parentNO",parentNO);
			
			ModelAndView mav = new ModelAndView();
		    mav.setViewName(viewName);
			mav.addObject("parentNO",parentNO);
			return mav;
		}


}