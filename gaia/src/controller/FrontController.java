package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.auth.LoginAction;
import action.auth.LogoutAction;
import action.auth.MgtLogoutAction;
import action.manage.ManagePageMemAction;
import action.manage.ManagePageProAction;
import action.manage.ManagePageQnaAction;
import action.manage.ManagePageRezAction;
import action.member.MemberAdminDeleteAction;
import action.member.MemberAdminJoinAction;
import action.member.MemberJoinAction;
import action.member.MemberListAction;
import action.member.MemberModifyAction;
import action.member.MemberModifySuccessAction;
import action.member.MemberMyPageAction;
import action.member.MemberUpdateFormAction;
import action.member.MemberUpdateProAction;
import action.member.MemberUserDeleteAction;
import action.member.MemberUserDeleteProAction;
import action.notice.NoticeDeleteAction;
import action.notice.NoticeDetailAction;
import action.notice.NoticeListAction;
import action.notice.NoticeModifyAction;
import action.notice.NoticeUpdateAction;
import action.notice.NoticeWriteAction;
import action.product.crvDetailAction;
import action.product.decDetailAction;
import action.product.graDetailAction;
import action.product.proDeleteAction;
import action.product.proInsertAction;
import action.product.proManageAction;
import action.product.proUpdateFormAction;
import action.product.proUpdateSuccessAction;
import action.qna.QnaDeleteFormAction;
import action.qna.QnaDeleteProAction;
import action.qna.QnaDetailAction;
import action.qna.QnaListAction;
import action.qna.QnaModifyFormAction;
import action.qna.QnaModifyProAction;
import action.qna.QnaReplyFormAction;
import action.qna.QnaReplyProAction;
import action.qna.QnaWriteProAction;
import action.reservation.RezDeleteAction;
import action.reservation.RezDetailAction;
import action.reservation.RezListAction;
import action.reservation.RezMgtDeleteAction;
import action.reservation.RezMgtInsertAction;
import action.reservation.RezMgtInsertFormAction;
import action.reservation.RezMgtListAction;
import action.reservation.RezMgtUpdateAction;
import action.reservation.RezMgtUpdateSuccessAction;
import action.reservation.RezOkAction;
import action.review.ComDeleteProAction;
import action.review.RevDeleteAction;
import action.review.RevDetailAction;
import action.review.RevListAction;
import action.review.RevModifyFormAction;
import action.review.RevModifyProAction;
import action.review.RevReplyProAction;
import action.review.RevWriteFormAction;
import action.review.RevWriteProAction;
import javaBean.qna.QnaBean;
import service.qna.FaqListService;
import util.Action;
import util.ActionForward;

@WebServlet("*.camp")
public class FrontController extends HttpServlet {
	protected void doProcess(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String RequestURI = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		ActionForward forward = null;
		Action action = null;

		// 인덱스, 메인
		if (command.equals("/login.camp")) {
			forward = new ActionForward();
			forward.setPath("view/loginForm.jsp");
//			forward.setRedirect(true);
		} else if (command.equals("/loginSuccess.camp")) {
			action = new LoginAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/logout.camp")) {
			action = new LogoutAction();
			try {
				forward = action.execute(req, res);				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/join.camp")) {
			forward = new ActionForward();
			forward.setPath("view/joinForm.jsp");
		} else if (command.equals("/joinSuccess.camp")) {
			action = new MemberJoinAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/myPage.camp")) {
			action = new MemberMyPageAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberList.camp")) {
			action = new MemberListAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/joinAdmin.camp")) {
			forward = new ActionForward();
			forward.setPath("view/adminJoinForm.jsp");

		} else if (command.equals("/joinAdminSuccess.camp")) {
			action = new MemberAdminJoinAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}	
		} else if (command.equals("/memberUpdatePro.camp")) {
			action = new MemberUpdateProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberUpdateSuccess.camp")) {
			action = new MemberUpdateProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberDelete.camp")) {
			action = new MemberAdminDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/myMemberPage.camp")) {
			action = new MemberUpdateFormAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/modify.camp")) {
			action = new MemberModifyAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/modifySuccessForm.camp")) {
			action = new MemberModifySuccessAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberUserDelete.camp")) {
			action = new MemberUserDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberUserDeleteSuccess.camp")) {
			action = new MemberUserDeleteProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberUserDeletePro.camp")) {
			forward = new ActionForward();
			forward.setPath("view/deleteSuccess.jsp");
		} else if (command.equals("/deleteSuccess.camp")) {
			action = new MemberAdminDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			
			// 상품
		} else if (command.equals("/proPreview.camp")) {
			forward = new ActionForward();
			forward.setPath("/view/proPreview.jsp");
		} else if (command.equals("/proCRV.camp")) {
			action = new crvDetailAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/proManage.camp")) {
			action = new proManageAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/proDEC.camp")) {
			action = new decDetailAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/proGRA.camp")) {
			action = new graDetailAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/productForm.camp")) {
			forward = new ActionForward();
			forward.setPath("/view/productForm.jsp");
		} else if (command.equals("/productInsert.camp")) {
			action = new proInsertAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/productDelete.camp")) {
			action = new proDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/productUpdateForm.camp")) {
			action = new proUpdateFormAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/productUpdateSuccess.camp")) {
			action = new proUpdateSuccessAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 예약
		} else if (command.equals("/rezList.camp")) {
			action = new RezListAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezDetail.camp")) {
			action = new RezDetailAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezOk.camp")) {
			action = new RezOkAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezDelete.camp")) {
			action = new RezDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezMgtList.camp")) {
			action = new RezMgtListAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezMgtInsertForm.camp")) {
		      action = new RezMgtInsertFormAction();
		      try {
		         forward = action.execute(req, res);
		      } catch (Exception e) {
		         e.printStackTrace();
		      }
		} else if (command.equals("/rezMgtInsert.camp")) {
			action = new RezMgtInsertAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezMgtUpdate.camp")) {
			action = new RezMgtUpdateAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezMgtUpdateSuccess.camp")) {
			action = new RezMgtUpdateSuccessAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/rezMgtDelete.camp")) {
			action = new RezMgtDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 리뷰
		} else if (command.equals("/reviewWriteForm.camp")) {
	         action = new RevWriteFormAction();
	         try {
	            forward = action.execute(req, res);
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
		} else if (command.equals("/reviewWriteFormProAction.camp")) {
			action = new RevWriteFormAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/reviewWritepro.camp")) {
			action = new RevWriteProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/reviewList.camp")) {
			action = new RevListAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/reviewDetail.camp")) {
			action = new RevDetailAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/reviewModify.camp")) {
			action = new RevModifyFormAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/reviewModifyPro.camp")) {
			action = new RevModifyProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/reviewDelete.camp")) {
			action = new RevDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/commentDeletePro.camp")) {
			action = new ComDeleteProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 } else if (command.equals("/reviewReplyPro.camp")) {
	         action = new RevReplyProAction();
	         try {
	            forward = action.execute(req, res);
	         } catch (Exception e) {
	            e.printStackTrace();
	         }

			
		// QNA
		} else if (command.equals("/qnaWriteForm.camp")) {
			forward = new ActionForward();
			forward.setPath("/view/qnaWrite.jsp");
		} else if (command.equals("/qnaWritePro.camp")) {
			action = new QnaWriteProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaList.camp")) {
			ArrayList<QnaBean> faqList = new ArrayList<QnaBean>();
			FaqListService faqListService = new FaqListService();
			try {
				faqList = faqListService.getFaqList();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			req.setAttribute("faqList", faqList);
			action = new QnaListAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaDetail.camp")) {
			action = new QnaDetailAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaReplyForm.camp")) {
			action = new QnaReplyFormAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaReplyPro.camp")) {
			action = new QnaReplyProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaModifyForm.camp")) {
			action = new QnaModifyFormAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaModifyPro.camp")) {
			action = new QnaModifyProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaDeleteForm.camp")) {
			action = new QnaDeleteFormAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/qnaDeletePro.camp")) {
			action = new QnaDeleteProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			
		// 공지사항
		} else if (command.equals("/noticeList.camp")) {
			action = new NoticeListAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/noticeWriteForm.camp")) {
			forward = new ActionForward();
			forward.setPath("/view/noticeWriteForm.jsp");
		} else if (command.equals("/noticeWriteSuccess.camp")) {
			action = new NoticeWriteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/noticeDetail.camp")) {
			action = new NoticeDetailAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/noticeModifyForm.camp")) {
			action = new NoticeModifyAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/noticeModifySuccess.camp")) {
			action = new NoticeUpdateAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/noticeDelete.camp")) {
			action = new NoticeDeleteAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		
			//관리자페이지
		} else if (command.equals("/managePagePro.camp")) {
			action = new ManagePageProAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/managePageRez.camp")) {
			action = new ManagePageRezAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}	
		} else if (command.equals("/managePageMem.camp")) {
			action = new ManagePageMemAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}	
		} else if (command.equals("/managePageQna.camp")) {
			action = new ManagePageQnaAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/mgtLogout.camp")) {
	         action = new MgtLogoutAction();
	         try {
	            forward = action.execute(req, res);            
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
		}

		if (forward != null) {
			if (forward.isRedirect()) {
				res.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = req.getRequestDispatcher(forward.getPath());
				dispatcher.forward(req, res);
			}
		}
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doProcess(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doProcess(req, res);
	}
}
