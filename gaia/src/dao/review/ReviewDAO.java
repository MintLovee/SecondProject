package dao.review;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.sql.DataSource;

import javaBean.auth.AuthBean;
import javaBean.reservation.ReservationBean;
import javaBean.review.CommentBean;
import javaBean.review.ReviewBean;
import javaBean.review.ReviewWriteBean;

public class ReviewDAO {

   DataSource ds;
   Connection conn;
   private static ReviewDAO reviewDAO ;

   private ReviewDAO() {
   }

   public static ReviewDAO getInstance(){
      if(reviewDAO == null){
         reviewDAO = new ReviewDAO();
      }
      return reviewDAO;
   }

   public void setConnection(Connection con){
      this.conn = con;
   }

   public int selectListCount() {
      int listCount= 0;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try{
         System.out.println("getConnection");
         pstmt=conn.prepareStatement("select count(*) from review");
         rs = pstmt.executeQuery();

         if(rs.next()){
            listCount=rs.getInt(1);
         }
      }catch(Exception ex){
         System.out.println("getListCount : " + ex);         
      }finally{
         close(rs);
         close(pstmt);
      }
      return listCount;
   }
   
   public int comSelectListCount(int REV_RE_NUM) {
      int listCount= 0;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try{
         System.out.println("getConnection");
         pstmt=conn.prepareStatement("select count(*) from comment where re_pt_num = ?");
         pstmt.setInt(1, REV_RE_NUM);
         rs = pstmt.executeQuery();
         if(rs.next()){
            listCount=rs.getInt(1);
         }
      }catch(Exception ex){
         System.out.println("getListCount : " + ex);         
      }finally{
         close(rs);
         close(pstmt);
      }
      return listCount;
   }
   
   public ArrayList<ReviewBean> recentlyList() {
      PreparedStatement ps = null;
      ResultSet rs = null;
      String sql = "select * from review order by REV_NUM desc limit 4 offset 0 ;";
      ArrayList<ReviewBean> recentlyList = new ArrayList<ReviewBean>();
      ReviewBean board = null;
      try {
         ps = conn.prepareStatement(sql);
         rs = ps.executeQuery();
         while (rs.next()) {
            board = new ReviewBean();
            board.setREV_NUM(rs.getInt("REV_NUM"));
            board.setREV_ID(rs.getString("REV_ID"));
            board.setREV_NAME(rs.getString("REV_NAME"));
            board.setREV_SUBJECT(rs.getString("REV_SUBJECT"));
            board.setREV_CONTENT(rs.getString("REV_CONTENT"));
            board.setREV_FILE(rs.getString("REV_FILE"));
            board.setREV_OPTION(rs.getString("REV_OPTION"));
            board.setREV_READC(rs.getInt("REV_READC"));
            board.setCOMMENT(rs.getInt("COMMENT"));
			DateFormat dateFormat = new SimpleDateFormat("yy-MM-dd");
			String dateToStr = dateFormat.format(rs.getTimestamp("REV_DATE"));
			board.setREV_DATE(dateToStr);
            recentlyList.add(board);
         }
      } catch (Exception e) {System.out.println("getRecentlyList : " + e);}
      finally {close(rs);      close(ps);}
      return recentlyList;
   }   
   
   public ArrayList<ReviewBean> selectArticleList(int page,int limit){
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String review_list_sql="select * from REVIEW order by REV_NUM desc limit ? offset ?";
      ArrayList<ReviewBean> articleList = new ArrayList<ReviewBean>();
      ReviewBean board = null;
      int startrow=(page-1)*limit;
      try{
         pstmt = conn.prepareStatement(review_list_sql);
         pstmt.setInt(1, limit);
         pstmt.setInt(2, startrow);
         rs = pstmt.executeQuery();
         while(rs.next()){
            board = new ReviewBean();
            board.setREV_NUM(rs.getInt("REV_NUM"));
            board.setREV_ID(rs.getString("REV_ID"));
            board.setREV_NAME(rs.getString("REV_NAME"));
            board.setREV_SUBJECT(rs.getString("REV_SUBJECT"));
            board.setREV_CONTENT(rs.getString("REV_CONTENT"));
            board.setREV_FILE(rs.getString("REV_FILE"));
            board.setREV_OPTION(rs.getString("REV_OPTION"));
            board.setREV_READC(rs.getInt("REV_READC"));
            board.setCOMMENT(rs.getInt("COMMENT"));
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String dateToStr = dateFormat.format(rs.getTimestamp("REV_DATE"));
			board.setREV_DATE(dateToStr);
			articleList.add(board);
         }
      }catch(Exception ex){
         System.out.println("getBoardList : " + ex);
      }finally{
         close(rs);
         close(pstmt);
      }
      return articleList;
   }
   
   public ArrayList<CommentBean> selectArticleList(int page,int limit,int revReNum){
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String review_list_sql="select * from COMMENT where RE_PT_NUM = ? order by RE_NUM desc LIMIT ? OFFSET ?";
      ArrayList<CommentBean> articleList = new ArrayList<CommentBean>();
      CommentBean board = null;
      int startrow=(page-1)*limit;
      try{
         pstmt = conn.prepareStatement(review_list_sql);
         pstmt.setInt(1, revReNum);
         pstmt.setInt(2, limit);
         pstmt.setInt(3, startrow);
         rs = pstmt.executeQuery();
         while(rs.next()){
            board = new CommentBean();
            board.setRE_NUM(rs.getInt("RE_NUM"));
            board.setRE_ID(rs.getString("RE_ID"));
            board.setRE_NICKNAME(rs.getString("RE_NICKNAME"));
            board.setRE_CONTENT(rs.getString("RE_CONTENT"));
            board.setRE_DATE(rs.getDate("RE_DATE"));
            board.setRE_PT_NUM(rs.getInt("RE_PT_NUM"));
            articleList.add(board);
         }
      }catch(Exception ex){
         System.out.println("getBoardList : " + ex);
      }finally{
         close(rs);
         close(pstmt);
      }
      return articleList;
   }
   
   public ReviewBean selectArticle(int rev_num){
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ReviewBean board = null;
      try{
         pstmt = conn.prepareStatement("select * from REVIEW where REV_NUM = ?");
         pstmt.setInt(1, rev_num);
         rs= pstmt.executeQuery();

         if(rs.next()){
            board = new ReviewBean();
            board.setREV_NUM(rs.getInt("REV_NUM"));
            board.setREV_ID(rs.getString("REV_ID"));
            board.setREV_NAME(rs.getString("REV_NAME"));
            board.setREV_SUBJECT(rs.getString("REV_SUBJECT"));
            board.setREV_CONTENT(rs.getString("REV_CONTENT"));
            board.setREV_FILE(rs.getString("REV_FILE"));
            board.setREV_OPTION(rs.getString("REV_OPTION"));
            board.setREV_READC(rs.getInt("REV_READC"));
            board.setCOMMENT(rs.getInt("COMMENT"));
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
			String dateToStr = dateFormat.format(rs.getTimestamp("REV_DATE"));
			board.setREV_DATE(dateToStr);
         }
      }catch(Exception ex){
         System.out.println("getDetail : " + ex);
      }finally{
         close(rs);
         close(pstmt);
      }
      return board;
   }
   public int insertArticle(ReviewBean article) {
      PreparedStatement ps = null;
      ResultSet rs = null;
      String sql = "";
      int insertCount = 0;
      sql = "INSERT INTO REVIEW (REV_ID,REV_NAME,REV_SUBJECT,REV_CONTENT,REV_FILE,REV_OPTION) VALUES (?,?,?,?,?,?)";
      try {
         ps = conn.prepareStatement(sql);
         ps.setString(1, article.getREV_ID());
         ps.setString(2, article.getREV_NAME());
         ps.setString(3, article.getREV_SUBJECT());
         ps.setString(4, article.getREV_CONTENT());
         ps.setString(5, article.getREV_FILE());
         ps.setString(6, article.getREV_OPTION());
         
         insertCount = ps.executeUpdate();
      } catch (Exception e) {System.out.println("revInsert : " + e);}
      finally {close(rs);      close(ps);}
      return insertCount;
   }
   
   public int selectNewReview(ReviewBean reviewBean) {
	      int newReviewNum = 0;
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      String sql = "SELECT REV_NUM FROM REVIEW WHERE REV_ID=? AND REV_OPTION=? AND REV_SUBJECT=? AND REV_CONTENT=?";
	      try {
	    	  ps = conn.prepareStatement(sql);
	    	  ps.setString(1, reviewBean.getREV_ID());
	    	  ps.setString(2, reviewBean.getREV_OPTION());
	    	  ps.setString(3, reviewBean.getREV_SUBJECT());
	    	  ps.setString(4, reviewBean.getREV_CONTENT());
	    	  rs = ps.executeQuery();
	    	  if (rs.next()) {
	    		  	newReviewNum = rs.getInt(1);
	    	  }
	      } catch (SQLException ex) {
	    	  System.out.println("selectNewReview: " + ex);
	      } finally {
	    	  close(rs);
	    	  close(ps);
	      }
	      return newReviewNum;
   }
   
   
    public int insertReplyArticle(CommentBean article) {
         PreparedStatement ps = null;
         PreparedStatement ps2 = null;
         String sql = "";
         String sql2 = "";
         int insertCount = 0;

         try {
            sql = "INSERT INTO COMMENT (RE_ID,RE_NICKNAME,RE_CONTENT,RE_PT_NUM) VALUES (?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, article.getRE_ID());
            ps.setString(2, article.getRE_NICKNAME());
            ps.setString(3, article.getRE_CONTENT());
            ps.setInt(4, article.getRE_PT_NUM());
            insertCount = ps.executeUpdate();
            System.out.println("reply");
            sql2 = "update review set comment=comment+1 where rev_num="+article.getRE_PT_NUM();
            ps2 = conn.prepareStatement(sql2);
            insertCount = ps2.executeUpdate();
         } catch (Exception e) {System.out.println("reviewReply : " + e);}
         finally {      close(ps);}
         return insertCount;
      }

   
   public int updateArticle(ReviewBean article){

      int updateCount = 0;
      PreparedStatement pstmt = null;
      String sql="update REVIEW set REV_SUBJECT=?,REV_CONTENT=? where REV_NUM=?";

      try{
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, article.getREV_SUBJECT());
         pstmt.setString(2, article.getREV_CONTENT());
         pstmt.setInt(3, article.getREV_NUM());
         updateCount = pstmt.executeUpdate();
      }catch(Exception ex){
         System.out.println("reviewModify : " + ex);
      }finally{
         close(pstmt);
      }
      return updateCount;
   }

   public int deleteRev(int rev_Num){
      PreparedStatement pstmt = null;
      String rev_delete_sql="delete from REVIEW where REV_NUM=?";
      int deleteCount=0;
      try{
         pstmt=conn.prepareStatement(rev_delete_sql);
         pstmt.setInt(1, rev_Num);
         deleteCount=pstmt.executeUpdate();
      }catch(Exception ex){
         System.out.println("revDelete : "+ex);
      }   finally{
         close(pstmt);
      }
      return deleteCount;
   }

   public boolean chDeleteArticle(int rev_num) {
         PreparedStatement ps = null;
         ResultSet rs = null;
         int count = 0;
         String sql = "select re_pt_num from comment where re_pt_num = ?";
         boolean replycount = false;
         try {
              ps = conn.prepareStatement(sql);
               ps.setInt(1, rev_num);
            rs = ps.executeQuery();
            if (rs.next()) {
               count = rs.getInt(1);
               if (count > 0)
                  replycount = true;
            }
         } catch (SQLException ex) {
            System.out.println("replycount 에러 : " + ex);
         } finally {
            close(rs);
            close(ps);
         }
         return replycount;
      }
   
   
   public int condeleteArticle(int re_num){

      PreparedStatement pstmt = null;
      String re_delete_sql="delete from comment where re_num=?";
      int deleteCount=0;

      try{
         pstmt=conn.prepareStatement(re_delete_sql);
         pstmt.setInt(1, re_num);
         deleteCount=pstmt.executeUpdate();
      }catch(Exception ex){
         System.out.println("reDelete : "+ex);
      }   finally{
         close(pstmt);
      }
      return deleteCount;
   }
   
   
   
   public int updateReadCount(int rev_num){

      PreparedStatement pstmt = null;
      int updateCount = 0;
      String sql="update review set REV_READC = "+
            "REV_READC+1 where REV_NUM = "+rev_num;
      try{
         pstmt=conn.prepareStatement(sql);
         updateCount = pstmt.executeUpdate();
      }catch(SQLException ex){
         System.out.println("setReadCountUpdate : "+ex);
      }
      finally{
         close(pstmt);
      }
      return updateCount;
   }
   public boolean isArticleReviewWriter(int rev_num) {
      PreparedStatement ps = null;
      ResultSet rs = null;
      String review_sql = "SELECT * FROM review WHERE REV_NUM=?";
      boolean isWriter = false;
      try {
         ps = conn.prepareStatement(review_sql);
         ps.setInt(1, rev_num);
         rs = ps.executeQuery();
         rs.next();
      } catch (Exception e) {System.out.println("isReviewWriter : " + e);}
      finally {close(ps);}
      return isWriter;
   }
   public ReservationBean selectoption(AuthBean authbean){
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ReservationBean option = null;
      try{
         pstmt = conn.prepareStatement("select REZ_PNUM from RESERVATION where REZ_ID = ?");
         pstmt.setString(1, authbean.getMEM_ID());
         rs= pstmt.executeQuery();

         if(rs.next()){
            option = new ReservationBean();
            option.setREZ_PNUM(rs.getString("rEZ_PNUM"));
            
         }
      }catch(Exception ex){
         System.out.println("getDetail : " + ex);
      }finally{
         close(rs);
         close(pstmt);
      }
      return option;
   }
   
   public ArrayList<ReviewWriteBean> selectReservationList(String id) {
         PreparedStatement ps = null;
         ResultSet rs = null;
         ArrayList<ReviewWriteBean> reviewWriteList = new ArrayList<ReviewWriteBean>();
         ReviewWriteBean rwBean = null;
         String sql = "SELECT DISTINCT CONCAT(P.P_NAME,'(',REZ.REZ_PNUM,')',' ',REZ.REZ_INDATE,'~',REZ.REZ_OUTDATE) AS SITE,REZ.REZ_NUM,REZ.REZ_PNUM "
                  + "FROM RESERVATION REZ, REVIEW REV,PRODUCT P "
                  + "WHERE REZ.REZ_ID=REV.REV_ID AND REZ.REZ_PNUM=P.P_NUM AND REZ.REZ_ID=? AND REV.REV_ID=? "
                  + "AND DATEDIFF(NOW(),REZ_OUTDATE)<=14 AND DATEDIFF(NOW(),REZ_OUTDATE)>=0 AND REZ.REZ_REVCHECK=0;";
         try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, id);
            rs = ps.executeQuery();
            while (rs.next()) {
              rwBean = new ReviewWriteBean();
               rwBean.setSITE(rs.getString("SITE"));
               rwBean.setREZ_NUM(rs.getInt("REZ_NUM"));
               rwBean.setREZ_PNUM("REZ_PNUM");
               reviewWriteList.add(rwBean);
               System.out.println(reviewWriteList.get(0).getSITE());
               System.out.println(reviewWriteList.get(0).getREZ_NUM());
               System.out.println(reviewWriteList.get(0).getREZ_PNUM());
            }
         } catch (Exception e) {System.out.println("getRezList : " + e);}
         finally {close(rs);      close(ps);}
         return reviewWriteList;
    }
   
   public int updateRevCheck(String rezNum, int newReviewNum){
      PreparedStatement pstmt = null;
      int updateCount = 0;
      String sql="UPDATE RESERVATION SET REZ_REVCHECK=? WHERE REZ_NUM=?";

      try{
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, newReviewNum);
         pstmt.setString(2, rezNum);
         updateCount = pstmt.executeUpdate();
      }catch(Exception ex){
         System.out.println("reviewModify : " + ex);
      }finally{
         close(pstmt);
      }
      return updateCount;
   }
   
   public int updateDelRevCheck(int revNum){
	      PreparedStatement pstmt = null;
	      int updateCount = 0;
	      String sql="UPDATE RESERVATION SET REZ_REVCHECK=0 WHERE REZ_REVCHECK=?";
	      try{
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, revNum);
	         updateCount = pstmt.executeUpdate();
	      }catch(Exception ex){
	         System.out.println("reviewModify : " + ex);
	      }finally{
	         close(pstmt);
	      }
	      return updateCount;
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