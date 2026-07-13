package Services;

import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import DAO.PatientDAO;
import DAO.ScreeningDAO;
import Models.Patient;
import Utils.SessionHelper;

@Path("/screenings")
public class ScreeningResource {
	private final SessionHelper helper = new SessionHelper();

	@Path("list")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response listScreenings(@QueryParam("query") String query,
			@QueryParam("formType") String formType,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		ScreeningDAO screeningDAO = new ScreeningDAO();
		JSONArray screenings = screeningDAO.findScreenings(query, formType);
		toReturn.put("success", true);
		toReturn.put("screenings", screenings);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("save")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response saveScreening(String body, @Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		JSONObject jsonObject = new JSONObject(body);
		long patientId = jsonObject.optLong("patientId", 0);
		String formType = jsonObject.optString("formType", "").trim();
		String dateValue = jsonObject.optString("date", "").trim();
		String result = jsonObject.optString("result", "").trim();
		String screenedBy = jsonObject.optString("screenedBy", "").trim();
		String actionTaken = jsonObject.optString("actionTaken", "").trim();
		boolean followupRequired = jsonObject.optBoolean("followupRequired", false);
		String notes = jsonObject.optString("notes", "").trim();

		if (patientId <= 0 || formType.isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Patient and form type are required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		PatientDAO patientDAO = new PatientDAO();
		Patient patient = patientDAO.findById(patientId);
		if (patient == null) {
			toReturn.put("error", true);
			toReturn.put("message", "Patient not found.");
			return Response.status(404).entity(toReturn.toString()).build();
		}

		if (screenedBy.isEmpty()) {
			HttpSession session = request.getSession(false);
			Object fullName = session == null ? null : session.getAttribute("fullName");
			screenedBy = fullName == null ? null : String.valueOf(fullName);
		}

		ScreeningDAO screeningDAO = new ScreeningDAO();
		boolean saved = screeningDAO.saveScreening(patientId, formType, parseDate(dateValue),
				result.isEmpty() ? null : result,
				screenedBy == null || screenedBy.trim().isEmpty() ? null : screenedBy,
				actionTaken.isEmpty() ? null : actionTaken,
				followupRequired,
				notes.isEmpty() ? null : notes);
		if (!saved) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to save screening.");
			return Response.status(500).entity(toReturn.toString()).build();
		}

		toReturn.put("success", true);
		toReturn.put("message", "Screening saved.");
		return Response.status(200).entity(toReturn.toString()).build();
	}

	private Date parseDate(String dateValue) {
		if (dateValue == null || dateValue.trim().isEmpty()) {
			return Date.valueOf(LocalDate.now());
		}
		return Date.valueOf(LocalDate.parse(dateValue.trim()));
	}
}
