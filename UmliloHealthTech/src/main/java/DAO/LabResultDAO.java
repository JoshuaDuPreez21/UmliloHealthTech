package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import Utils.DBUtil;

public class LabResultDAO {
	public boolean saveLabResult(Long patientId, Timestamp resultDate, String testName, String resultValue,
			String status, String orderedBy, String notes) throws SQLException {
		String sql = "INSERT INTO patient_lab_results (patient_id, result_date, test_name, result_value, status, ordered_by, notes) " +
				"VALUES (?,?,?,?,?,?,?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setLong(1, patientId);
			ps.setTimestamp(2, resultDate);
			ps.setString(3, testName);
			ps.setString(4, resultValue);
			ps.setString(5, status);
			ps.setString(6, orderedBy);
			ps.setString(7, notes);
			return ps.executeUpdate() > 0;
		}
	}

	public JSONArray findByPatient(Long patientId) throws SQLException, JSONException {
		JSONArray results = new JSONArray();
		String sql = "SELECT id, result_date, test_name, result_value, status, ordered_by, notes " +
				"FROM patient_lab_results WHERE patient_id = ? ORDER BY result_date DESC";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, patientId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					JSONObject item = new JSONObject();
					item.put("id", rs.getLong("id"));
					item.put("date", rs.getTimestamp("result_date") == null ? "-" : rs.getTimestamp("result_date").toString());
					item.put("testName", rs.getString("test_name"));
					item.put("resultValue", rs.getString("result_value"));
					item.put("status", rs.getString("status"));
					item.put("orderedBy", rs.getString("ordered_by"));
					item.put("notes", rs.getString("notes"));
					item.put("summary", rs.getString("test_name"));
					item.put("additionalNotes", rs.getString("notes"));
					results.put(item);
				}
			}
		}
		return results;
	}
}
