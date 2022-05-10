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

import model2_shop.com.dao.CategoryDao;
import model2_shop.com.vo.CategoryVo;
@WebServlet("/cate/catelist.do")
public class CategoryList extends HttpServlet{
	private CategoryDao cateDao=new CategoryDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String page_str=req.getParameter("page");
		int page=(page_str!=null)?Integer.parseInt(page_str):1;
		
		List<CategoryVo> cate_list=new ArrayList<CategoryVo>();
		try {
			cate_list=cateDao.list(page);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.setAttribute("cate_list", cate_list);
		req.getRequestDispatcher("./catelist.jsp").forward(req, resp);
	}
}







