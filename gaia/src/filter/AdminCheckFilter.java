package filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javaBean.auth.AuthBean;

public class AdminCheckFilter implements Filter {
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
            AuthBean authbean = (AuthBean) session.getAttribute("authUser");
            if (authbean != null && authbean.getMEM_ID().equals("admin")) {
                login = true;

            }
        }
        if (login) {
            chain.doFilter(request, response);
        } else {
			response.setContentType("text/html;charset=UTF-8");
        	PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('접근 권한이 없습니다.');");
			out.println("window.location.href='login.camp';");
			out.println("</script>");

        }
    }

    @Override
    public void destroy() {
    }
}