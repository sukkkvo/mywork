package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Demo;

@Mapper
public interface DemoMapper {
	public void insertDemo1(Demo dto) throws SQLException;
	public void insertDemo2(Demo dto) throws SQLException;
	public void insertDemo3(Demo dto) throws SQLException;
}
