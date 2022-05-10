package model2_shop.com.contoroller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2_shop.com.dao.MemberDao;
import model2_shop.com.vo.MemberVo;

@WebServlet("/mem/insert.do")
public class MemberInsert extends HttpServlet{
	// url 에 요청 정보를 포함하는 get 방식 호출시 doGet()을 톰캣이 호출
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		System.out.println("insert.do doGet()");
		req.getRequestDispatcher("./insert.jsp").forward(req, resp);
	}
	// 양식 제출시 요청의 헤더에 요청정보를 포함하는 post 방식 호출 시 톰캣이 호출
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		System.out.println("insert.do doPost()");
		MemberVo mem=new MemberVo();
		req.setCharacterEncoding("UTF-8");
		mem.setId(req.getParameter("id"));
		mem.setPw(req.getParameter("pw"));
		mem.setName(req.getParameter("name"));
		mem.setAddress(req.getParameter("address"));
		mem.setAddress_detail(req.getParameter("address_detail"));
		mem.setEmail(req.getParameter("email"));
		mem.setPhone(req.getParameter("phone"));
		mem.setGrade(Byte.parseByte(req.getParameter("grade")));
		// 문자열을 데이트로 형변환
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-DD-mm");
		//mem.setSignup_time(Timestamp.valueOf(req.getParameter("signup_time")));
		try {
			mem.setBirth(sdf.parse(req.getParameter("birth")));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		System.out.println(mem);
		// 성공 -> list.do , 등록 성공 alert
		// 실패 -> insert.do 등록 실패 alert
		
		MemberDao memDao=new MemberDao();
		boolean insert=false;
		try {
			insert=memDao.insert(mem);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getSession().setAttribute("insert", insert);
		if(insert) {
			resp.sendRedirect("list.do");
		}else {
			resp.sendRedirect("insert.do");
		}
	}
}








