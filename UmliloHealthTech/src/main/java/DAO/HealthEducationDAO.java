package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import Utils.DBUtil;

public class HealthEducationDAO {
	public boolean saveContent(String title, String category, String contentType, String language,
			String targetAudience, String tags, String summary, String fullContent, String originalFileName,
			String storedFileName, String fileContentType, Long fileSize, String createdBy) throws SQLException {
		ensureTable();
		String sql = "INSERT INTO health_education_content (title, category, content_type, language, target_audience, " +
				"tags, summary, full_content, original_file_name, stored_file_name, content_type_file, file_size, created_by) " +
				"VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, title);
			ps.setString(2, category);
			ps.setString(3, contentType);
			ps.setString(4, language);
			ps.setString(5, targetAudience);
			ps.setString(6, tags);
			ps.setString(7, summary);
			ps.setString(8, fullContent);
			ps.setString(9, originalFileName);
			ps.setString(10, storedFileName);
			ps.setString(11, fileContentType);
			if (fileSize == null) {
				ps.setNull(12, java.sql.Types.BIGINT);
			} else {
				ps.setLong(12, fileSize);
			}
			ps.setString(13, createdBy);
			return ps.executeUpdate() > 0;
		}
	}

	public JSONArray findContent(String query, String category) throws SQLException, JSONException {
		ensureTable();
		JSONArray results = new JSONArray();
		StringBuilder sql = new StringBuilder(
			"SELECT id, title, category, content_type, language, target_audience, tags, summary, full_content, " +
			"original_file_name, stored_file_name, content_type_file, file_size, created_by, created_at " +
			"FROM health_education_content WHERE 1=1 "
		);
		boolean hasQuery = query != null && !query.trim().isEmpty();
		boolean hasCategory = category != null && !category.trim().isEmpty();
		if (hasQuery) {
			sql.append("AND (title LIKE ? OR category LIKE ? OR summary LIKE ? OR tags LIKE ? OR full_content LIKE ?) ");
		}
		if (hasCategory) {
			sql.append("AND category = ? ");
		}
		sql.append("ORDER BY created_at DESC, id DESC LIMIT 200");

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			int index = 1;
			if (hasQuery) {
				String likeQuery = "%" + query.trim() + "%";
				ps.setString(index++, likeQuery);
				ps.setString(index++, likeQuery);
				ps.setString(index++, likeQuery);
				ps.setString(index++, likeQuery);
				ps.setString(index++, likeQuery);
			}
			if (hasCategory) {
				ps.setString(index++, category.trim());
			}
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					results.put(rowToJson(rs));
				}
			}
		}
		return results;
	}

	public JSONObject findById(Long id) throws SQLException, JSONException {
		ensureTable();
		String sql = "SELECT id, title, category, content_type, language, target_audience, tags, summary, full_content, " +
				"original_file_name, stored_file_name, content_type_file, file_size, created_by, created_at " +
				"FROM health_education_content WHERE id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next() ? rowToJson(rs) : null;
			}
		}
	}

	private JSONObject rowToJson(ResultSet rs) throws SQLException, JSONException {
		JSONObject item = new JSONObject();
		item.put("id", rs.getLong("id"));
		item.put("title", rs.getString("title"));
		item.put("category", rs.getString("category"));
		item.put("contentType", rs.getString("content_type"));
		item.put("language", rs.getString("language"));
		item.put("audience", rs.getString("target_audience"));
		item.put("tags", rs.getString("tags"));
		item.put("summary", rs.getString("summary"));
		item.put("fullContent", rs.getString("full_content"));
		item.put("originalFileName", rs.getString("original_file_name"));
		item.put("storedFileName", rs.getString("stored_file_name"));
		item.put("fileContentType", rs.getString("content_type_file"));
		item.put("fileSize", rs.getLong("file_size"));
		item.put("hasPdf", rs.getString("stored_file_name") != null && !rs.getString("stored_file_name").trim().isEmpty());
		item.put("createdBy", rs.getString("created_by"));
		item.put("createdAt", rs.getTimestamp("created_at") == null ? "-" : rs.getTimestamp("created_at").toString());
		return item;
	}

	private void ensureTable() throws SQLException {
		String sql = "CREATE TABLE IF NOT EXISTS health_education_content (" +
				"id BIGINT PRIMARY KEY AUTO_INCREMENT, " +
				"title VARCHAR(180) NOT NULL, " +
				"category VARCHAR(80) NOT NULL, " +
				"content_type VARCHAR(40) NOT NULL, " +
				"language VARCHAR(40), " +
				"target_audience VARCHAR(80), " +
				"tags VARCHAR(255), " +
				"summary TEXT, " +
				"full_content TEXT, " +
				"original_file_name VARCHAR(255), " +
				"stored_file_name VARCHAR(255), " +
				"content_type_file VARCHAR(120), " +
				"file_size BIGINT, " +
				"created_by VARCHAR(120), " +
				"created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
				"INDEX idx_health_category (category), " +
				"INDEX idx_health_title (title)" +
				")";
		try (Connection conn = DBUtil.getConnection();
				Statement statement = conn.createStatement()) {
			statement.execute(sql);
		}
	}
}
