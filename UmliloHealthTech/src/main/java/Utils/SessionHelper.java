package Utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionHelper {
	public boolean validateSession(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return false;
		}
		return session.getAttribute("userId") != null;
	}

	public void establishSession(HttpServletRequest request, Long userId, String role, String fullName) {
		HttpSession session = request.getSession(true);
		session.setAttribute("userId", userId);
		session.setAttribute("role", role);
		session.setAttribute("fullName", fullName);
		session.setMaxInactiveInterval(1800);
	}
}
