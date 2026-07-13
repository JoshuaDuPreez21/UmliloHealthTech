package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import Utils.DBUtil;

public class ScreeningDAO {
	public boolean saveScreening(Long patientId, String formType, Date screeningDate, String result,
			String screenedBy, String actionTaken, boolean followupRequired, String notes) throws SQLException {
		ensureTable();
		String sql = "INSERT INTO patient_screenings (patient_id, form_type, screening_date, result, screened_by, action_taken, followup_required, notes) " +
				"VALUES (?,?,?,?,?,?,?,?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setLong(1, patientId);
			ps.setString(2, formType);
			ps.setDate(3, screeningDate);
			ps.setString(4, result);
			ps.setString(5, screenedBy);
			ps.setString(6, actionTaken);
			ps.setBoolean(7, followupRequired);
			ps.setString(8, notes);
			return ps.executeUpdate() > 0;
		}
	}

	public JSONArray findScreenings(String query, String formType) throws SQLException, JSONException {
		ensureTable();
		JSONArray results = new JSONArray();
		StringBuilder sql = new StringBuilder(
			"SELECT s.id, s.patient_id, s.form_type, s.screening_date, s.result, s.screened_by, " +
			"s.action_taken, s.followup_required, s.notes, p.first_name, p.surname, p.id_number " +
			"FROM patient_screenings s JOIN patients p ON p.id = s.patient_id WHERE 1=1 "
		);
		boolean hasQuery = query != null && !query.trim().isEmpty();
		boolean hasFormType = formType != null && !formType.trim().isEmpty();
		if (hasQuery) {
			sql.append("AND (p.first_name LIKE ? OR p.surname LIKE ? OR p.id_number LIKE ?) ");
		}
		if (hasFormType) {
			sql.append("AND s.form_type = ? ");
		}
		sql.append("ORDER BY s.screening_date DESC, s.id DESC LIMIT 200");

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			int index = 1;
			if (hasQuery) {
				String likeQuery = "%" + query.trim() + "%";
				ps.setString(index++, likeQuery);
				ps.setString(index++, likeQuery);
				ps.setString(index++, likeQuery);
			}
			if (hasFormType) {
				ps.setString(index++, formType.trim());
			}
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					JSONObject item = new JSONObject();
					item.put("id", rs.getLong("id"));
					item.put("patientId", rs.getLong("patient_id"));
					item.put("patientName", rs.getString("first_name") + " " + rs.getString("surname"));
					item.put("patientIdNumber", rs.getString("id_number"));
					item.put("formType", rs.getString("form_type"));
					item.put("date", rs.getDate("screening_date") == null ? "-" : rs.getDate("screening_date").toString());
					item.put("result", rs.getString("result"));
					item.put("screenedBy", rs.getString("screened_by"));
					item.put("actionTaken", rs.getString("action_taken"));
					item.put("followupRequired", rs.getBoolean("followup_required"));
					item.put("notes", rs.getString("notes"));
					results.put(item);
				}
			}
		}
		return results;
	}

	private void ensureTable() throws SQLException {
		String sql = "CREATE TABLE IF NOT EXISTS patient_screenings (" +
				"id BIGINT PRIMARY KEY AUTO_INCREMENT, " +
				"patient_id BIGINT NOT NULL, " +
				"form_type VARCHAR(120) NOT NULL, " +
				"screening_date DATE NOT NULL, " +
				"result VARCHAR(40), " +
				"screened_by VARCHAR(120), " +
				"action_taken VARCHAR(255), " +
				"followup_required TINYINT(1) NOT NULL DEFAULT 0, " +
				"notes TEXT, " +
				"created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
				"INDEX idx_screening_patient (patient_id), " +
				"INDEX idx_screening_type (form_type), " +
				"CONSTRAINT fk_screening_patient FOREIGN KEY (patient_id) REFERENCES patients(id)" +
				")";
		try (Connection conn = DBUtil.getConnection();
				Statement statement = conn.createStatement()) {
			statement.execute(sql);
		}
	}
}
