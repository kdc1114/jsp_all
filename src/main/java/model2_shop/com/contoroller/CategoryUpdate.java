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
@WebServlet("/cate/update.do")
public class CategoryUpdate extends HttpServlet{
	CategoryDao cateDao=new CategoryDao();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		CategoryVo cate=new CategoryVo();
		req.setCharacterEncoding("UTF-8");
		cate.setCate_num(Integer.parseInt(req.getParameter("cate_num")));
		cate.setName(req.getParameter("name"));
		cate.setSub(Integer.parseInt(req.getParameter("sub")));
		System.out.println(cate);
		boolean update=false;
		try {
			update=cateDao.update(cate);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if(update) {
			resp.sendRedirect("./catelist.do?page=1&login=true");
		}else {
			resp.sendRedirect("./catemodify.do?cate_num="+cate.getCate_num()+"&login=false");
		}
	}
}






