package filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginCheckFilter implements Filter {
    @Override
    public void init(FilterConfig config) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);

        boolean login = false;
        if (session != null) {
            if (session.getAttribute("authUser") != null) {
                login = true;
            }
        }
        if (login) {
            chain.doFilter(request, response);
        } else {
			response.setContentType("text/html;charset=UTF-8");
        	PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 페이지로 이동합니다.');");
			out.println("window.location.href='login.camp';");
			out.println("</script>");
//            RequestDispatcher dispatcher = request
 //                   .getRequestDispatcher("/login.camp");
  //          dispatcher.forward(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}