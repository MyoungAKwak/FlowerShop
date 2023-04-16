package com.prj.flower.member.controller;

import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.prj.flower.common.base.BaseController;
import com.prj.flower.member.service.MemberService;
import com.prj.flower.member.vo.MemberVO;



@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl extends BaseController implements MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberVO memberVO;
	
	@Override
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(loginMap.toString());
		ModelAndView mav = new ModelAndView();
		 memberVO=memberService.login(loginMap);
		if(memberVO!= null && memberVO.getMember_id()!=null){
			HttpSession session=request.getSession();
			session=request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo",memberVO);

	        //로그인 할때 체크박스 체크시에 아이디 쿠키에 아이디 저장
	        String rememberMe = loginMap.get("remember-me");
	        if(rememberMe != null && rememberMe.equals("on")) {
	            Cookie cookie = new Cookie("rememberId", memberVO.getMember_id());
	            cookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 1주일 설정
	            response.addCookie(cookie);
	        }
			
			String action=(String)session.getAttribute("action");
			if(action!=null && action.equals("/order/orderEachGoods.do")){
				mav.setViewName("forward:"+action);
			}
			else if(action !=null&&action.equals("/review/addNewReviewForm.do")) {
				mav.setViewName("forward:"+action);
			}
			else{
				mav.setViewName("redirect:/main/main.do");	
			}
			
			
			
		}else{
			String message="로그인에 실패 하셨습니다.";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		
		//로그아웃 할때 쿠키에 있는 아이디 삭제
	  /*
		Cookie[] cookies = request.getCookies();
	    if(cookies != null) {
	        for(Cookie cookie : cookies) {
	            if(cookie.getName().equals("rememberId")) {
	                cookie.setValue("");
	                cookie.setMaxAge(0);
	                response.addCookie(cookie);
	            }
	        }
	    }
	  */
		
		
		
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		    memberService.addMember(_memberVO);
		    message  = "<script>";
		    message +=" alert('가입이 완료되었습니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('가입에 실패하셨습니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String result = memberService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	
	
	// 로그인 페이지 접속 처리
	@RequestMapping(value="/loginForm.do", method=RequestMethod.GET)
	public ModelAndView loginForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    ModelAndView mav = new ModelAndView();

	    //쿠키에서 아이디 정보 추가
	    Cookie[] cookies = request.getCookies();
	    if(cookies != null) {
	        for(Cookie cookie : cookies) {
	            if(cookie.getName().equals("rememberId")) {
	                mav.addObject("rememberId", cookie.getValue());
	                break;
	            }
	        }
	    }

	    mav.setViewName("/member/loginForm");
	    return mav;
	}
	
	
	//메일발송 테스트
		@RequestMapping(value="/navermailtest.do",method = RequestMethod.POST)
		public ResponseEntity navermailtest(@RequestParam("email") String email, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
			//인증번호 생성
			Random random = new Random();		//랜덤 함수 선언
			int createNum = 0;  			//1자리 난수
			String ranNum = ""; 			//1자리 난수 형변환 변수
	        	int letter    = 6;			//난수 자릿수:6
			String resultNum = "";  		//결과 난수
			
			for (int i=0; i<letter; i++) { 
	            		
				createNum = random.nextInt(9);		//0부터 9까지 올 수 있는 1자리 난수 생성
				ranNum =  Integer.toString(createNum);  //1자리 난수를 String으로 형변환
				resultNum += ranNum;			//생성된 난수(문자열)을 원하는 수(letter)만큼 더하며 나열
			}	
			
			// 메일 관련 정보
	        String host = "smtp.naver.com";
	        final String username = "kkjk6310";       //네이버 이메일 주소중 @ naver.com앞주소만 기재합니다.
	        final String password = "anwlroekfl00";   //네이버 이메일 비밀번호를 기재합니다.
	        int port=465;
	        
	        // 메일 내용
	        String recipient = email;    //메일을 발송할 이메일 주소를 기재해 줍니다.
	        String subject = "[오늘의 꽃] 본인인증을 위해 인증번호를 확인해주세요!";
	        String checkNum = resultNum;
	        
	        Properties props = System.getProperties();
	         
	         
	        props.put("mail.smtp.host", host);
	        props.put("mail.smtp.port", port);
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.ssl.enable", "true");
	        props.put("mail.smtp.ssl.trust", host);
	          
	        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	            String un=username;
	            String pw=password;
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(un, pw);
	            }
	        });
	        session.setDebug(true); //for debug
	          
	        Message mimeMessage = new MimeMessage(session);
	        mimeMessage.setFrom(new InternetAddress("kkjk6310@naver.com"));
	        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
	        mimeMessage.setSubject(subject);
//	        mimeMessage.setText(body);
//	        Transport.send(mimeMessage);
	        
	        MimeMultipart multipart = new MimeMultipart("related");
	        
	        BodyPart messageBodyPart = new MimeBodyPart();
	        
	        String htmlText ="<h1>인증번호 :"+ checkNum+"</h1>";
	        
	        messageBodyPart.setContent(htmlText, "text/html; charset=UTF-8");
	        multipart.addBodyPart(messageBodyPart);
	        mimeMessage.setContent(multipart);
	        Transport.send(mimeMessage);
	        
	        ResponseEntity resEntity = null;
	        resEntity =new ResponseEntity(checkNum, HttpStatus.OK);
	        return resEntity;
		}
}
