package model2_shop.com.contoroller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model2_shop.com.dao.ItemDao;
@WebServlet("/item/delete.do")
public class ItemDelete extends HttpServlet{
	ItemDao itemDao=new ItemDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		int num=Integer.parseInt(req.getParameter("item_num"));
		boolean delete=false;
		try {
			delete=itemDao.delete(num);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		HttpSession session=req.getSession();
		session.setAttribute("delete", delete);
		if(delete) {
			resp.sendRedirect("./list.do?page=1");
		}else {
			resp.sendRedirect("./modify.do?item_num="+num);
		}
	}
}






