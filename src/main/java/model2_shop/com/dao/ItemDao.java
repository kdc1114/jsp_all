package model2_shop.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.jasper.compiler.NewlineReductionServletWriter;

import com.mysql.cj.exceptions.RSAException;

import model2_shop.com.vo.ItemVo;

public class ItemDao implements ItemDaoAble{
	private String list_sql="SELECT * FROM ITEM ORDER BY POST_TIME DESC";
	private String detail_sql="SELECT * FROM ITEM WHERE ITEM_NUM=?";
	//private String sale_list_sql=
			// 실제 사용자가 보는 아이템 리스트
			//"SELECT * FROM ITEM WHERE STATE=0 && SALE_TIME>현재날짜";
	@Override
	public List<ItemVo> list(int page) throws ClassNotFoundException, SQLException {
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(list_sql);
		ResultSet rs=ps.executeQuery();
		List<ItemVo> item_list=new ArrayList<ItemVo>();
		while(rs.next()) {
			ItemVo item=new ItemVo();
			item.setItem_num(rs.getInt("item_num"));
			item.setCount(rs.getInt("count"));
			item.setPrice(rs.getInt("price"));
			item.setCate_num(rs.getInt("cate_num"));
			item.setState(rs.getByte("state"));
			item.setColor(rs.getString("color"));
			item.setTitle(rs.getString("title"));
			item.setMain_img(rs.getString("main_img"));
			item.setDetail_img(rs.getString("detail_img"));
			item.setName(rs.getString("name"));
			item.setModel_num(rs.getString("model_num"));
			item.setMember_id(rs.getString("member_id"));
			item.setPost_time(rs.getTimestamp("post_time"));
			item.setSale_time(rs.getTimestamp("sale_time"));
			item.setSale_end_time(rs.getTimestamp("sale_end_time"));
			item_list.add(item);
		}
		return item_list;
	}
	@Override
	public ItemVo detail(int num) throws ClassNotFoundException, SQLException {
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(detail_sql);
		ps.setInt(1, num);
		// MYSQL 유니크키로 검색해서 1개만 넘어오지만 무조건 배열 타입이다.
		// (MYSQL은 몆개가 오는지 모른다 그래서 무조건 배열 타입)
		ItemVo item=new ItemVo();
		ResultSet rs=ps.executeQuery(); 
		if(rs.next()) {
			item.setItem_num(rs.getInt("item_num"));
			item.setCount(rs.getInt("count"));
			item.setPrice(rs.getInt("price"));
			item.setCate_num(rs.getInt("cate_num"));
			item.setState(rs.getByte("state"));
			item.setColor(rs.getString("color"));
			item.setTitle(rs.getString("title"));
			item.setMain_img(rs.getString("main_img"));
			item.setDetail_img(rs.getString("detail_img"));
			item.setName(rs.getString("name"));
			item.setModel_num(rs.getString("model_num"));
			item.setMember_id(rs.getString("member_id"));
			item.setPost_time(rs.getTimestamp("post_time"));
			item.setSale_time(rs.getTimestamp("sale_time"));
			item.setSale_end_time(rs.getTimestamp("sale_end_time"));
		}
		return item;
	}
	@Override
	public boolean insert(ItemVo item) throws ClassNotFoundException, SQLException {
		String sql="INSERT INTO ITEM "
				+ "(cate_num,color,count,detail_img,main_img,"
				+ "member_id,model_num,name,price,state,title,sale_time,sale_end_time) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(sql);
		ps.setInt(1, item.getCate_num());
		ps.setString(2, item.getColor());
		ps.setInt(3, item.getCount());
		ps.setString(4, item.getDetail_img());
		ps.setString(5, item.getMain_img());
		ps.setString(6, item.getMember_id());
		ps.setString(7, item.getModel_num());
		ps.setString(8, item.getName());
		ps.setInt(9, item.getPrice());
		ps.setByte(10, item.getState());
		ps.setString(11, item.getTitle());
		ps.setTimestamp(12, item.getSale_time());
		ps.setTimestamp(13, item.getSale_end_time());
		int insert=ps.executeUpdate();
		if(insert>0) { // 정확히 따지면 1일 때
			return true;
		}else {
			return false;
		}
	}
	@Override
	public boolean update(ItemVo item) throws ClassNotFoundException, SQLException {
		String update_sql="UPDATE ITEM SET NAME=?,TITLE=?,COUNT=?,COLOR=?,"
				+ " PRICE=?,CATE_NUM=?,MAIN_IMG=?,DETAIL_IMG=?,"
				+ " MODEL_NUM=?,MEMBER_ID=?,sale_time=?,sale_end_time=?,"
				+ " STATE=? WHERE ITEM_NUM=?";
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(update_sql);
		ps.setString(1, item.getName());
		ps.setString(2, item.getTitle());
		ps.setInt(3, item.getCount());
		ps.setString(4, item.getColor());
		ps.setInt(5, item.getPrice());
		ps.setInt(6, item.getCate_num());
		ps.setString(7, item.getMain_img());
		ps.setString(8, item.getDetail_img());
		ps.setString(9, item.getModel_num());
		ps.setString(10, item.getMember_id());
		ps.setTimestamp(11, item.getSale_time());
		ps.setTimestamp(12, item.getSale_end_time());
		ps.setByte(13, item.getState());
		ps.setInt(14, item.getItem_num());
		int update=ps.executeUpdate();
		if(update>0) {
			return true;
		}else {
			return false;
		}
	}
	@Override
	public boolean delete(int num) throws ClassNotFoundException, SQLException {
		String delete_sql="DELETE FROM ITEM WHERE ITEM_NUM=?";
		Connection conn=ShopConnection.getConnection();
		PreparedStatement ps=conn.prepareStatement(delete_sql);
		ps.setInt(1, num);
		int delete=ps.executeUpdate();
		if(delete>0) {
			return true;
		}else {
			return false;
		}
	}
	@Override
	public boolean delete(int[] num) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public List<ItemVo> list(int page, String writer) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public ItemVo detail(int num, String writer) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public boolean delete(int num, String writer) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public boolean delete(int[] num, String writer) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public List<ItemVo> sale_list(int page) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	// 톰캣의 메인이 아니고 직접 제작한 자바 어플
	public static void main(String[] args) {
		try {
			//System.out.println(new ItemDao().list(0));
			System.out.println(new ItemDao().detail(1002));
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
}





