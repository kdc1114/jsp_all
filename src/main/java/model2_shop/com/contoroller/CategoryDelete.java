package model2_shop.com.contoroller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model2_shop.com.dao.CategoryDao;
@WebServlet("/cate/delete.do")
public class CategoryDelete extends HttpServlet{
	CategoryDao cateDao=new CategoryDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		int num=Integer.parseInt(req.getParameter("cate_num"));
		boolean delete=false;
		try {
			delete=cateDao.delete(num);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		HttpSession session=req.getSession();
		session.setAttribute("delete", delete);
		if(delete) {
			resp.sendRedirect("./catelist.do?page=1");
		}else {
			resp.sendRedirect("./catemodify.do?cate_num="+num);
		}
	}
}





