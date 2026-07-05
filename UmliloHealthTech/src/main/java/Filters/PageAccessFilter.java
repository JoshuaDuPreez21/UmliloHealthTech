package Filters;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PageAccessFilter implements Filter {
	private final Map<String, String> roleRoutes = new HashMap<>();

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		roleRoutes.put("/doctor", "doctor");
		roleRoutes.put("/doctor-appointment", "doctor");
		roleRoutes.put("/home", "nurse");
		roleRoutes.put("/patient", "nurse");
		roleRoutes.put("/appointment", "nurse");
		roleRoutes.put("/current-appointment", "nurse");
		roleRoutes.put("/capture-appointment", "nurse");
		roleRoutes.put("/screening", "nurse");
		roleRoutes.put("/health-education", "nurse");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String contextPath = httpRequest.getContextPath();
		String path = httpRequest.getRequestURI().substring(contextPath.length());
		HttpSession session = httpRequest.getSession(false);
		boolean loggedIn = session != null && session.getAttribute("userId") != null;

		if ("/".equals(path) || "/login".equals(path)) {
			if (loggedIn) {
				String role = String.valueOf(session.getAttribute("role"));
				httpResponse.sendRedirect(contextPath + ("doctor".equalsIgnoreCase(role) ? "/doctor" : "/home"));
				return;
			}
			if ("/".equals(path)) {
				httpResponse.sendRedirect(contextPath + "/login");
				return;
			}
		}

		if (path.endsWith(".jsp")) {
			String cleanPath = path.substring(0, path.length() - 4);
			String queryString = httpRequest.getQueryString();
			httpResponse.sendRedirect(contextPath + cleanPath + (queryString == null ? "" : "?" + queryString));
			return;
		}

		if (isPublicPath(path)) {
			chain.doFilter(request, response);
			return;
		}

		if (!loggedIn) {
			httpResponse.sendRedirect(contextPath + "/login");
			return;
		}

		String expectedRole = roleRoutes.get(path);
		if (expectedRole != null) {
			String actualRole = String.valueOf(session.getAttribute("role"));
			if (!expectedRole.equalsIgnoreCase(actualRole)) {
				httpResponse.sendRedirect(contextPath + ("doctor".equalsIgnoreCase(actualRole) ? "/doctor" : "/home"));
				return;
			}
		}

		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
	}

	private boolean isPublicPath(String path) {
		return path == null
				|| path.isEmpty()
				|| "/login".equals(path)
				|| "/logout".equals(path)
				|| path.startsWith("/rest/")
				|| path.startsWith("/img/")
				|| path.startsWith("/css/")
				|| path.startsWith("/js/")
				|| path.startsWith("/uploads/");
	}
}
