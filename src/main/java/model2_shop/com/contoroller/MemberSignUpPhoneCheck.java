package model2_shop.com.contoroller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2_shop.com.dao.MemberDao;
import model2_shop.com.vo.MemberVo;
@WebServlet("/mem_new/phone_check.do")
public class MemberSignUpPhoneCheck extends HttpServlet{
	MemberDao memDao=new MemberDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String phone=req.getParameter("phone");
		
		resp.setContentType("json/application; charset=UTF-8");
		MemberVo mem=null;
		try {
			mem=memDao.detail2(phone);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if(mem.getPhone()==null) {
			resp.getWriter().append("{ \"phone_check\" : true}");
		}else {
			resp.getWriter().append("{ \"phone_check\" : false}");
		}
	}
}
