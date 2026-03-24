package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Models.AppointmentAttachment;
import Utils.DBUtil;

public class AppointmentAttachmentDAO {
	public boolean saveAttachment(AppointmentAttachment attachment) throws SQLException {
		String sql = "INSERT INTO appointment_attachments (appointment_id, original_name, stored_name, content_type, file_size) " +
				"VALUES (?,?,?,?,?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setLong(1, attachment.getAppointmentId());
			ps.setString(2, attachment.getOriginalName());
			ps.setString(3, attachment.getStoredName());
			ps.setString(4, attachment.getContentType());
			if (attachment.getFileSize() == null) {
				ps.setNull(5, java.sql.Types.BIGINT);
			} else {
				ps.setLong(5, attachment.getFileSize());
			}
			int affected = ps.executeUpdate();
			if (affected == 0) {
				return false;
			}
			try (ResultSet keys = ps.getGeneratedKeys()) {
				if (keys.next()) {
					attachment.setId(keys.getLong(1));
				}
			}
			return true;
		}
	}

	public List<AppointmentAttachment> findByAppointment(Long appointmentId) throws SQLException {
		List<AppointmentAttachment> results = new ArrayList<>();
		String sql = "SELECT id, appointment_id, original_name, stored_name, content_type, file_size " +
				"FROM appointment_attachments WHERE appointment_id = ? ORDER BY uploaded_at DESC";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, appointmentId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					AppointmentAttachment attachment = new AppointmentAttachment();
					attachment.setId(rs.getLong("id"));
					attachment.setAppointmentId(rs.getLong("appointment_id"));
					attachment.setOriginalName(rs.getString("original_name"));
					attachment.setStoredName(rs.getString("stored_name"));
					attachment.setContentType(rs.getString("content_type"));
					long size = rs.getLong("file_size");
					if (!rs.wasNull()) {
						attachment.setFileSize(size);
					}
					results.add(attachment);
				}
			}
		}
		return results;
	}
}
