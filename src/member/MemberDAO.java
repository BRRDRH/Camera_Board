package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;


//DAO(Data Access Object) - DB의 연결, 해제, 질의를 담당
public class MemberDAO {
	
	//Singleton pattern(싱글톤 패턴) - 클래스의 인스턴스 하나만 생성하는 방법
	private MemberDAO(){}
	
	private static MemberDAO memberDAO = new MemberDAO();
	
	public static MemberDAO getInstance(){
		return memberDAO;
	}
	
	//DB 연결, 질의 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 회원 가입 메소드
	public int insertMember(MemberDTO member) {
		String sql = "insert into member values(?, ?, ?, ?, ?, ?, now())";
		int cnt = 0; // 성공 여부
		
		
		try {
			conn = JDBCUtil.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress());
			cnt = pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	// 아이디 중복 체크
	public int checkID(String id) {
		String sql="select * from member where id= ?";
		int cnt = 1;  //성공 여부
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 아이디가 존재 -> 사용할 수 있는 아이디
				cnt = 0;
			}else {			// 아이디가  없다. -> 사용할 수 없는 아이디
				cnt = 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	// 로그인 메소드
	public int login(String id, String pwd) {
		String sql = "select * from member where id=?";
		int cnt = -1; // 세 가지의 경우 -1 : ID가 존재 x, 0 : 아이디는 있고 비번이 다름 , 1: 둘 다 일치
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {  //아이디가 있다는 것
				String dbpwd = rs.getString("pwd");
				if(pwd.equals(dbpwd)) { //비밀번호도 일치한 경우
					cnt=1;
				}else { 				//비밀번호가 일치 x
					cnt=0;
				}
			}else {			 //아이디가 없을 때
				cnt =-1;
			}
			
		}catch(Exception e) {
			
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	// 회원 정보 보기 메소드(1명, 자신의 정보)
	public MemberDTO getMember(String id) {
		String sql ="select * from member where id=?";
		MemberDTO member = new MemberDTO();
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//가입일을 제외한 정보를 member 테이블로부터 가져와서 member 객체에 저장
				member.setId(rs.getString("id"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
				member.setRegDate(rs.getTimestamp("regDate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
	}
	
	
	// 회원 정보 수정
	public int updateMember(MemberDTO member) {
		String sql = "update member set pwd=?, name=?, email=?, tel=?, address=? where id=?";
		int cnt =0; // 성공여부
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getId());
			
			cnt = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
			
		}
		return cnt;
	}
	
	
	// 회원 삭제(탈퇴)메소드 -> 해당 회원이 남긴 게시판의 글도 모두 삭제되도록 변경
	public int deleteMember(String id, String pwd) throws Exception{
		String sql1 = "delete from member where id =? and pwd=?";
		String sql2 = "delete from board where writer =?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			
			// 트랜잭션(transaction) 처리 - DML(insert, update, delete) 작업이 2개 이상 함께 처리되어야 할 때
			// 모두 처리되든지, 모두 처리되지 않게 하는 방법
			// All or Nothing
			
			// 트랜잭션 1단계 - autocommit 기능을 끔
			conn.setAutoCommit(false);
			
			//1작업 : 회원 삭제(탈퇴 작업)
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			cnt = pstmt.executeUpdate();
			
			//2작업 : 해당 회원이 남긴 게시판 글을 모두 삭제
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			// 트랜잭션 2단계 - 모든 작업이 완료되었을 때 커밋을 함.
			conn.commit();
			// 트랜잭션 3단계 - autocommit 기능을 다시 설정함
			conn.setAutoCommit(true);
			
		}catch(Exception e) {
			// 트랜잭션 처리시에 예외가 발생했을 때 롤백을 함.
			conn.rollback();
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
		
	}
}
