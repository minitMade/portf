package com.picxen.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.picxen.member.model.MemberService;
import com.picxen.photo.model.CategoryBean;
import com.picxen.photo.model.CategoryService;

public class CommonHandlerInterceptor extends HandlerInterceptorAdapter {
	private CategoryService cgService;
	
	private MemberService memService;
	
	//setter
	public void setCgService(CategoryService cgService){
		this.cgService = cgService;
		System.out.println("종속객체주입:CommonHandlerInterceptor"+"setCgService()");
	}
	
	public void setMemService(MemberService memService){
		this.memService = memService;
		System.out.println("종속객체 주입:CommonHandlerInterceptor"+"setMemService()");
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2)
		throws Exception{
		//컨트롤러전 수행전 수행됨
		//클라이언트 요청을 컨트롤러에 전달하기 전에 호출됨
		System.out.println("preHandle() 메서드 호출");
		//모든 페이지 카테고리 목록이 보여져야 하므로 preHandle에서 처리
		
		//db작업-select
		List<CategoryBean> cgList = new ArrayList<CategoryBean>();
		try{
			cgList = cgService.listCategoryAll();
			System.out.println("카테고리 목록 조회 성공, cgList.size()"+cgList.size());
		}catch(SQLException e){
			System.out.println("카테고리 목록 조회 실패");
			e.printStackTrace();
		}
		
		
		//유저 아이콘 조회
			String iconUserid = (String)request.getSession().getAttribute("userid");
			System.out.println("iconUserid="+iconUserid);
			
			String userIcon="";
		if(iconUserid != null && !iconUserid.isEmpty()){	
			try{
			userIcon = memService.getMyIcon(iconUserid);
			System.out.println("유저 아바타 조회 성공"+userIcon);
			}catch(SQLException e){
				System.out.println("유저 아이콘 조회 실패");
				e.printStackTrace();
			}
		}
		request.setAttribute("userIcon", userIcon);
		request.setAttribute("cgList", cgList);
		request.setAttribute("totalRecord", cgList.size());
		
		return true;
	}
	
	
}//class
