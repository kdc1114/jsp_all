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
@WebFilter("/cate/*")
public class CategoryLoginCheck implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
		System.out.println("cate/* Filter");
		
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse res=(HttpServletResponse)response;
		HttpSession session=req.getSession();
		Object login=session.getAttribute("login");
		Object grade=session.getAttribute("grade");
		String login_cate="카테고리 관리 페이지는 로그인을 해야 합니다.";
		if(login!=null && (boolean)login) {
			if(grade!=null && (byte)grade<2) {
				chain.doFilter(request, response);
			}else {
				login_cate="카테고리 관리 권한이 없는 계정입니다.";
				session.setAttribute("login_cate", login_cate);
				res.sendRedirect(req.getContextPath()+"/login.do");
			}
		}else {
			session.setAttribute("login_cate", login_cate);
			res.sendRedirect(req.getContextPath()+"/login.do");
		}
	};

};







