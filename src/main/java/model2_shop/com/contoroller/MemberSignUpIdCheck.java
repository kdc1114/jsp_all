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
@WebServlet("/mem_new/id_check.do")
public class MemberSignUpIdCheck extends HttpServlet{
	MemberDao memDao=new MemberDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String id=req.getParameter("id");
		
		resp.setContentType("json/application; charset=UTF-8");
		// java에 JSON 라이브러리가 없어서 추가해서 사용해야한다.
		MemberVo mem=null;
		try {
			mem=memDao.detail(id);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if(mem.getId()==null) {
			resp.getWriter().append("{ \"id_check\" : true}");
		}else {
			resp.getWriter().append("{ \"id_check\" : false}");
		}
	}
}
