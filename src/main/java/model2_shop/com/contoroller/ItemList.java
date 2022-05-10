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

import model2_shop.com.dao.ItemDao;
import model2_shop.com.vo.ItemVo;
@WebServlet("/item/list.do")
public class ItemList extends HttpServlet{
	ItemDao itemDao=new ItemDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String page_str=req.getParameter("page");
		int page=(page_str!=null)?Integer.parseInt(page_str):1;
		
		List<ItemVo> item_list=new ArrayList<ItemVo>();
		try {
			item_list=itemDao.list(page);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.setAttribute("item_list", item_list);
		req.getRequestDispatcher("./list.jsp").forward(req, resp);
	}
}










