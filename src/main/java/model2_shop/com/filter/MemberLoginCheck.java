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
@WebFilter("/mem/*")
public class MemberLoginCheck implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
		System.out.println("mem/* Filter");
		// forward 로 요청한 /mem/login.jsp는 가로채지 않는다.
		
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse res=(HttpServletResponse)response;
		HttpSession session=req.getSession();
		Object login=session.getAttribute("login");
		Object grade=session.getAttribute("grade");
		String login_msg="멤버 관리 페이지는 로그인을 해야 합니다.";
		if(login!=null && (boolean)login) {
			if(grade!=null && (byte)grade==0) {
				chain.doFilter(request, response); // 원래 가려했던 경로로 이동
			}else {
				login_msg="멤버 관리 권한이 없는 계정입니다.";
				session.setAttribute("login_msg", login_msg); // 메세지 내용
				res.sendRedirect(req.getContextPath()+"/login.do");
			};
		}else {
			session.setAttribute("login_msg", login_msg);
			res.sendRedirect(req.getContextPath()+"/login.do");
		};
	};

};











