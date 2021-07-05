package action.qna;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.qna.QnaBean;
import service.qna.FaqListService;
import util.Action;
import util.ActionForward;

 public class FaqListAction implements Action {
	 
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 
		ArrayList<QnaBean> faqList=new ArrayList<QnaBean>();
		
		FaqListService faqListService = new FaqListService();
		faqList = faqListService.getFaqList();
		
		request.setAttribute("faqList", faqList);
		ActionForward forward= new ActionForward();
   		forward.setPath("/view/faq.jsp");
   		return forward;
   		
		
   		
	 }
 }