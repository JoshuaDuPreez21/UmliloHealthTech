package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Utils.DBUtil;

public class OtpDAO {
	public boolean isOtpBypass(String staffId) throws SQLException {
		String sql = "SELECT 1 FROM otp_bypass WHERE staff_id = ? AND active = 1 LIMIT 1";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, staffId);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		}
	}

	public boolean verifyOtp(String staffId, String otpCode) throws SQLException {
		String sql = "SELECT id FROM otp_tokens WHERE staff_id = ? AND otp_code = ? AND used = 0 AND expires_at > NOW() ORDER BY created_at DESC LIMIT 1";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, staffId);
			ps.setString(2, otpCode);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					long tokenId = rs.getLong("id");
					markUsed(conn, tokenId);
					return true;
				}
			}
		}
		return false;
	}

	private void markUsed(Connection conn, long tokenId) throws SQLException {
		String update = "UPDATE otp_tokens SET used = 1 WHERE id = ?";
		try (PreparedStatement ps = conn.prepareStatement(update)) {
			ps.setLong(1, tokenId);
			ps.executeUpdate();
		}
	}
}
