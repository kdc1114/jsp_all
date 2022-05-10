package model2_shop.com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebFilter("/item/*")
public class ItemLoginCheck implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
		System.out.println("item/* Filter");
		//로그인이 되어 있고 등급이 1이상인 사람(0,1)만 접근할 수 있도록 작성하세요!
		
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse res=(HttpServletResponse)response;
		HttpSession session=req.getSession();
		Object login=session.getAttribute("login");
		Object grade=session.getAttribute("grade");
		String login_item="아이템 관리 페이지는 로그인을 해야합니다.";
		if(login!=null && (boolean)login) {
			if(grade!=null && (byte)grade==0 || (byte)grade==1) {
				chain.doFilter(request, response);
			}else {
				login_item="아이템 관리 권한이 없는 계정입니다.";
				session.setAttribute("login_msg", login_item);
				res.sendRedirect(req.getContextPath()+"/login.do");
			};
		}else {
			session.setAttribute("login_item", login_item);
			res.sendRedirect(req.getContextPath()+"/login.do");
		};
	};

};










