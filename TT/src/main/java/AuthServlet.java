import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/api/auth/login")
public class AuthServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 3611829141097792817L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        LoginRequest login = JsonUtil.fromJson(req, LoginRequest.class);

        User user = userDAO.findByEmail(login.getEmail());

        if (user == null || !PasswordUtil.verify(login.getPassword(), user.getPasswordHash())) {
            resp.setStatus(401);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("USER_ID", user.getId());
        session.setAttribute("ROLE_ID", user.getRoleId());

        resp.setStatus(200);
    }
}
