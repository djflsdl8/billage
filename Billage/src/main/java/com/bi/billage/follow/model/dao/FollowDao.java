package com.bi.billage.follow.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bi.billage.board.model.vo.ReviewBoard;
import com.bi.billage.common.model.vo.PageInfo;
import com.bi.billage.follow.model.vo.Follow;
import com.bi.billage.follow.model.vo.Star;
import com.bi.billage.user.model.vo.User;
@Repository
public class FollowDao {
	
	public User selectLoginUser(SqlSession sqlSession, int userNo) {
		
		return (User)sqlSession.selectOne("followMapper.selectLoginUser", userNo);
		
	}
	
	public ArrayList<User> selectFollowingList(SqlSession sqlSession, int userNo) {
		return (ArrayList) sqlSession.selectList("followMapper.selectFollowingList", userNo);
	}
	
	public ArrayList<User> selectFollowerList1(SqlSession sqlSession, int userNo) {
		return (ArrayList) sqlSession.selectList("followMapper.selectFollowerList1", userNo);
	}
	
	public ArrayList<User> selectFollowerList2(SqlSession sqlSession, int userNo) {
		return (ArrayList) sqlSession.selectList("followMapper.selectFollowerList2", userNo);
	}
	
	public int insertFollow (SqlSession sqlSession, Follow follow) {
		return (int)sqlSession.insert("followMapper.insertFollow", follow);
	}
	
	public int deleteFollow (SqlSession sqlSession, Follow follow) {
		return (int)sqlSession.delete("followMapper.deleteFollow", follow);
	}
	
	public ArrayList<ReviewBoard> selectReviewList (SqlSession sqlSession, int userNo, PageInfo pi) {
		
		int offset =(pi.getCurrentPage()-1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList) sqlSession.selectList("followMapper.selectReviewList", userNo, rowBounds);
	}
	
	public User selectUser(SqlSession sqlSession, int userNo) {
		return (User)sqlSession.selectOne("followMapper.selectUser",userNo);
	}
	
	public Star selectStar(SqlSession sqlSession, int userNo) {
		return (Star)sqlSession.selectOne("followMapper.selectStar", userNo);
	}
	
	public ArrayList<ReviewBoard> selectGoodReview (SqlSession sqlSession, Follow follow){
		return (ArrayList)sqlSession.selectList("followMapper.selectGoodReview", follow);
	}
	
	public ArrayList<ReviewBoard> selectBadReview(SqlSession sqlSession, Follow follow) {
		return (ArrayList)sqlSession.selectList("followMapper.selectBadReview", follow);
	}
	
	public int selectReviewCount(SqlSession sqlSession, int userNo) {
		return (int)sqlSession.selectOne("followMapper.selectReviewCount", userNo);
	}
	
	public int checkFollow(SqlSession sqlSession, Follow follow) {
		return (int)sqlSession.selectOne("followMapper.checkFollow", follow);
	}

}
