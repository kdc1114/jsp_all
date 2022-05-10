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
@WebServlet("/cate/catemodify.do")
public class CategoryModify extends HttpServlet{
	private CategoryDao cateDao=new CategoryDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		int num=Integer.parseInt(req.getParameter("cate_num"));
		CategoryVo cate=new CategoryVo();
		try {
			cate=cateDao.detail(num);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.setAttribute("cate", cate);
		req.getRequestDispatcher("./catemodify.jsp").forward(req, resp);
	}
}





