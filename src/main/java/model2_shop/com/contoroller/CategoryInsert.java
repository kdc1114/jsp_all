package model2_shop.com.contoroller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2_shop.com.dao.CategoryDao;
import model2_shop.com.vo.CategoryVo;

@WebServlet("/cate/cateinsert.do")
public class CategoryInsert extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		System.out.println("cateinsert.do doGet()");
		req.getRequestDispatcher("./cateinsert.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		System.out.println("cateinsert.do doPost()");
		CategoryVo cate=new CategoryVo();
		req.setCharacterEncoding("UTF-8");
		cate.setCate_num(Integer.parseInt(req.getParameter("cate_num")));
		cate.setName(req.getParameter("name"));
		cate.setSub(Integer.parseInt(req.getParameter("sub")));
		System.out.println(cate);
		CategoryDao cateDao=new CategoryDao();
		boolean insert=false;
		try {
			insert=cateDao.insert(cate);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getSession().setAttribute("cateinsert", insert);
		if(insert) {
			resp.sendRedirect("catelist.do");
		}else {
			resp.sendRedirect("cateinsert.do");
		}
	}
}







