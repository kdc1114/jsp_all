package model2_shop.com.contoroller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2_shop.com.dao.MemberDao;
import model2_shop.com.vo.MemberVo;

@WebServlet("/mem/list.do")
public class MemberList extends HttpServlet{
	private MemberDao memDao=new MemberDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		Object login=req.getSession().getAttribute("login");
		if(login==null || !(boolean)login) {		
			resp.sendRedirect(req.getContextPath()+"/login.do");
		}else {
			String page_str=req.getParameter("page");
			int page=(page_str!=null)?Integer.parseInt(page_str):1;
			
			List<MemberVo> mem_list=new ArrayList<MemberVo>(); // []
			try {
				mem_list=memDao.list(page);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
			req.setAttribute("mem_list", mem_list);
			req.getRequestDispatcher("./list.jsp").forward(req, resp);
			// 오류가 발생하면 mem_list가 없어서 null이 되고 형변환 시 오류가 발생!
			// setAttribute : jsp에서 getAttribute로 받기위해("객체명",객체)
			/* getRequestDispatcher(jsp파일).forward(req,resp) : 페이지를 이동시키는메서드
			 * 이동하면서 현재페이지에서 사용하던 HttpServletRequest 와 
			 * HttpServletResponse 객체를 인자값으로 전달하는데 내장객체
			 * 인 req 와 resp를 넘겨준다
			 */		
		};
	};
};
