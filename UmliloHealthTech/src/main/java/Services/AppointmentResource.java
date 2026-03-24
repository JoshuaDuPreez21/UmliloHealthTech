package Services;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.io.File;
import java.util.UUID;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
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

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import DAO.AppointmentDAO;
import DAO.AppointmentAttachmentDAO;
import DAO.PatientDAO;
import Models.Appointment;
import Models.AppointmentAttachment;
import Models.Patient;
import Utils.SessionHelper;

@Path("/appointments")
public class AppointmentResource {
	private final SessionHelper helper = new SessionHelper();

	@Path("create")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response createAppointment(String body, @Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		JSONObject jsonObject = new JSONObject(body);
		String idNumber = jsonObject.optString("idNumber", "").trim();
		String dateValue = jsonObject.optString("date", "").trim();
		String timeValue = jsonObject.optString("time", "").trim();
		String notes = jsonObject.optString("notes", "").trim();

		if (idNumber.isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Patient ID number is required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}
		if (dateValue.isEmpty() || timeValue.isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Appointment date and time are required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		PatientDAO patientDAO = new PatientDAO();
		Patient patient = patientDAO.findByIdNumber(idNumber);
		if (patient == null) {
			toReturn.put("error", true);
			toReturn.put("message", "Patient not found.");
			return Response.status(404).entity(toReturn.toString()).build();
		}

		LocalDate date = LocalDate.parse(dateValue);
		LocalTime time = LocalTime.parse(timeValue);
		LocalDateTime dateTime = LocalDateTime.of(date, time);
		Timestamp timestamp = Timestamp.valueOf(dateTime);

		HttpSession session = request.getSession(false);
		String nurseName = session != null ? (String) session.getAttribute("fullName") : null;

		Appointment appointment = new Appointment();
		appointment.setPatientId(patient.getId());
		appointment.setAppointmentTime(timestamp);
		appointment.setStatus("NEW");
		appointment.setNurseName(nurseName);
		appointment.setDoctorName(null);
		appointment.setVisitSummary(notes.isEmpty() ? null : notes);

		AppointmentDAO appointmentDAO = new AppointmentDAO();
		boolean saved = appointmentDAO.createAppointment(appointment);
		if (!saved) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to create appointment.");
			return Response.status(500).entity(toReturn.toString()).build();
		}

		toReturn.put("success", true);
		toReturn.put("appointmentId", appointment.getId());
		toReturn.put("message", "Appointment created.");
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("today")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getTodaysAppointments(@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		HttpSession session = request.getSession(false);
		String nurseName = session != null ? (String) session.getAttribute("fullName") : null;
		if (nurseName == null || nurseName.trim().isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Nurse session not found.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		AppointmentDAO appointmentDAO = new AppointmentDAO();
		List<Appointment> appointments = appointmentDAO.findAppointmentsForNurseOnDate(nurseName, Date.valueOf(LocalDate.now()));

		JSONArray data = new JSONArray();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm");
		for (Appointment appointment : appointments) {
			JSONObject item = new JSONObject();
			item.put("id", appointment.getId());
			item.put("patientName", appointment.getPatientName());
			item.put("patientIdNumber", appointment.getPatientIdNumber());
			item.put("dateTime", appointment.getAppointmentTime() == null ? "-" : formatter.format(appointment.getAppointmentTime().toLocalDateTime()));
			item.put("status", appointment.getStatus());
			data.put(item);
		}

		toReturn.put("success", true);
		toReturn.put("appointments", data);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("detail")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getAppointmentDetail(@QueryParam("id") long id,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		if (id <= 0) {
			toReturn.put("error", true);
			toReturn.put("message", "Appointment ID is required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		AppointmentDAO appointmentDAO = new AppointmentDAO();
		Appointment appointment = appointmentDAO.findAppointmentWithPatient(id);
		if (appointment == null) {
			toReturn.put("error", true);
			toReturn.put("message", "Appointment not found.");
			return Response.status(404).entity(toReturn.toString()).build();
		}

		JSONObject patient = new JSONObject();
		patient.put("name", appointment.getPatientName());
		patient.put("idNumber", appointment.getPatientIdNumber());
		patient.put("cell", appointment.getPatientCell());

		JSONObject appointmentJson = new JSONObject();
		appointmentJson.put("id", appointment.getId());
		appointmentJson.put("status", appointment.getStatus());
		appointmentJson.put("appointmentTime", appointment.getAppointmentTime() == null ? "-" : appointment.getAppointmentTime().toString());
		appointmentJson.put("nurseNotes", appointment.getNurseNotes());
		appointmentJson.put("prescription", appointment.getPrescription());
		appointmentJson.put("doctorSummary", appointment.getDoctorSummary());
		appointmentJson.put("additionalNotes", appointment.getAdditionalNotes());

		toReturn.put("success", true);
		toReturn.put("patient", patient);
		toReturn.put("appointment", appointmentJson);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("capture")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response captureAppointmentNotes(String body, @Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		JSONObject jsonObject = new JSONObject(body);
		long appointmentId = jsonObject.optLong("appointmentId", 0);
		String nurseNotes = jsonObject.optString("nurseNotes", "").trim();
		String prescription = jsonObject.optString("prescription", "").trim();
		String doctorSummary = jsonObject.optString("doctorSummary", "").trim();
		String additionalNotes = jsonObject.optString("additionalNotes", "").trim();

		if (appointmentId <= 0) {
			toReturn.put("error", true);
			toReturn.put("message", "Appointment ID is required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}
		if (nurseNotes.isEmpty() || prescription.isEmpty() || doctorSummary.isEmpty() || additionalNotes.isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "All fields are required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		AppointmentDAO appointmentDAO = new AppointmentDAO();
		boolean updated = appointmentDAO.captureAppointment(appointmentId, nurseNotes, prescription, doctorSummary, additionalNotes);
		if (!updated) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to capture appointment.");
			return Response.status(500).entity(toReturn.toString()).build();
		}

		toReturn.put("success", true);
		toReturn.put("message", "Appointment captured. Status set to Pending Doctor Sign-off.");
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("upload")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public Response uploadAttachment(@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		if (!ServletFileUpload.isMultipartContent(request)) {
			toReturn.put("error", true);
			toReturn.put("message", "Multipart form data required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		Long appointmentId = null;
		FileItem fileItem = null;

		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = upload.parseRequest(request);
			for (FileItem item : items) {
				if (item.isFormField()) {
					if ("appointmentId".equals(item.getFieldName())) {
						String value = item.getString("UTF-8").trim();
						if (!value.isEmpty()) {
							appointmentId = Long.parseLong(value);
						}
					}
				} else if ("file".equals(item.getFieldName())) {
					fileItem = item;
				}
			}
		} catch (Exception e) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to read upload.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		if (appointmentId == null || appointmentId <= 0 || fileItem == null || fileItem.getSize() == 0) {
			toReturn.put("error", true);
			toReturn.put("message", "Appointment and file are required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		String uploadsPath = request.getServletContext().getRealPath("/uploads");
		File uploadDir = new File(uploadsPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		String originalName = new File(fileItem.getName()).getName();
		String storedName = appointmentId + "_" + UUID.randomUUID().toString().replace("-", "") + "_" + originalName;
		File savedFile = new File(uploadDir, storedName);
		try {
			fileItem.write(savedFile);
		} catch (Exception e) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to save file.");
			return Response.status(500).entity(toReturn.toString()).build();
		}

		AppointmentAttachment attachment = new AppointmentAttachment();
		attachment.setAppointmentId(appointmentId);
		attachment.setOriginalName(originalName);
		attachment.setStoredName(storedName);
		attachment.setContentType(fileItem.getContentType());
		attachment.setFileSize(fileItem.getSize());

		AppointmentAttachmentDAO attachmentDAO = new AppointmentAttachmentDAO();
		boolean saved = attachmentDAO.saveAttachment(attachment);
		if (!saved) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to store attachment.");
			return Response.status(500).entity(toReturn.toString()).build();
		}

		toReturn.put("success", true);
		toReturn.put("message", "Attachment uploaded.");
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("attachments")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response listAttachments(@QueryParam("appointmentId") long appointmentId,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		if (appointmentId <= 0) {
			toReturn.put("error", true);
			toReturn.put("message", "Appointment ID is required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		AppointmentAttachmentDAO attachmentDAO = new AppointmentAttachmentDAO();
		List<AppointmentAttachment> attachments = attachmentDAO.findByAppointment(appointmentId);

		JSONArray data = new JSONArray();
		for (AppointmentAttachment attachment : attachments) {
			JSONObject item = new JSONObject();
			item.put("id", attachment.getId());
			item.put("originalName", attachment.getOriginalName());
			item.put("storedName", attachment.getStoredName());
			item.put("contentType", attachment.getContentType());
			item.put("fileSize", attachment.getFileSize());
			data.put(item);
		}

		toReturn.put("success", true);
		toReturn.put("attachments", data);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("status")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response updateStatus(String body, @Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		JSONObject jsonObject = new JSONObject(body);
		long appointmentId = jsonObject.optLong("appointmentId", 0);
		String status = jsonObject.optString("status", "").trim().toUpperCase();

		if (appointmentId <= 0 || status.isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Appointment and status are required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		if (!status.equals("NEW") && !status.equals("PENDING") && !status.equals("WAITING")
				&& !status.equals("IN_PROGRESS") && !status.equals("PENDING_DOCTOR")) {
			toReturn.put("error", true);
			toReturn.put("message", "Invalid status.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		AppointmentDAO appointmentDAO = new AppointmentDAO();
		boolean updated = appointmentDAO.updateAppointmentStatus(appointmentId, status);
		if (!updated) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to update appointment status.");
			return Response.status(500).entity(toReturn.toString()).build();
		}

		toReturn.put("success", true);
		toReturn.put("message", "Status updated.");
		return Response.status(200).entity(toReturn.toString()).build();
	}
}
