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
@WebServlet("/cate/name_check.do")
public class CategoryNameCheck extends HttpServlet{
	CategoryDao cateDao=new CategoryDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String name=req.getParameter("name");
		
		resp.setContentType("json/application; charset=UTF-8");
		CategoryVo cate=null;
		try {
			cate=cateDao.detail1(name);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if(cate.getName()==null) {
			resp.getWriter().append("{ \"name_check\" : true}");
		}else {
			resp.getWriter().append("{ \"name_check\" : false}");
		}
	}
}
