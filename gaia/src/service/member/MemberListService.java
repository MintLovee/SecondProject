package service.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.member.MemberDAO;
import javaBean.member.MemberBean;



public class MemberListService  {

	public int getListCount(String fieldName, String searchWord) throws Exception{
		int listCount = 0;
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		listCount = dao.selectListCount(fieldName, searchWord);
		close(con);
		return listCount;
	}

	public ArrayList<MemberBean> getMemberList(int page, int limit, String fieldName, String searchWord) throws Exception{
		ArrayList<MemberBean> memberList = null;
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		memberList = memberDAO.selectArticleList(page,limit, fieldName, searchWord);
		close(con);
		return memberList;
	}
	
	public ArrayList<MemberBean> getNewMemberList(int page, int limit) throws Exception{
		ArrayList<MemberBean> memberList = null;
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		memberList = memberDAO.selectNewMember(page,limit);
		close(con);
		return memberList;
	}


	public int getListCount() throws Exception{
		int listCount = 0;
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		listCount = dao.selectListCount();
		close(con);
		return listCount;
	}

	public ArrayList<MemberBean> getMemberList(int page, int limit) throws Exception{
		ArrayList<MemberBean> memberList = null;
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		memberList = memberDAO.selectArticleList(page,limit);
		close(con);
		return memberList;
	}
}
