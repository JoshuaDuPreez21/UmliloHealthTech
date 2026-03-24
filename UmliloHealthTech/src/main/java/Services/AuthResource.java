package Services;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.JSONException;
import org.json.JSONObject;

import DAO.OtpDAO;
import DAO.UserDAO;
import Models.User;
import Utils.PasswordUtil;
import Utils.SessionHelper;

@Path("/auth")
public class AuthResource {
	private final SessionHelper helper = new SessionHelper();

	@Path("login")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response login(String body, @Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		try {
			JSONObject jsonObject = new JSONObject(body);
			String staffId = validateField(jsonObject, "staffId", toReturn);
			if (staffId == null) return Response.status(400).entity(toReturn.toString()).build();
			String password = validateField(jsonObject, "password", toReturn);
			if (password == null) return Response.status(400).entity(toReturn.toString()).build();
			String requestedRole = validateField(jsonObject, "role", toReturn);
			if (requestedRole == null) return Response.status(400).entity(toReturn.toString()).build();

			UserDAO userDAO = new UserDAO();
			User user = userDAO.getByStaffId(staffId);
			if (user == null || !user.isActive()) {
				toReturn.put("error", true);
				toReturn.put("message", "Invalid credentials.");
				return Response.status(401).entity(toReturn.toString()).build();
			}

			boolean validPassword = PasswordUtil.verifyPassword(password, user.getPasswordHash());
			if (!validPassword) {
				toReturn.put("error", true);
				toReturn.put("message", "Invalid credentials.");
				return Response.status(401).entity(toReturn.toString()).build();
			}

			if (user.getRole() == null || !user.getRole().equalsIgnoreCase(requestedRole)) {
				toReturn.put("error", true);
				toReturn.put("message", "Role mismatch.");
				return Response.status(403).entity(toReturn.toString()).build();
			}

			OtpDAO otpDAO = new OtpDAO();
			boolean bypassOtp = otpDAO.isOtpBypass(staffId);
			if (!bypassOtp) {
				String otp = jsonObject.has("otp") ? jsonObject.getString("otp").trim() : "";
				if (otp.isEmpty()) {
					toReturn.put("error", true);
					toReturn.put("message", "OTP is required.");
					toReturn.put("otpRequired", true);
					return Response.status(400).entity(toReturn.toString()).build();
				}
				boolean otpValid = otpDAO.verifyOtp(staffId, otp);
				if (!otpValid) {
					toReturn.put("error", true);
					toReturn.put("message", "Invalid OTP.");
					return Response.status(401).entity(toReturn.toString()).build();
				}
			}

			helper.establishSession(request, user.getId(), user.getRole(), user.getFullName());
			toReturn.put("success", true);
			toReturn.put("message", "Login successful.");
			toReturn.put("role", user.getRole());
			toReturn.put("otpRequired", false);

		} catch (JSONException e) {
			e.printStackTrace();
			toReturn.put("error", true);
			toReturn.put("message", "Invalid JSON input.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		return Response.status(200).entity(toReturn.toString()).build();
	}

	private String validateField(JSONObject jsonObject, String field, JSONObject toReturn) throws JSONException {
		if (!jsonObject.has(field) || jsonObject.getString(field).trim().isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", field + " is required.");
			return null;
		}
		return jsonObject.getString(field).trim();
	}
}
