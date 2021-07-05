<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>    
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 검색 리스트</title>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

   <h2>관리자 - 전체 회원 리스트</h2>
   <form action="<%=request.getContextPath() %>/view/memberSearchList.jsp" method="post">
      <select name="sk">
         <option value="MEM_ID">회원ID</option>
         <option value="MEM_NAME">회원명</option>
         <option value="MEM_EMAIL">이메일</option>
      </select>
      <input type="text" name="sv">
      <input type="submit" value="검색">
   </form>
   <p>
   <button onclick="location.href='/gaia_mem/joinAdmin.camp'">회원추가</button>
   </p>
   <table  border="1">
   <!-- width="100%" -->
   <tr bgcolor="skybule">
      
         <td>회원ID</td>
         <td>비밀번호</td>
         <td>회원명</td>
         <td>주소</td>
         <td>전화번호</td>
         <td>주민번호</td>
         <td>이메일</td>
         <td>닉네임</td>
         
         
      </tr>
   <%
   request.setCharacterEncoding("utf-8");
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   Class.forName("org.mariadb.jdbc.Driver");
   String sk = request.getParameter("sk");
   String sv = request.getParameter("sv");
   System.out.println(sk + "<-- sk memberSearchList.jsp");
   System.out.println(sv + "<-- sk memberSearchList.jsp");
   
   try{
      String jdbcDriver = "jdbc:mariadb://localhost:3306/gaia?" + 
            "useUnicode=true&characterEncoding=utf-8";
      String username="root";
      String password="m1234";
      conn = DriverManager.getConnection(jdbcDriver, username, password);
      
      if(sk == null & sv ==null){
         /* out.println("01 sk = null, sv = null인 조건"); */
         pstmt = conn.prepareStatement("select * from member");
      }else if(sk != null & sv.equals("")){
         /* out.println("02 sk 값O, sv null인 조건"); */
         pstmt = conn.prepareStatement("select * from member");
      }else if(sk != null & sv != null){
         out.println("검색한 회원의 정보입니다.");
         if(sk.equals("MEM_ID")){
            pstmt = conn.prepareStatement("select * from member where MEM_ID=?");
         }else if(sk.equals("MEM_NAME")){
            pstmt = conn.prepareStatement("select * from member where MEM_NAME=?");
         }else if(sk.equals("MEM_EMAIL")){
            pstmt = conn.prepareStatement("select * from member where MEM_EMAIL=?");
         }
         pstmt.setString(1, sv);
      }
      /* if(sk == null & sv == null){
         out.println("01 sk null, sv null인 조건");
         pstmt = conn.prepareStatement("select * from member");
      }else if(sk != null && sv.equals("")){
         out.println("02 sk 값O, sv 공백 조건");
         pstmt = conn.prepareStatement("select * from member");
      }else if(sk != null && sv != null){
         out.println("03 sk, sv 둘다 값 O");
         pstmt = conn.prepareStatement("select * from member where MEM_ID=?");
         pstmt.setString(1, sv);
      }else if(sk != null && sv != null){
         out.println("04 sk, sv 둘다 값 O");
         pstmt = conn.prepareStatement("select * from member where MEM_NAME=?");
         pstmt.setString(1, sv);
      }else if(sk != null && sv != null){
         out.println("05 sk, sv 둘다 값 O");
         pstmt = conn.prepareStatement("select * from member where MEM_EMAIL=?");
         pstmt.setString(1, sv);
   } */
      /* out.println("<br>"+pstmt + "<--- pstmt"); */
      rs = pstmt.executeQuery();
      /* System.out.println(rs + "<-- rs memberList.jsp"); */
      while(rs.next()){
   %>      
      <tr>
         <td><%= rs.getString("MEM_ID") %></td>
         <td><%= rs.getString("MEM_PW") %></td>
         <td><%= rs.getString("MEM_NAME") %></td>
         <td><%= rs.getString("MEM_ADDR") %></td>
         <td><%= rs.getString("MEM_TEL") %></td>
         <td><%= rs.getString("MEM_JUMIN") %></td>
         <td><%= rs.getString("MEM_EMAIL") %></td>
         <td><%= rs.getString("MEM_NICKNAME") %></td>
         
         
         </tr>
   <%
      }
   }catch(SQLException ex){
      out.println(ex.getMessage());
      ex.printStackTrace();
   } finally{
      if(rs != null) try {rs.close(); }catch(SQLException ex){}
      if(pstmt != null) try {pstmt.close(); }catch(SQLException ex){}
      if(conn != null) try {conn.close(); }catch(SQLException ex){}
   }
         %>
   </table>
   
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>