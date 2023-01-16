package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.Sqlsessionmanager;

public class CCTVDAO {
	// 세션을 생성해 줄수 있는 factory 생성
	SqlSessionFactory sqlSessionFactory = Sqlsessionmanager.getSqlSession();

	// 세션 생성(sql 실행, close(), 연결)
	SqlSession sqlSession = sqlSessionFactory.openSession();

	

	public List<CCTV> selectAll() {
		List<CCTV> name = null;
		try {
			name = sqlSession.selectList("com.smhrd.model.CCTVDAO.selectAll");
			// select ==> commit/rollback 생략가능
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		return name;
	}
	
	//관리자 페이지 CCTV 목록
	
	public List<CCTV> selectcctvList(int num) {
		List<CCTV> list = null;
		try {
			list = sqlSession.selectList("com.smhrd.model.CCTVDAO.selectcctvList", num);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return list;
	}
	
	// 관리자의 cctv 삭제
	public int deleteCctv(int num) {
		int cnt=0;
		try {
			cnt = sqlSession.delete("com.smhrd.model.CCTVDAO.deleteCctv", num);
			if(cnt>0) {
				sqlSession.commit();
			}else {
				sqlSession.rollback();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return cnt;
	}
	
//	public List<CCTV> selectAll() {
//		List<CCTV> name = null;
//		try {
//			name = sqlSession.selectList("com.smhrd.model.CCTVDAO.selectAll");
//			// select ==> commit/rollback 생략가능
//		}catch(Exception e) {
//			e.printStackTrace();
//		} finally {
//			sqlSession.close();
//		}
//		return name;
//	}
}


