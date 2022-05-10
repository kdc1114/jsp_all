package model2_shop.com.contoroller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import model2_shop.com.dao.MemberDao;
import model2_shop.com.vo.MemberVo;
@WebServlet("/mem/ajax.do")
public class MemberAjax extends HttpServlet{
	MemberDao memDao=new MemberDao();
	MemberVo mem=new MemberVo();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String id=req.getParameter("id");
		resp.setContentType("application/json; charset=UTF-8");
		try {
			if(id==null) {
				resp.getWriter().append(memDao.list(0).toString());
			}else {
				resp.getWriter().append(memDao.detail(id).toString());
			};
		} catch (ClassNotFoundException | IOException | SQLException e) {
			e.printStackTrace();
		};
	};
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
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
		};
		mem.setGrade(Byte.parseByte(json.getString("grade")));
		
		boolean insert=false;
		try {
			insert=memDao.insert(mem);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		};
		resp.getWriter().append("{ \"insert\" : "+insert+"}");
	};
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		StringBuffer json_str=new StringBuffer();
		BufferedReader br=req.getReader(); // 본문 헤더의 문자열을 읽는 객체
		String line="";
		while((line=br.readLine())!=null) {
			json_str.append(line);
		};
		JSONObject json=new JSONObject(json_str.toString());
		
		
		mem.setId(json.getString("id"));
		mem.setPw(json.getString("pw"));
		mem.setPhone(json.getString("phone"));
		mem.setEmail(json.getString("email"));
		mem.setName(json.getString("name"));
		mem.setAddress(json.getString("address"));
		mem.setAddress_detail(json.getString("address_detail"));
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-DD-mm");
		try {
			mem.setBirth(sdf.parse(json.getString("birth")));
		} catch (JSONException | ParseException e) {
			e.printStackTrace();
		};
		mem.setGrade(Byte.parseByte(json.getString("grade")));
		
		boolean update=false;
		try {
			update=memDao.update(mem);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		};
		resp.getWriter().append("{ \"update\" : "+update+" }");
	};
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String id=req.getParameter("id");
		
		boolean delete=false;
		try {
			if(id!=null) {
				delete=memDao.delete(id);
			};
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		};
		resp.getWriter().append("{ \"delete\" : "+delete+" }");
	};
}







