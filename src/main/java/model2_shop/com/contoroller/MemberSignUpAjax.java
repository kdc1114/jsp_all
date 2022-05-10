package model2_shop.com.contoroller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import model2_shop.com.dao.MemberDao;
import model2_shop.com.vo.MemberVo;
@WebServlet("/mem_new/ajax.do")
public class MemberSignUpAjax extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		MemberVo mem=new MemberVo();
		MemberDao memDao=new MemberDao();
		// 헤더 본문에 문자열에서 JSON으로 보낸 파라미터 불러오기
		StringBuffer jb=new StringBuffer();
		BufferedReader reader=req.getReader();
		String line=null;
		while((line=reader.readLine())!=null) {
			jb.append(line);
		};
		JSONObject json=new JSONObject(jb.toString());
		mem.setId(json.getString("id"));
		mem.setPw(json.getString("pw"));
		mem.setPhone(json.getString("phone"));
		mem.setEmail(json.getString("email"));
		mem.setName(json.getString("name"));
		mem.setAddress(json.getString("address"));
		mem.setAddress_detail(json.getString("address_detail"));
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-mm-DD");
		try {
			mem.setBirth(sdf.parse(json.getString("birth")));
		} catch (JSONException | ParseException e) {
			e.printStackTrace();
		}
		mem.setGrade(Byte.parseByte(json.getString("grade")));
		
		boolean insert=false;
		try {
			insert=memDao.insert(mem);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		resp.getWriter().append("{ \"insert\" : "+insert+"}");
	}
}
