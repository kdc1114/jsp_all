package model2_shop.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model2_shop.com.vo.CategoryVo;

public class CategoryDao implements CategoryDaoAble{
	private String list_sql="SELECT * FROM CATEGORY";
	private String detail_sql="SELECT * FROM CATEGORY WHERE CATE_NUM=?";
	private String insert_sql="INSERT INTO CATEGORY(name,sub) VALUES(?,?)";
	private String delete_sql="DELETE FROM CATEGORY WHERE CATE_NUM=?";
	private String update_sql="UPDATE CATEGORY SET "
			+ " name=?,"
			+ " sub=?"
			+ " WHERE cate_num=?";
	@Override
	public List<CategoryVo> list(int page) throws ClassNotFoundException, SQLException {
		List<CategoryVo> cate_list=new ArrayList<CategoryVo>();
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(list_sql);
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			CategoryVo cate=new CategoryVo();
			cate.setCate_num(rs.getInt("cate_num"));
			cate.setName(rs.getString("name"));
			cate.setSub(rs.getInt("sub"));
			cate_list.add(cate);
		}
		return cate_list;
	}

	@Override
	public CategoryVo detail(int cate_num) throws ClassNotFoundException, SQLException {
		
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(detail_sql);
		ps.setInt(1, cate_num);
		ResultSet rs=ps.executeQuery();
		CategoryVo cate=new CategoryVo();
		while(rs.next()) {
			cate.setCate_num(rs.getInt("cate_num"));
			cate.setName(rs.getString("name"));
			cate.setSub(rs.getInt("sub"));
		}
		return cate;
	}
	public CategoryVo detail1(String name) throws ClassNotFoundException,SQLException{
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement("SELECT * FROM CATEGORY WHERE NAME=?");
		ps.setString(1, name);
		ResultSet rs=ps.executeQuery();
		CategoryVo cate=new CategoryVo();
		while(rs.next()) {
			cate.setName(rs.getString("name"));
		}
		return cate;
	}

	@Override
	public boolean insert(CategoryVo cate) throws ClassNotFoundException, SQLException {
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(insert_sql);
		ps.setString(1, cate.getName());
		ps.setInt(2, cate.getSub());
		int insert=ps.executeUpdate();
		if(insert>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean update(CategoryVo cate) throws ClassNotFoundException, SQLException {
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(update_sql);
		ps.setString(1, cate.getName());
		ps.setInt(2, cate.getSub());
		ps.setInt(3, cate.getCate_num());
		int update=ps.executeUpdate();
		if(update>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean delete(int cate_num) throws ClassNotFoundException, SQLException {
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(delete_sql);
		ps.setInt(1, cate_num);
		int delete=ps.executeUpdate();
		if(delete>0) {
			return true;
		}else {
			return false;
		}
	}

}





