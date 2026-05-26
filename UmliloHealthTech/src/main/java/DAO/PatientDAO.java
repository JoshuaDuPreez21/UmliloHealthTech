package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Models.Patient;
import Utils.DBUtil;

public class PatientDAO {
	public boolean savePatient(Patient patient) throws SQLException {
		String sql = "INSERT INTO patients (first_name, surname, id_number, cell, gender, address, email, employment_status, job_title, " +
				"next_of_kin_name, next_of_kin_relation, emergency_contact, is_south_african, nationality, foreign_id, illnesses, illness_notes, consent) " +
				"VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, patient.getFirstName());
			ps.setString(2, patient.getSurname());
			ps.setString(3, patient.getIdNumber());
			ps.setString(4, patient.getCell());
			ps.setString(5, patient.getGender());
			ps.setString(6, patient.getAddress());
			ps.setString(7, patient.getEmail());
			ps.setString(8, patient.getEmploymentStatus());
			ps.setString(9, patient.getJobTitle());
			ps.setString(10, patient.getNextOfKinName());
			ps.setString(11, patient.getNextOfKinRelation());
			ps.setString(12, patient.getEmergencyContact());
			ps.setBoolean(13, patient.isSouthAfrican());
			ps.setString(14, patient.getNationality());
			ps.setString(15, patient.getForeignId());
			ps.setString(16, patient.getIllnesses());
			ps.setString(17, patient.getIllnessNotes());
			ps.setBoolean(18, patient.isConsent());
			int affected = ps.executeUpdate();
			if (affected == 0) {
				return false;
			}
			try (ResultSet keys = ps.getGeneratedKeys()) {
				if (keys.next()) {
					patient.setId(keys.getLong(1));
				}
			}
			return true;
		}
	}

	public int countPatients() throws SQLException {
		String sql = "SELECT COUNT(*) AS total FROM patients";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getInt("total") : 0;
		}
	}

	public int countPatientsCapturedToday() throws SQLException {
		String sql = "SELECT COUNT(*) AS total FROM patients WHERE DATE(created_at) = CURDATE()";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getInt("total") : 0;
		}
	}

	public Patient findByIdNumber(String idNumber) throws SQLException {
		String sql = "SELECT id, first_name, surname, id_number, cell, gender, address, email, employment_status, job_title, " +
				"next_of_kin_name, next_of_kin_relation, emergency_contact, is_south_african, nationality, foreign_id, illnesses, illness_notes, consent " +
				"FROM patients WHERE id_number = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, idNumber);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Patient patient = new Patient();
					patient.setId(rs.getLong("id"));
					patient.setFirstName(rs.getString("first_name"));
					patient.setSurname(rs.getString("surname"));
					patient.setIdNumber(rs.getString("id_number"));
					patient.setCell(rs.getString("cell"));
					patient.setGender(rs.getString("gender"));
					patient.setAddress(rs.getString("address"));
					patient.setEmail(rs.getString("email"));
					patient.setEmploymentStatus(rs.getString("employment_status"));
					patient.setJobTitle(rs.getString("job_title"));
					patient.setNextOfKinName(rs.getString("next_of_kin_name"));
					patient.setNextOfKinRelation(rs.getString("next_of_kin_relation"));
					patient.setEmergencyContact(rs.getString("emergency_contact"));
					patient.setSouthAfrican(rs.getBoolean("is_south_african"));
					patient.setNationality(rs.getString("nationality"));
					patient.setForeignId(rs.getString("foreign_id"));
					patient.setIllnesses(rs.getString("illnesses"));
					patient.setIllnessNotes(rs.getString("illness_notes"));
					patient.setConsent(rs.getBoolean("consent"));
					return patient;
				}
			}
		}
		return null;
	}

	public Patient findById(Long id) throws SQLException {
		String sql = "SELECT id, first_name, surname, id_number, cell, gender, address, email, employment_status, job_title, " +
				"next_of_kin_name, next_of_kin_relation, emergency_contact, is_south_african, nationality, foreign_id, illnesses, illness_notes, consent " +
				"FROM patients WHERE id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Patient patient = new Patient();
					patient.setId(rs.getLong("id"));
					patient.setFirstName(rs.getString("first_name"));
					patient.setSurname(rs.getString("surname"));
					patient.setIdNumber(rs.getString("id_number"));
					patient.setCell(rs.getString("cell"));
					patient.setGender(rs.getString("gender"));
					patient.setAddress(rs.getString("address"));
					patient.setEmail(rs.getString("email"));
					patient.setEmploymentStatus(rs.getString("employment_status"));
					patient.setJobTitle(rs.getString("job_title"));
					patient.setNextOfKinName(rs.getString("next_of_kin_name"));
					patient.setNextOfKinRelation(rs.getString("next_of_kin_relation"));
					patient.setEmergencyContact(rs.getString("emergency_contact"));
					patient.setSouthAfrican(rs.getBoolean("is_south_african"));
					patient.setNationality(rs.getString("nationality"));
					patient.setForeignId(rs.getString("foreign_id"));
					patient.setIllnesses(rs.getString("illnesses"));
					patient.setIllnessNotes(rs.getString("illness_notes"));
					patient.setConsent(rs.getBoolean("consent"));
					return patient;
				}
			}
		}
		return null;
	}

	public Patient findByQuery(String query) throws SQLException {
		String sql = "SELECT id, first_name, surname, id_number, cell, gender, address, email, employment_status, job_title, " +
				"next_of_kin_name, next_of_kin_relation, emergency_contact, is_south_african, nationality, foreign_id, illnesses, illness_notes, consent " +
				"FROM patients WHERE id_number = ? OR first_name LIKE ? OR surname LIKE ? " +
				"ORDER BY CASE WHEN id_number = ? THEN 0 WHEN surname = ? THEN 1 WHEN first_name = ? THEN 2 ELSE 3 END, created_at DESC LIMIT 1";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			String likeQuery = "%" + query + "%";
			ps.setString(1, query);
			ps.setString(2, likeQuery);
			ps.setString(3, likeQuery);
			ps.setString(4, query);
			ps.setString(5, query);
			ps.setString(6, query);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Patient patient = new Patient();
					patient.setId(rs.getLong("id"));
					patient.setFirstName(rs.getString("first_name"));
					patient.setSurname(rs.getString("surname"));
					patient.setIdNumber(rs.getString("id_number"));
					patient.setCell(rs.getString("cell"));
					patient.setGender(rs.getString("gender"));
					patient.setAddress(rs.getString("address"));
					patient.setEmail(rs.getString("email"));
					patient.setEmploymentStatus(rs.getString("employment_status"));
					patient.setJobTitle(rs.getString("job_title"));
					patient.setNextOfKinName(rs.getString("next_of_kin_name"));
					patient.setNextOfKinRelation(rs.getString("next_of_kin_relation"));
					patient.setEmergencyContact(rs.getString("emergency_contact"));
					patient.setSouthAfrican(rs.getBoolean("is_south_african"));
					patient.setNationality(rs.getString("nationality"));
					patient.setForeignId(rs.getString("foreign_id"));
					patient.setIllnesses(rs.getString("illnesses"));
					patient.setIllnessNotes(rs.getString("illness_notes"));
					patient.setConsent(rs.getBoolean("consent"));
					return patient;
				}
			}
		}
		return null;
	}

	public List<Patient> findMatches(String query, int limit) throws SQLException {
		List<Patient> results = new ArrayList<>();
		String sql = "SELECT id, first_name, surname, id_number, cell, gender, address, email, employment_status, job_title, " +
				"next_of_kin_name, next_of_kin_relation, emergency_contact, is_south_african, nationality, foreign_id, illnesses, illness_notes, consent " +
				"FROM patients WHERE id_number LIKE ? OR first_name LIKE ? OR surname LIKE ? " +
				"ORDER BY CASE WHEN id_number = ? THEN 0 WHEN surname = ? THEN 1 WHEN first_name = ? THEN 2 ELSE 3 END, created_at DESC " +
				"LIMIT ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			String likeQuery = "%" + query + "%";
			ps.setString(1, likeQuery);
			ps.setString(2, likeQuery);
			ps.setString(3, likeQuery);
			ps.setString(4, query);
			ps.setString(5, query);
			ps.setString(6, query);
			ps.setInt(7, limit);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Patient patient = new Patient();
					patient.setId(rs.getLong("id"));
					patient.setFirstName(rs.getString("first_name"));
					patient.setSurname(rs.getString("surname"));
					patient.setIdNumber(rs.getString("id_number"));
					patient.setCell(rs.getString("cell"));
					patient.setGender(rs.getString("gender"));
					patient.setAddress(rs.getString("address"));
					patient.setEmail(rs.getString("email"));
					patient.setEmploymentStatus(rs.getString("employment_status"));
					patient.setJobTitle(rs.getString("job_title"));
					patient.setNextOfKinName(rs.getString("next_of_kin_name"));
					patient.setNextOfKinRelation(rs.getString("next_of_kin_relation"));
					patient.setEmergencyContact(rs.getString("emergency_contact"));
					patient.setSouthAfrican(rs.getBoolean("is_south_african"));
					patient.setNationality(rs.getString("nationality"));
					patient.setForeignId(rs.getString("foreign_id"));
					patient.setIllnesses(rs.getString("illnesses"));
					patient.setIllnessNotes(rs.getString("illness_notes"));
					patient.setConsent(rs.getBoolean("consent"));
					results.add(patient);
				}
			}
		}
		return results;
	}
}
