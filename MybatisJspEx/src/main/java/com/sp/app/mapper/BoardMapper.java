package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Board;

@Mapper
public interface BoardMapper {
	public void insertBoard(Board dto) throws SQLException;
	public void updateBoard(Board dto) throws SQLException;
	public void deleteBoard(long num) throws SQLException;
	public void updateHitCount(long num) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<Board> listBoard(Map<String, Object> map);
	public Board findById(long num);
	public Board findByPrev(Map<String, Object> map);
	public Board findByNext(Map<String, Object> map);
}
