package Services;

import java.sql.SQLException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;

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

import DAO.AppointmentDAO;
import DAO.PatientDAO;
import Models.Appointment;
import Models.Patient;
import Utils.SessionHelper;

@Path("/patients")
public class PatientResource {
	private final SessionHelper helper = new SessionHelper();

	@Path("dashboard")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getNurseDashboard(@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		HttpSession session = request.getSession(false);
		String nurseName = session != null ? (String) session.getAttribute("fullName") : "";

		PatientDAO patientDAO = new PatientDAO();
		AppointmentDAO appointmentDAO = new AppointmentDAO();
		Date today = Date.valueOf(LocalDate.now());
		List<Appointment> todaysAppointments = appointmentDAO.findAppointmentsForNurseOnDate(nurseName, today);
		SimpleDateFormat formatter = new SimpleDateFormat("dd MMM yyyy");
		JSONArray recentPatients = new JSONArray();
		for (Appointment appointment : todaysAppointments) {
			JSONObject item = new JSONObject();
			item.put("appointmentId", appointment.getId());
			item.put("patientName", appointment.getPatientName());
			item.put("idNumber", appointment.getPatientIdNumber());
			item.put("dateOfVisit", appointment.getAppointmentTime() == null ? "-" : formatter.format(appointment.getAppointmentTime()));
			item.put("status", appointment.getStatus());
			recentPatients.put(item);
		}

		toReturn.put("success", true);
		toReturn.put("fullName", nurseName);
		toReturn.put("patientsCapturedToday", patientDAO.countPatientsCapturedToday());
		toReturn.put("totalPatients", patientDAO.countPatients());
		toReturn.put("todaysAppointments", todaysAppointments.size());
		toReturn.put("inConsultation", appointmentDAO.countAppointmentsForNurseByStatusOnDate(nurseName, "IN_PROGRESS", today));
		toReturn.put("pendingLabResults", 0);
		toReturn.put("activePrescriptions", appointmentDAO.countActivePrescriptionsForNurse(nurseName));
		toReturn.put("recentPatients", recentPatients);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("search-list")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response searchPatients(@QueryParam("query") String query,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		if (query == null || query.trim().isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Search query is required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		String normalizedQuery = query.trim().replaceAll("\\s+", "");
		PatientDAO patientDAO = new PatientDAO();
		List<Patient> matches = patientDAO.findMatches(normalizedQuery, 8);

		JSONArray results = new JSONArray();
		for (Patient patient : matches) {
			JSONObject item = new JSONObject();
			item.put("id", patient.getId());
			item.put("fullName", patient.getFirstName() + " " + patient.getSurname());
			item.put("idNumber", patient.getIdNumber());
			item.put("cell", patient.getCell());
			results.put(item);
		}

		toReturn.put("success", true);
		toReturn.put("patients", results);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("list")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response listPatients(@QueryParam("query") String query,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		PatientDAO patientDAO = new PatientDAO();
		List<Patient> patients = patientDAO.findRecentPatients(query, 60);
		JSONArray results = new JSONArray();
		for (Patient patient : patients) {
			results.put(patientToJson(patient));
		}

		toReturn.put("success", true);
		toReturn.put("patients", results);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("detail")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getPatientDetail(@QueryParam("id") long id,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		PatientDAO patientDAO = new PatientDAO();
		Patient patient = patientDAO.findById(id);
		if (patient == null) {
			toReturn.put("error", true);
			toReturn.put("message", "Patient not found.");
			return Response.status(404).entity(toReturn.toString()).build();
		}

		AppointmentDAO appointmentDAO = new AppointmentDAO();
		List<Appointment> appointments = appointmentDAO.findAppointmentsByPatient(patient.getId(), "all");
		SimpleDateFormat formatter = new SimpleDateFormat("dd MMM yyyy, HH:mm");

		JSONArray visits = new JSONArray();
		JSONArray prescriptions = new JSONArray();
		JSONArray diagnoses = new JSONArray();
		JSONArray medicalHistory = new JSONArray();
		for (Appointment appointment : appointments) {
			JSONObject visit = appointmentToJson(appointment, formatter);
			visits.put(visit);
			medicalHistory.put(visit);

			if (appointment.getDoctorSummary() != null && !appointment.getDoctorSummary().trim().isEmpty()) {
				JSONObject diagnosis = appointmentToJson(appointment, formatter);
				diagnosis.put("diagnosis", appointment.getDoctorSummary());
				diagnoses.put(diagnosis);
			}

			if (appointment.getPrescription() != null && !appointment.getPrescription().trim().isEmpty()) {
				JSONObject prescription = appointmentToJson(appointment, formatter);
				prescription.put("prescription", appointment.getPrescription());
				prescriptions.put(prescription);
			}
		}

		toReturn.put("success", true);
		toReturn.put("patient", patientToJson(patient));
		toReturn.put("medicalHistory", medicalHistory);
		toReturn.put("visits", visits);
		toReturn.put("diagnoses", diagnoses);
		toReturn.put("prescriptions", prescriptions);
		toReturn.put("labResults", new JSONArray());
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("search")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response searchPatient(@QueryParam("query") String query,
			@QueryParam("filter") String filter,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		if (query == null || query.trim().isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Search query is required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		String normalizedQuery = query.trim().replaceAll("\\s+", "");

		PatientDAO patientDAO = new PatientDAO();
		Patient patient = patientDAO.findByQuery(normalizedQuery);
		if (patient == null) {
			toReturn.put("error", true);
			toReturn.put("message", "Patient not found.");
			return Response.status(404).entity(toReturn.toString()).build();
		}

		AppointmentDAO appointmentDAO = new AppointmentDAO();
		List<Appointment> appointments = appointmentDAO.findAppointmentsByPatient(patient.getId(), filter);
		Appointment openAppointment = appointmentDAO.findOpenAppointmentByPatient(patient.getId());

		JSONObject patientJson = new JSONObject();
		patientJson.put("id", patient.getId());
		patientJson.put("fullName", patient.getFirstName() + " " + patient.getSurname());
		patientJson.put("idNumber", patient.getIdNumber());
		patientJson.put("cell", patient.getCell());
		patientJson.put("nextOfKinName", patient.getNextOfKinName());
		patientJson.put("gender", patient.getGender());
		patientJson.put("email", patient.getEmail());
		patientJson.put("address", patient.getAddress());
		patientJson.put("employmentStatus", patient.getEmploymentStatus());
		patientJson.put("jobTitle", patient.getJobTitle());
		patientJson.put("nextOfKinRelation", patient.getNextOfKinRelation());
		patientJson.put("emergencyContact", patient.getEmergencyContact());
		patientJson.put("nationality", patient.getNationality());
		patientJson.put("foreignId", patient.getForeignId());
		patientJson.put("illnesses", patient.getIllnesses());
		patientJson.put("illnessNotes", patient.getIllnessNotes());

		JSONArray historyArray = new JSONArray();
		SimpleDateFormat formatter = new SimpleDateFormat("dd MMM yyyy HH:mm");
		for (Appointment appointment : appointments) {
			JSONObject item = new JSONObject();
			item.put("date", appointment.getAppointmentTime() == null ? "-" : formatter.format(appointment.getAppointmentTime()));
			item.put("summary", appointment.getVisitSummary());
			item.put("nurseName", appointment.getNurseName());
			item.put("doctorName", appointment.getDoctorName());
			item.put("status", appointment.getStatus());
			historyArray.put(item);
		}

		JSONObject openAppointmentJson = null;
		if (openAppointment != null) {
			openAppointmentJson = new JSONObject();
			openAppointmentJson.put("id", openAppointment.getId());
			openAppointmentJson.put("date", openAppointment.getAppointmentTime() == null ? "-" : formatter.format(openAppointment.getAppointmentTime()));
			openAppointmentJson.put("status", openAppointment.getStatus());
			openAppointmentJson.put("nurseName", openAppointment.getNurseName());
			openAppointmentJson.put("doctorName", openAppointment.getDoctorName());
		}

		toReturn.put("success", true);
		toReturn.put("patient", patientJson);
		toReturn.put("appointmentHistory", historyArray);
		toReturn.put("openAppointment", openAppointmentJson == null ? JSONObject.NULL : openAppointmentJson);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("save")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response savePatient(String body, @Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		try {
			boolean isValidSession = helper.validateSession(request);
			if (!isValidSession) {
				return Response.status(401).entity(toReturn.toString()).build();
			}

			JSONObject jsonObject = new JSONObject(body);

			String firstName = validateField(jsonObject, "firstName", toReturn);
			if (firstName == null) return Response.status(400).entity(toReturn.toString()).build();

			String surname = validateField(jsonObject, "surname", toReturn);
			if (surname == null) return Response.status(400).entity(toReturn.toString()).build();

			String cell = validateField(jsonObject, "cell", toReturn);
			if (cell == null) return Response.status(400).entity(toReturn.toString()).build();

			boolean consent = jsonObject.optBoolean("consent", false);
			if (!consent) {
				toReturn.put("error", true);
				toReturn.put("message", "Consent is required.");
				return Response.status(400).entity(toReturn.toString()).build();
			}

			Patient patient = new Patient();
			patient.setFirstName(firstName);
			patient.setSurname(surname);
			patient.setIdNumber(jsonObject.optString("idNumber", null));
			patient.setCell(cell);
			patient.setGender(jsonObject.optString("gender", null));
			patient.setAddress(jsonObject.optString("address", null));
			patient.setEmail(jsonObject.optString("email", null));
			patient.setEmploymentStatus(jsonObject.optString("employmentStatus", null));
			patient.setJobTitle(jsonObject.optString("jobTitle", null));
			patient.setNextOfKinName(jsonObject.optString("nextOfKinName", null));
			patient.setNextOfKinRelation(jsonObject.optString("nextOfKinRelation", null));
			patient.setEmergencyContact(jsonObject.optString("emergencyContact", null));
			patient.setSouthAfrican(jsonObject.optBoolean("isSouthAfrican", true));
			patient.setNationality(jsonObject.optString("nationality", null));
			patient.setForeignId(jsonObject.optString("foreignId", null));
			patient.setIllnesses(jsonObject.optString("illnesses", null));
			patient.setIllnessNotes(jsonObject.optString("illnessNotes", null));
			patient.setConsent(consent);

			PatientDAO patientDAO = new PatientDAO();
			boolean saved = patientDAO.savePatient(patient);
			if (!saved) {
				toReturn.put("error", true);
				toReturn.put("message", "Unable to save patient.");
				return Response.status(500).entity(toReturn.toString()).build();
			}

			toReturn.put("success", true);
			toReturn.put("patientId", patient.getId());
			toReturn.put("message", "Patient saved successfully.");

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

	private JSONObject patientToJson(Patient patient) throws JSONException {
		JSONObject patientJson = new JSONObject();
		patientJson.put("id", patient.getId());
		patientJson.put("firstName", patient.getFirstName());
		patientJson.put("surname", patient.getSurname());
		patientJson.put("fullName", patient.getFirstName() + " " + patient.getSurname());
		patientJson.put("idNumber", patient.getIdNumber());
		patientJson.put("cell", patient.getCell());
		patientJson.put("gender", patient.getGender());
		patientJson.put("email", patient.getEmail());
		patientJson.put("address", patient.getAddress());
		patientJson.put("employmentStatus", patient.getEmploymentStatus());
		patientJson.put("jobTitle", patient.getJobTitle());
		patientJson.put("nextOfKinName", patient.getNextOfKinName());
		patientJson.put("nextOfKinRelation", patient.getNextOfKinRelation());
		patientJson.put("emergencyContact", patient.getEmergencyContact());
		patientJson.put("nationality", patient.getNationality());
		patientJson.put("foreignId", patient.getForeignId());
		patientJson.put("illnesses", patient.getIllnesses());
		patientJson.put("illnessNotes", patient.getIllnessNotes());
		patientJson.put("consent", patient.isConsent());
		patientJson.put("allergies", "Not recorded");
		return patientJson;
	}

	private JSONObject appointmentToJson(Appointment appointment, SimpleDateFormat formatter) throws JSONException {
		JSONObject item = new JSONObject();
		item.put("id", appointment.getId());
		item.put("date", appointment.getAppointmentTime() == null ? "-" : formatter.format(appointment.getAppointmentTime()));
		item.put("status", appointment.getStatus());
		item.put("summary", appointment.getVisitSummary());
		item.put("nurseName", appointment.getNurseName());
		item.put("doctorName", appointment.getDoctorName());
		item.put("nurseNotes", appointment.getNurseNotes());
		item.put("prescription", appointment.getPrescription());
		item.put("doctorSummary", appointment.getDoctorSummary());
		item.put("additionalNotes", appointment.getAdditionalNotes());
		return item;
	}
}
