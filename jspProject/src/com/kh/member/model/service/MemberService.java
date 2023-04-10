package com.kh.member.model.service;

import java.sql.Connection;

import com.kh.common.JDBCTemplate;
import com.kh.member.model.dao.MemberDao;
import com.kh.member.model.vo.Member;

public class MemberService {

	public Member loginMember(String userId, String userPwd) {
		//커넥션객체로 디비에 접속
		Connection conn = JDBCTemplate.getConnection();
		
		Member m = new MemberDao().loginMember(conn,userId,userPwd);
		
		//조회는 commit/rollback할 필요 없으니 자원 반납
		JDBCTemplate.close(conn);
		
		return m;
		
	}
	//회원가입 메소드
	public int insertMember(Member m) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().insertMember(conn,m);
		
		if(result>0) { //성공적으로 dml구문이 실행됐다면
			JDBCTemplate.commit(conn); //확정
		}else{ //실패했다면
			JDBCTemplate.rollback(conn);//되돌리기
		}
		
		
		return result;
	}
	//정보 수정 메소드 
	public Member updateMember(Member m) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().updateMember(conn,m);
		//변경된 회원 정보를 세션에 담아야 하기 때문에 다시 조회해오기
		Member updateMem = null; //변경된 회원 정보 담을 객체변수 
		
		//성공 실패 트랜잭션 처리 (DML)
		if(result>0) {
			JDBCTemplate.commit(conn);
			//갱신된 정보 조회해오기
			updateMem = new MemberDao().selectMember(conn,m.getUserId());
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return updateMem;
	}
	
	//비밀번호 수정 메소드
	public Member updatePwd(String userId, String updatePwd) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().updatePwd(conn,userId,updatePwd);
		Member m = null;
		if(result>0) { //성공
			 
			JDBCTemplate.commit(conn);
			m = new MemberDao().selectMember(conn, userId); //성공시 갱신할 회원정보 조회
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return m;
	}
	//회원탈퇴 메소드
	public int deleteMember(String userId, String userPwd) {
		Connection conn = JDBCTemplate.getConnection();
		int result = new MemberDao().deleteMember(conn,userId,userPwd);
		
		if(result>0) { //DML구문이니 트랜잭션 
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

}
