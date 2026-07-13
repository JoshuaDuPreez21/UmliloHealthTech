package Services;

import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

import DAO.HealthEducationDAO;
import Utils.SessionHelper;

@Path("/health-education")
public class HealthEducationResource {
	private final SessionHelper helper = new SessionHelper();

	@Path("list")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response listContent(@QueryParam("query") String query,
			@QueryParam("category") String category,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}

		HealthEducationDAO dao = new HealthEducationDAO();
		JSONArray content = dao.findContent(query, category);
		toReturn.put("success", true);
		toReturn.put("content", content);
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("save")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public Response saveContent(@Context HttpServletRequest request) throws SQLException, JSONException {
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

		String title = "";
		String category = "";
		String contentType = "Article";
		String language = "English";
		String audience = "All Patients";
		String tags = "";
		String summary = "";
		String fullContent = "";
		FileItem pdfItem = null;

		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = upload.parseRequest(request);
			for (FileItem item : items) {
				if (item.isFormField()) {
					String value = item.getString("UTF-8").trim();
					if ("title".equals(item.getFieldName())) title = value;
					if ("category".equals(item.getFieldName())) category = value;
					if ("contentType".equals(item.getFieldName())) contentType = value;
					if ("language".equals(item.getFieldName())) language = value;
					if ("audience".equals(item.getFieldName())) audience = value;
					if ("tags".equals(item.getFieldName())) tags = value;
					if ("summary".equals(item.getFieldName())) summary = value;
					if ("fullContent".equals(item.getFieldName())) fullContent = value;
				} else if ("pdf".equals(item.getFieldName()) && item.getSize() > 0) {
					pdfItem = item;
				}
			}
		} catch (Exception e) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to read submitted content.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		if (title.isEmpty() || category.isEmpty()) {
			toReturn.put("error", true);
			toReturn.put("message", "Title and category are required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}
		if (fullContent.isEmpty() && pdfItem == null) {
			toReturn.put("error", true);
			toReturn.put("message", "Add full content or upload a PDF.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		String originalFileName = null;
		String storedFileName = null;
		String fileContentType = null;
		Long fileSize = null;
		if (pdfItem != null) {
			originalFileName = new File(pdfItem.getName()).getName();
			if (!originalFileName.toLowerCase().endsWith(".pdf")) {
				toReturn.put("error", true);
				toReturn.put("message", "Only PDF files are supported.");
				return Response.status(400).entity(toReturn.toString()).build();
			}

			String uploadsPath = request.getServletContext().getRealPath("/uploads/health-education");
			File uploadDir = new File(uploadsPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			storedFileName = UUID.randomUUID().toString().replace("-", "") + "_" + originalFileName;
			File savedFile = new File(uploadDir, storedFileName);
			try {
				pdfItem.write(savedFile);
			} catch (Exception e) {
				toReturn.put("error", true);
				toReturn.put("message", "Unable to save PDF.");
				return Response.status(500).entity(toReturn.toString()).build();
			}
			fileContentType = pdfItem.getContentType() == null ? "application/pdf" : pdfItem.getContentType();
			fileSize = pdfItem.getSize();
			contentType = "PDF";
		}

		HttpSession session = request.getSession(false);
		Object fullName = session == null ? null : session.getAttribute("fullName");
		String createdBy = fullName == null ? null : String.valueOf(fullName);

		HealthEducationDAO dao = new HealthEducationDAO();
		boolean saved = dao.saveContent(title, category, contentType, language, audience, tags, summary, fullContent,
				originalFileName, storedFileName, fileContentType, fileSize, createdBy);
		if (!saved) {
			toReturn.put("error", true);
			toReturn.put("message", "Unable to save health content.");
			return Response.status(500).entity(toReturn.toString()).build();
		}

		toReturn.put("success", true);
		toReturn.put("message", "Health content saved.");
		return Response.status(200).entity(toReturn.toString()).build();
	}

	@Path("file")
	@GET
	public Response getPdf(@QueryParam("id") long id,
			@Context HttpServletRequest request) throws SQLException, JSONException {
		JSONObject toReturn = new JSONObject();

		boolean isValidSession = helper.validateSession(request);
		if (!isValidSession) {
			return Response.status(401).entity(toReturn.toString()).build();
		}
		if (id <= 0) {
			toReturn.put("error", true);
			toReturn.put("message", "Content ID is required.");
			return Response.status(400).entity(toReturn.toString()).build();
		}

		HealthEducationDAO dao = new HealthEducationDAO();
		JSONObject content = dao.findById(id);
		if (content == null || !content.optBoolean("hasPdf")) {
			toReturn.put("error", true);
			toReturn.put("message", "PDF not found.");
			return Response.status(404).entity(toReturn.toString()).build();
		}

		String uploadsPath = request.getServletContext().getRealPath("/uploads/health-education");
		File file = new File(uploadsPath, content.optString("storedFileName"));
		if (!file.exists()) {
			toReturn.put("error", true);
			toReturn.put("message", "PDF file is missing.");
			return Response.status(404).entity(toReturn.toString()).build();
		}

		String originalName = content.optString("originalFileName", "health-education.pdf").replace("\"", "");
		return Response.ok(file, "application/pdf")
				.header("Content-Disposition", "inline; filename=\"" + originalName + "\"")
				.build();
	}
}
