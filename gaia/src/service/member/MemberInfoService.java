package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.member.MemberDAO;
import dao.reservation.RezDAO;
import javaBean.member.MemberBean;
import javaBean.reservation.ReservationListBean;

public class MemberInfoService {
	
	public MemberBean getMemberInfo(String id) {
		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		
		MemberBean memberBean = memberDAO.selectById(id);
		close(conn);
		return memberBean;
	}
	public ArrayList<ReservationListBean> getRezList(String id, int limit) throws Exception{
		
		ArrayList<ReservationListBean> rezList = null;
		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		rezList = memberDAO.selectRezMgtList(id, limit);
		close(conn);
		return rezList;
	}
	public int getRezListCount(String id) throws Exception{
		
		int rezListCount = 0;
		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		rezListCount = memberDAO.selectRezMgtListCount(id);
		close(conn);
		return rezListCount;
	}
}
