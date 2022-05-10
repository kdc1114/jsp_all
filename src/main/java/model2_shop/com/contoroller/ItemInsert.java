package model2_shop.com.contoroller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2_shop.com.dao.ItemDao;
import model2_shop.com.vo.ItemVo;
@WebServlet("/item/iteminsert.do")
public class ItemInsert extends HttpServlet{
	ItemDao itemDao=new ItemDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		req.getRequestDispatcher("./iteminsert.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		ItemVo item=new ItemVo();
		req.setCharacterEncoding("UTF-8");
		item.setName(req.getParameter("name"));
		item.setTitle(req.getParameter("title"));
		item.setModel_num(req.getParameter("model_num"));
		item.setMember_id(req.getParameter("member_id"));
		item.setPrice(Integer.parseInt(req.getParameter("price")));
		item.setCate_num(Integer.parseInt(req.getParameter("cate_num")));
		item.setCount(Integer.parseInt(req.getParameter("count")));
		item.setColor(req.getParameter("color"));
		item.setMain_img(req.getParameter("main_img"));
		item.setDetail_img(req.getParameter("detail_img"));
		item.setState(Byte.parseByte(req.getParameter("state")));
		boolean insert=false;
		try {
			insert=itemDao.insert(item);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getSession().setAttribute("insert", insert);
		if(insert) {
			resp.sendRedirect("list.do");
		}else {
			resp.sendRedirect("iteminsert.do");
		}
	}
}







