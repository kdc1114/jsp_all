package model2_shop.com.dao;

import java.sql.SQLException;
import java.util.List;

import model2_shop.com.vo.ItemCommentVo;

// 상사 -> 부하에게 서비스 이렇게 저렇게 만들기로 했으니 구현하세요!
public interface ItemCommentDaoAble {
	public List<ItemCommentVo> list(int item_num,int page) throws ClassNotFoundException, SQLException;
	
	public ItemCommentVo detail(int comment_num) throws ClassNotFoundException, SQLException;
	
	public boolean insert(ItemCommentVo vo) throws ClassNotFoundException, SQLException;
	
	public boolean update(ItemCommentVo vo) throws ClassNotFoundException, SQLException;
	
	// 회원삭제 => 위험 외래키로 참조하는 테이블이 많이 때문에
	public boolean delete(int comment_num) throws ClassNotFoundException, SQLException;
	// 외래키인 아이템 넘버로 복수 삭제
	public int deleteItemNum(int item_num) throws ClassNotFoundException, SQLException;
}
