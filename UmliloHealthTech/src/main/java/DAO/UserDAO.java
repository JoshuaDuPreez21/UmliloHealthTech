package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Models.User;
import Utils.DBUtil;

public class UserDAO {
	public User getByStaffId(String staffId) throws SQLException {
		String sql = "SELECT id, staff_id, full_name, role, password_hash, active FROM users WHERE staff_id = ? LIMIT 1";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, staffId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setId(rs.getLong("id"));
					user.setStaffId(rs.getString("staff_id"));
					user.setFullName(rs.getString("full_name"));
					user.setRole(rs.getString("role"));
					user.setPasswordHash(rs.getString("password_hash"));
					user.setActive(rs.getBoolean("active"));
					return user;
				}
			}
		}
		return null;
	}
}
