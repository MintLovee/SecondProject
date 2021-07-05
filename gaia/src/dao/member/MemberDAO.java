package dao.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

import javaBean.member.MemberBean;
import javaBean.reservation.ReservationListBean;
import javaBean.review.CommentBean;

public class MemberDAO {

	private PreparedStatement ps;
	private ResultSet rs;

	DataSource ds;
	Connection conn;
	private static MemberDAO memberDAO;

	private MemberDAO() {
	}
	
	public static MemberDAO getInstance() {
		if (memberDAO == null) {
			memberDAO = new MemberDAO();
		}
		return memberDAO;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int deleteById(String MEM_ID, String MEM_PW) {
	      int result = 0;
	      try {
	         String pw = null;
	         Connection conn = getConnection();
	         String sql = "select MEM_PW from member where MEM_ID=?";
	         ps = conn.prepareStatement(sql);
	         ps.setString(1, MEM_ID);
	         rs = ps.executeQuery();
	         if (rs.next()) {
	            pw = rs.getString("MEM_PW");
	            if (pw.equals(MEM_PW)) {
	               String delsql = "delete from member where MEM_ID=?";
	               ps = conn.prepareStatement(delsql);
	               ps.setString(1, MEM_ID);
	               ps.executeUpdate();
	               conn.commit();
	               result = 1;
	            } else {
	               result = 0;
	            }
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if (conn != null) {
	               conn.close();
	            }
	            if (ps != null) {
	               ps.close();
	            }
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      }
	      return result;
	   }
	
	public MemberBean updateById(String id, String pw, String name, String addr, String tel, String email) {
		int result = -1;
		
		String sql = "update member set MEM_PW = ?, MEM_NAME = ?, MEM_ADDR = ?, MEM_TEL = ?, MEM_EMAIL = ? where MEM_ID = ?";
		MemberBean memberBean = new MemberBean();
		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, pw);
			ps.setString(2, name);
			ps.setString(3, addr);
			ps.setString(4, tel);
			ps.setString(5, email);
			ps.setString(6, id);
			
			result = ps.executeUpdate();
			conn.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return memberBean;

	}
	
	public MemberBean selectMember(String MEM_ID) {
		MemberBean bean = new MemberBean();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			String sql = "select * from member where id=?";
			ps = conn.prepareStatement(sql);

			ps.setString(1, MEM_ID);
			rs = ps.executeQuery();
			if (rs.next()) {
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setMEM_PW(rs.getString("MEM_PW"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setMEM_ADDR(rs.getString("MEM_ADDR"));
				bean.setMEM_TEL(rs.getString("MEM_TEL"));
				bean.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				bean.setMEM_EMAIL(rs.getString("MEM_EMAIL"));

			}
		} catch (Exception e) {
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return bean;

	}
	
	public int updateMemberInfo(String MEM_ID, String MEM_PW, String MEM_NAME, String MEM_ADDR, String  MEM_TEL, String MEM_EMAIL) {
		int updateCount = 0;
		PreparedStatement ps = null;
		String sql = "UPDATE member SET MEM_PW=?, MEM_NAME=?, MEM_ADDR=?, MEM_TEL=?, MEM_EMAIL=?, MEM_NICKNAME=? WHERE MEM_ID=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, MEM_PW);
			ps.setString(2, MEM_NAME);
			ps.setString(3, MEM_ADDR);
			ps.setString(4, MEM_TEL);
			ps.setString(5, MEM_EMAIL);
			ps.setString(6, MEM_NAME+"("+MEM_TEL.substring(MEM_TEL.length()-4, MEM_TEL.length())+")");
			ps.setString(7, MEM_ID);
			updateCount = ps.executeUpdate();
		} catch (Exception e) {System.out.println("memModify : " + e);}
		finally {close(ps);}
		return updateCount;
	}
	
	public int updateMember(MemberBean dto) {
	      PreparedStatement ps = null;
	      int insertCount = 0;
	      String sql = "UPDATE member MEM_ID=? MEM_PW=? MEM_NAME=? "
					+ "MEM_ADDR=? MEM_TEL=? MEM_JUMIN=? MEM_EMAIL=? MEM_NICKNAME=aaa "
					+ "WHERE MEM_ID=?";
	      try {
	         ps = conn.prepareStatement(sql);
	         ps.setString(1, dto.getMEM_ID());
	         ps.setString(2, dto.getMEM_PW());
			 ps.setString(3, dto.getMEM_NAME());
			 ps.setString(4, dto.getMEM_ADDR());
			 ps.setString(5, dto.getMEM_TEL());
			 ps.setString(6, dto.getMEM_JUMIN());
			 ps.setString(7, dto.getMEM_EMAIL());
//			 ps.setString(8, dto.getMEM_NICKNAME());
			 ps.setString(8, dto.getMEM_ID());
			 
	         insertCount = ps.executeUpdate();
	         
	      } catch (Exception e) {System.out.println("UpdateMember : " + e);}
	      finally {close(ps);}
	      return insertCount;
	}



	public int DeleteMember(Connection conn, String id) {
		PreparedStatement ps = null;
		String sql = "DELETE FROM member WHERE MEM_ID=?";
		int deleteCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			deleteCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("MemberDelete : " + e);
		} finally {
			close(ps);
		}
		return deleteCount;
	}

	public int insertMember(MemberBean dto) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "INSERT into member VALUES (?,?,?,?,?,?,?,?)";
		int insertCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next())
				ps.setString(1, dto.getMEM_ID());
			ps.setString(2, dto.getMEM_PW());
			ps.setString(3, dto.getMEM_NAME());
			ps.setString(4, dto.getMEM_ADDR());
			ps.setString(5, dto.getMEM_TEL());
			ps.setString(6, dto.getMEM_JUMIN());
			ps.setString(7, dto.getMEM_EMAIL());
			ps.setString(8, dto.getMEM_NICKNAME());
			ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("MemberInsert : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return insertCount;

	}

	public MemberBean selectArticle(String mem_id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		MemberBean dto = null;
		try {
			ps = conn.prepareStatement("SELECT * FROM member WHERE MEM_ID=?");
			ps.setString(1, mem_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new MemberBean();
				dto.setMEM_ID(rs.getString("MEM_ID"));
				dto.setMEM_PW(rs.getString("MEM_PW"));
				dto.setMEM_NAME(rs.getString("MEM_NAME"));
				dto.setMEM_ADDR(rs.getString("MEM_ADDR"));
				dto.setMEM_TEL(rs.getString("MEM_TEL"));
				dto.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				dto.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				dto.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
			}
		} catch (Exception e) {
			System.out.println("getDetail : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return dto;
	}

	public int selectListCount() {
		int listCount = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(
					"SELECT COUNT(*) FROM member");
			rs = ps.executeQuery();
			if (rs.next())
				listCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getListCount : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return listCount;
	}

	public ArrayList<MemberBean> selectArticleList(int page, int limit) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM member ORDER BY MEM_ID LIMIT ? OFFSET ?";
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		MemberBean dto = null;
		int startrow = (page - 1) * limit;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, limit);
			ps.setInt(2, startrow);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new MemberBean();
				dto.setMEM_ID(rs.getString("MEM_ID"));
				dto.setMEM_PW(rs.getString("MEM_PW"));
				dto.setMEM_NAME(rs.getString("MEM_NAME"));
				dto.setMEM_ADDR(rs.getString("MEM_ADDR"));
				dto.setMEM_TEL(rs.getString("MEM_TEL"));
				dto.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				dto.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				dto.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getMemberList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return memberList;
	}
	
	public int selectListCount(String fieldName, String searchWord) {
		int listCount = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(
					"SELECT COUNT(*) FROM member WHERE " + fieldName + " LIKE '%" + searchWord + "%'");
			rs = ps.executeQuery();
			if (rs.next())
				listCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getListCount : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return listCount;
	}

	public ArrayList<MemberBean> selectArticleList(int page, int limit, String fieldName, String searchWord) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM member WHERE "+fieldName+" LIKE '%" + searchWord + "%' ORDER BY MEM_ID LIMIT ? OFFSET ?";
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		MemberBean dto = null;
		int startrow = (page - 1) * limit;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, limit);
			ps.setInt(2, startrow);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new MemberBean();
				dto.setMEM_ID(rs.getString("MEM_ID"));
				dto.setMEM_PW(rs.getString("MEM_PW"));
				dto.setMEM_NAME(rs.getString("MEM_NAME"));
				dto.setMEM_ADDR(rs.getString("MEM_ADDR"));
				dto.setMEM_TEL(rs.getString("MEM_TEL"));
				dto.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				dto.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				dto.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getMemberList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return memberList;
	}
	
	public ArrayList<MemberBean> selectNewMember(int page,int limit) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM member ORDER BY MEM_DATE DESC LIMIT ? OFFSET ?";
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		MemberBean dto = null;
		int startrow = (page - 1) * limit;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, limit);
			ps.setInt(2, startrow);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new MemberBean();
				dto.setMEM_ID(rs.getString("MEM_ID"));
				dto.setMEM_PW(rs.getString("MEM_PW"));
				dto.setMEM_NAME(rs.getString("MEM_NAME"));
				dto.setMEM_ADDR(rs.getString("MEM_ADDR"));
				dto.setMEM_TEL(rs.getString("MEM_TEL"));
				dto.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				dto.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				dto.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getMemberList : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return memberList;
	}

	public int insertList(MemberBean dto) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		// int num = 0;
		String sql = "";
		int insertCount = 0;
		try {
			// ps = conn.prepareStatement("SELECT MAX(MEM_NUM) FROM member");
			// rs = ps.executeQuery();
			// if (rs.next()) num = rs.getInt(1) + 1;
			// else num = 1;
			sql = "INSERT INTO member (MEM_ID, MEM_NAME, MEM_ADDR, "
					+ "MEM_TEL, MEM_JUMIN, MEM_EMAIL, MEM_NICKNAME ) VALUES (?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			// ps.setInt(1, num);
			ps.setString(1, dto.getMEM_ID());
			ps.setString(2, dto.getMEM_NAME());
			ps.setString(3, dto.getMEM_ADDR());
			ps.setString(4, dto.getMEM_TEL());
			ps.setString(5, dto.getMEM_JUMIN());
			ps.setString(6, dto.getMEM_EMAIL());
			ps.setString(7, dto.getMEM_NICKNAME());
			insertCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("boardInsert : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return insertCount;
	}

	// joinMember : 회원가입
	public int joinMember(MemberBean dto) {
		String sql = "INSERT INTO member (MEM_ID, MEM_PW, MEM_NAME, MEM_ADDR, "
				+ "MEM_TEL, MEM_JUMIN, MEM_EMAIL, MEM_NICKNAME ) VALUES (?,?,?,?,?,?,?,?)";
		int insertCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMEM_ID());
			ps.setString(2, dto.getMEM_PW());
			ps.setString(3, dto.getMEM_NAME());
			ps.setString(4, dto.getMEM_ADDR());
			ps.setString(5, dto.getMEM_TEL());
			ps.setString(6, dto.getMEM_JUMIN());
			ps.setString(7, dto.getMEM_EMAIL());
			ps.setString(8, dto.getMEM_NICKNAME());
			insertCount = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("joinMember() Exception!!!");
		}
		return insertCount;
	}

	// 아이디중복체크 메서드
	public int isCheck(String id) {
		int count = 0;
		String sql = "select count(*) from MEMBER where MEM_ID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			rs.next();
			count = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("checkId err : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return count;
	}

	public ArrayList<MemberBean> getAllMember(Connection conn) {
		String sql = "SELECT * FROM MEMBER";
		ArrayList<MemberBean> list = new ArrayList<>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {

				MemberBean dto = new MemberBean();
				dto.setMEM_ID(rs.getString("MEM_ID"));
				dto.setMEM_PW(rs.getString("MEM_PW"));
				dto.setMEM_NAME(rs.getString("MEM_NAME"));
				dto.setMEM_ADDR(rs.getString("MEM_ADDR"));
				dto.setMEM_TEL(rs.getString("MEM_TEL"));
				dto.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				dto.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				dto.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getAllMember() Exception!!!");
		} finally {
			close(rs);
			close(ps);
		}
		return list;
	} 


	public MemberBean selectById(String id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM MEMBER WHERE MEM_ID=?";
		MemberBean memberBean = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				memberBean = new MemberBean();
				memberBean.setMEM_ID(rs.getString("MEM_ID"));
				memberBean.setMEM_PW(rs.getString("MEM_PW"));
				memberBean.setMEM_NAME(rs.getString("MEM_NAME"));
				memberBean.setMEM_ADDR(rs.getString("MEM_ADDR"));
				memberBean.setMEM_TEL(rs.getString("MEM_TEL"));
				memberBean.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				memberBean.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				memberBean.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
			}
		} catch (Exception e) {
			System.out.println("getDetail : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return memberBean;
	}

	public boolean duplicateIdCheck(String id) {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		boolean x = false;

		try {
			// 쿼리
			StringBuffer query = new StringBuffer();
			query.append("SELECT MEM_ID FROM MEMBER WHERE MEM_ID=?");

			// conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query.toString());
			pstm.setString(1, id);
			rs = pstm.executeQuery();

			if (rs.next())
				x = true; // 해당 아이디 존재

			return x;

		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				if (pstm != null) {
					pstm.close();
					pstm = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
	}

	public MemberBean getData(String id) {
		MemberBean dto = null;
		try {
			String sql = "select * from webshop_member where id like ?";
			conn = ds.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new MemberBean();
				dto.setMEM_ID(rs.getString("MEM_ID"));
				dto.setMEM_PW(rs.getString("MEM_PW"));
				dto.setMEM_NAME(rs.getString("MEM_NAME"));
				dto.setMEM_ADDR(rs.getString("MEM_ADDR"));
				dto.setMEM_TEL(rs.getString("MEM_TEL"));
				dto.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				dto.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				dto.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));

			}

		} catch (Exception e) {
			System.out.println("getData err : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
		return dto;
	}

	public MemberBean showForUpdate(String id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		MemberBean dto = null;
		try {
			ps = conn.prepareStatement("SELECT * FROM member WHERE MEM_ID=?");
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new MemberBean();
				dto.setMEM_ID(rs.getString("MEM_ID"));
				dto.setMEM_PW(rs.getString("MEM_PW"));
				dto.setMEM_NAME(rs.getString("MEM_NAME"));
				dto.setMEM_ADDR(rs.getString("MEM_ADDR"));
				dto.setMEM_TEL(rs.getString("MEM_TEL"));
				dto.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
				dto.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
				dto.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
			}
		} catch (Exception e) {
			System.out.println("getDetail : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return dto;
	}
	
	public ArrayList<MemberBean> getMemberlist(String keyField, String keyWord, int startRow, int endRow) {

	      ArrayList<MemberBean> list = new ArrayList<MemberBean>();
	      Connection conn = getConnection();
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      try {
	    	 String sql = "select * from "
	  				+ "(select @ROWNUM:=@ROWNUM+1 AS rn , MEM_ID, MEM_PW, MEM_NAME, MEM_ADDR, MEM_TEL, MEM_JUMIN, MEM_EMAIL, MEM_NICKNAME  from "
	  				+ "(select * from member ";
	    	 if (keyWord != null && !keyWord.equals("")) {
		            sql += "WHERE " + keyField.trim() + " LIKE '%" + keyWord.trim() + "%' order by MEM_ID";
		         } else {
		            sql += "order by MEM_ID";
		         }
	    	 sql += ")b, (SELECT @ROWNUM:=0) R)a where rn between ? and ?";
	    	 
	         ps = conn.prepareStatement(sql);
	         ps.setInt(1, startRow);
	         ps.setInt(2, endRow);
	         rs = ps.executeQuery();
	         while (rs.next()) {
	            MemberBean bean = new MemberBean();

	            bean.setMEM_ID(rs.getString("MEM_ID"));
	            bean.setMEM_PW(rs.getString("MEM_PW"));
	            bean.setMEM_NAME(rs.getString("MEM_NAME"));
	            bean.setMEM_ADDR(rs.getString("MEM_ADDR"));
	            bean.setMEM_TEL(rs.getString("MEM_TEL"));
	            bean.setMEM_JUMIN(rs.getString("MEM_JUMIN"));
	            bean.setMEM_EMAIL(rs.getString("MEM_EMAIL"));
	            bean.setMEM_NICKNAME(rs.getString("MEM_NICKNAME"));
	            list.add(bean);
	         }
	      } catch (Exception e) {
	         System.out.println(e + "=> getMemberlist fail");
	      } finally {
	         try {
	            if (conn != null) {
	               conn.close();
	            }
	            if (ps != null) {
	               ps.close();
	            }
	            if (rs != null) {
	               rs.close();
	            }
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      } 
	      return list;
	   }
	
	public int getCount(String keyField, String keyWord){
		int count = 0;
		
		String sql = "select count(*) from member ";
         if (keyWord != null && !keyWord.equals("")) {
            sql += "WHERE " + keyField.trim() + " LIKE '%" + keyWord.trim() + "%' order by MEM_ID";
         } else {
            sql += "order by MEM_ID";
         }
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
	         try {
		            if (conn != null) {
		               conn.close();
		            }
		            if (ps != null) {
		               ps.close();
		            }
		            if (rs != null) {
		               rs.close();
		            }
		         } catch (Exception e) {
		            e.printStackTrace();
		         }
		      } 
		return count; 
	}
	
	public ArrayList<ReservationListBean> selectRezMgtList(String id, int limit) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT R.REZ_NUM,R.REZ_ID,M.MEM_NAME,R.REZ_TEL,R.REZ_PNUM,R.REZ_INDATE,R.REZ_OUTDATE," + 
              "R.REZ_OUTDATE-R.REZ_INDATE AS DIIFDAYS,P.P_PRICE,(R.REZ_OUTDATE-R.REZ_INDATE)*P.P_PRICE AS REZ_TOTAL " + 
              "FROM RESERVATION R, MEMBER M, PRODUCT P " + 
              "WHERE R.REZ_ID = M.MEM_ID AND R.REZ_PNUM = P.P_NUM AND R.REZ_ID=?" +
              "ORDER BY REZ_NUM DESC LIMIT ?";
        ArrayList<ReservationListBean> rezList = new ArrayList<ReservationListBean>();
        ReservationListBean rezBean = null;
        try {
           ps = conn.prepareStatement(sql);
           ps.setString(1, id);
           ps.setInt(2, limit);
           rs = ps.executeQuery();
           while (rs.next()) {
              rezBean = new ReservationListBean();
              rezBean.setREZ_NUM(rs.getInt("REZ_NUM"));
              rezBean.setREZ_ID(rs.getString("REZ_ID"));
              rezBean.setREZ_NAME(rs.getString("MEM_NAME"));
              rezBean.setREZ_TEL(rs.getString("REZ_TEL"));
              rezBean.setREZ_PNUM(rs.getString("REZ_PNUM"));
              rezBean.setREZ_INDATE(rs.getDate("REZ_INDATE"));
              rezBean.setREZ_OUTDATE(rs.getDate("REZ_OUTDATE"));
              rezBean.setREZ_DIFFDAYS(rs.getInt("DIIFDAYS")+"박 "+(rs.getInt("DIIFDAYS")+1)+"일");
              rezBean.setREZ_PRICE(rs.getInt("P_PRICE"));
              rezBean.setREZ_TOTAL(rs.getInt("REZ_TOTAL"));
              rezList.add(rezBean);
           }
        } catch (Exception e) {System.out.println("getRezList : " + e);}
        finally {close(rs);      close(ps);}
        return rezList;
     }

	public int selectRezMgtListCount(String id) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM RESERVATION WHERE REZ_ID='"+id+"'";
        int rezListCount = 0;
        try {
           ps = conn.prepareStatement(sql);
           rs = ps.executeQuery();
           if (rs.next()) rezListCount = rs.getInt(1);
        } catch (Exception e) {System.out.println("getRezListCount : " + e);}
        finally {close(rs);      close(ps);}
        return rezListCount;
     }
	
	public String getPW(String mem_id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT MEM_PW FROM MEMBER WHERE MEM_ID=?";
		String mem_pw = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mem_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				mem_pw = rs.getString("MEM_PW");
			}
		} catch (Exception e) {
			System.out.println("getPW : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return mem_pw;
	}
	
	public int memberUserDelete(String mem_id) {
		PreparedStatement ps = null;
		int deleteCount = 0;
		String sql = "DELETE FROM MEMBER WHERE MEM_ID=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mem_id);
			deleteCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("memberUserDelete : " + e);
		} finally {
			close(ps);
		}
		return deleteCount;
	}
	
	public int rezCheck(String mem_id) {
		int rc = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM RESERVATION WHERE REZ_ID=? AND REZ_OUTDATE>NOW()";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mem_id);
			rs = ps.executeQuery();
			if (rs.next())
				rc = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getListCount : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return rc;
	}
	
	public int memberUserComDelete(String mem_id) {
		PreparedStatement ps = null;
		int deleteCount = 0;
		String sql = "DELETE FROM COMMENT WHERE RE_ID=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mem_id);
			deleteCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("memberUserDelete : " + e);
		} finally {
			close(ps);
		}
		return deleteCount;
	}
	
	public ArrayList<CommentBean> allCom(String mem_id) {
		ArrayList<CommentBean> cl = new ArrayList<>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM COMMENT WHERE RE_ID=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mem_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setRE_NUM(rs.getInt("RE_NUM"));
				bean.setRE_ID(rs.getString("RE_ID"));
				bean.setRE_NICKNAME(rs.getString("RE_NICKNAME"));
				bean.setRE_CONTENT(rs.getString("RE_CONTENT"));
				bean.setRE_DATE(rs.getDate("RE_DATE"));
	            bean.setRE_PT_NUM(rs.getInt("RE_PT_NUM"));
	            cl.add(bean);
	         }
		} catch (Exception e) {
			System.out.println("allCom : " + e);
		} finally {
			close(rs);
			close(ps);
		}
		return cl;
	}
	
	 public int updateCom(int revNum) {
	       PreparedStatement ps = null;
	       int uc = 0;
	       String sql = "update review set comment=comment-1 where rev_num=?";
	       try{
	           ps = conn.prepareStatement(sql);
	           ps.setInt(1, revNum);
	           uc = ps.executeUpdate();
	        }catch(Exception ex){
	           System.out.println("updateCom : " + ex);
	        }finally{
	           close(ps);
	        }
	        return uc;
	     }
}
