package model2_shop.com.contoroller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model2_shop.com.dao.CategoryDao;
import model2_shop.com.vo.CategoryVo;
@WebServlet("/cate/ajax.do")
public class CategoryAjax extends HttpServlet{
	CategoryVo cate=new CategoryVo();
	CategoryDao cateDao=new CategoryDao();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String cate_num=req.getParameter("cate_num");
		resp.setContentType("application/json; charset=UTF-8");
		try {
			if(cate_num==null) {
				resp.getWriter().append(cateDao.list(0).toString());
			}else {
				resp.getWriter().append(cateDao.detail(Integer.parseInt(cate_num)).toString());
			};
		} catch (Exception e) {
			e.printStackTrace();
		};
	};
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		// 헤더 본문에 문자열에서 JSON으로 보낸 파라미터 불러오기
		StringBuffer jb=new StringBuffer();
		BufferedReader br= req.getReader();
		String line=null;
		while((line=br.readLine())!=null) {
			jb.append(line);
		};
		JSONObject json=new JSONObject(jb.toString());
		cate.setName(json.getString("name"));
		cate.setSub(json.getInt("sub"));
		boolean insert=false;
		try {
			insert=cateDao.insert(cate);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		};
		resp.getWriter().append("{ \"insert\" : "+insert+"}");
	};
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		StringBuffer json_str=new StringBuffer();
		BufferedReader br=req.getReader();
		String line="";
		while((line=br.readLine())!=null) {
			json_str.append(line);
		};
		JSONObject json=new JSONObject(json_str.toString());
		
		cate.setCate_num(json.getInt("cate_num"));
		cate.setName(json.getString("name"));
		cate.setSub(json.getInt("sub"));
		
		boolean update=false;
		try {
			update=cateDao.update(cate);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		};
		resp.getWriter().append("{ \"update\" : "+update+" }");
	};
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		String cate_num=req.getParameter("cate_num");
		
		boolean delete=false;
		try {
			delete=cateDao.delete(Integer.parseInt(cate_num));
		} catch (NumberFormatException | ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		};
		resp.getWriter().append("{ \"delete\" : "+delete+" }");
	};
}







