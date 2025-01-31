package com.sp.app.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mapper.DemoMapper;
import com.sp.app.model.Demo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 	- @Transactional
 	  : 기본적으로 메소드 실행 전 트랜잭션을 시작하고, 메소드가 성공적으로 실행되면 트랜잭션 commit
 	  : 예외가 발생하면 rollback
 	- readOnly 속성
 	  : true 로 설정하면 트랜잭션이 읽기 전용
 	  : INSERT, UPDATE, DELETE 하면 예외 발생
 	  : 조회만 가능
 	- 전파 규칙
 	  : 기본 - Propagation.REQUIRED
 	    이미 존재하는 트랜잭션이 있으면 그 트랜잭션을 사용하고, 없으면 새로 만든다.
 	- rollbackFor
 	  : 롤백 대상 명시
 	- 클래스 레벨과 메소드 레벨을 동시에 설정하면 메소드 레벨이 우선순위가 높음
 */

@Transactional(readOnly =  true)
@Service
@RequiredArgsConstructor
@Slf4j
public class DemoServiceImpl implements DemoService {
	private final DemoMapper mapper;
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	@Override
	public void insertDemo(Demo dto) throws Exception {
		try {
			mapper.insertDemo1(dto);
			mapper.insertDemo2(dto);
			mapper.insertDemo3(dto);
		} catch (Exception e) {
			log.info("insertDemo : ", e);
			
			throw e;
		}
	}

}
