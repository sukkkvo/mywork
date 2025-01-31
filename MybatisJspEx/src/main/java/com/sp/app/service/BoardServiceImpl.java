package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.model.Board;
import com.sp.app.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
	private final BoardMapper mapper;
	
	@Override
	public void insertBoard(Board dto) throws Exception {
		try {
			mapper.insertBoard(dto);
		} catch (Exception e) {
			log.info("insertBoard : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateBoard(Board dto) throws Exception {
		try {
			mapper.updateBoard(dto);
		} catch (Exception e) {
			log.info("updateBoard : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteBoard(long num) throws Exception {
		try {
			mapper.deleteBoard(num);
		} catch (Exception e) {
			log.info("deleteBoard : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			
			throw e;
		}
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}

		return result;
	}
	
	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = null;

		try {
			list = mapper.listBoard(map);
		} catch (Exception e) {
			log.info("listBoard : ", e);
		}

		return list;
	}

	@Override
	public Board findById(long num) {
		Board dto = null;

		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public Board findByPrev(Map<String, Object> map) {
		Board dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}

		return dto;
	}

	@Override
	public Board findByNext(Map<String, Object> map) {
		Board dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}

		return dto;
	}
}
