package model2_shop.com.dao;

import java.sql.SQLException;
import java.util.List;

import model2_shop.com.vo.CategoryVo;

public interface CategoryDaoAble {
	// 카테고리 리스트
	public List<CategoryVo> list(int page) throws ClassNotFoundException,SQLException;
	
	// 카테고리 수정 , 수정페이지 , 상세페이지
	public CategoryVo detail(int cate_num) throws ClassNotFoundException,SQLException;
	public CategoryVo detail1(String name) throws ClassNotFoundException,SQLException;
	
	// 카테고리 등록 , 추가
	public boolean insert(CategoryVo cate) throws ClassNotFoundException,SQLException;
	
	// 카테고리 수정
	public boolean update(CategoryVo cate) throws ClassNotFoundException,SQLException;
	
	// 카테고리 삭제
	public boolean delete(int cate_num) throws ClassNotFoundException,SQLException;
}
