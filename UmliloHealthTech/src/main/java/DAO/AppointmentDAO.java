package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import Models.Appointment;
import Utils.DBUtil;

public class AppointmentDAO {
	public boolean createAppointment(Appointment appointment) throws SQLException {
		String sql = "INSERT INTO appointments (patient_id, appointment_time, status, nurse_name, doctor_name, visit_summary) " +
				"VALUES (?,?,?,?,?,?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setLong(1, appointment.getPatientId());
			ps.setTimestamp(2, appointment.getAppointmentTime());
			ps.setString(3, appointment.getStatus());
			ps.setString(4, appointment.getNurseName());
			ps.setString(5, appointment.getDoctorName());
			ps.setString(6, appointment.getVisitSummary());
			int affected = ps.executeUpdate();
			if (affected == 0) {
				return false;
			}
			try (ResultSet keys = ps.getGeneratedKeys()) {
				if (keys.next()) {
					appointment.setId(keys.getLong(1));
				}
			}
			return true;
		}
	}

	public boolean updateAppointmentStatus(Long appointmentId, String status) throws SQLException {
		String sql = "UPDATE appointments SET status = ? WHERE id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setLong(2, appointmentId);
			return ps.executeUpdate() > 0;
		}
	}

	public Appointment findAppointmentWithPatient(Long appointmentId) throws SQLException {
		String sql = "SELECT a.id, a.patient_id, a.appointment_time, a.status, a.nurse_name, a.doctor_name, a.visit_summary, " +
				"a.nurse_notes, a.prescription, a.doctor_summary, a.additional_notes, " +
				"p.first_name, p.surname, p.id_number, p.cell " +
				"FROM appointments a " +
				"JOIN patients p ON p.id = a.patient_id " +
				"WHERE a.id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, appointmentId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Appointment appointment = new Appointment();
					appointment.setId(rs.getLong("id"));
					appointment.setPatientId(rs.getLong("patient_id"));
					appointment.setAppointmentTime(rs.getTimestamp("appointment_time"));
					appointment.setStatus(rs.getString("status"));
					appointment.setNurseName(rs.getString("nurse_name"));
					appointment.setDoctorName(rs.getString("doctor_name"));
					appointment.setVisitSummary(rs.getString("visit_summary"));
					appointment.setNurseNotes(rs.getString("nurse_notes"));
					appointment.setPrescription(rs.getString("prescription"));
					appointment.setDoctorSummary(rs.getString("doctor_summary"));
					appointment.setAdditionalNotes(rs.getString("additional_notes"));
					appointment.setPatientName(rs.getString("first_name") + " " + rs.getString("surname"));
					appointment.setPatientIdNumber(rs.getString("id_number"));
					appointment.setPatientCell(rs.getString("cell"));
					return appointment;
				}
			}
		}
		return null;
	}

	public boolean captureAppointment(Long appointmentId, String nurseNotes, String prescription,
			String doctorSummary, String additionalNotes) throws SQLException {
		String sql = "UPDATE appointments SET nurse_notes = ?, prescription = ?, doctor_summary = ?, additional_notes = ?, " +
				"visit_summary = ?, status = ? WHERE id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, nurseNotes);
			ps.setString(2, prescription);
			ps.setString(3, doctorSummary);
			ps.setString(4, additionalNotes);
			ps.setString(5, doctorSummary);
			ps.setString(6, "PENDING_DOCTOR");
			ps.setLong(7, appointmentId);
			return ps.executeUpdate() > 0;
		}
	}

	public List<Appointment> findAppointmentsForNurseOnDate(String nurseName, Date date) throws SQLException {
		List<Appointment> results = new ArrayList<>();
		String sql = "SELECT a.id, a.patient_id, a.appointment_time, a.status, a.nurse_name, a.doctor_name, a.visit_summary, " +
				"p.first_name, p.surname, p.id_number " +
				"FROM appointments a " +
				"JOIN patients p ON p.id = a.patient_id " +
				"WHERE a.nurse_name = ? AND DATE(a.appointment_time) = ? " +
				"ORDER BY a.appointment_time ASC";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, nurseName);
			ps.setDate(2, date);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Appointment appointment = new Appointment();
					appointment.setId(rs.getLong("id"));
					appointment.setPatientId(rs.getLong("patient_id"));
					appointment.setAppointmentTime(rs.getTimestamp("appointment_time"));
					appointment.setStatus(rs.getString("status"));
					appointment.setNurseName(rs.getString("nurse_name"));
					appointment.setDoctorName(rs.getString("doctor_name"));
					appointment.setVisitSummary(rs.getString("visit_summary"));
					appointment.setPatientName(rs.getString("first_name") + " " + rs.getString("surname"));
					appointment.setPatientIdNumber(rs.getString("id_number"));
					results.add(appointment);
				}
			}
		}
		return results;
	}

	public List<Appointment> findAppointmentsByPatient(Long patientId, String filter) throws SQLException {
		List<Appointment> results = new ArrayList<>();
		StringBuilder sql = new StringBuilder(
			"SELECT id, patient_id, appointment_time, status, nurse_name, doctor_name, visit_summary " +
			"FROM appointments WHERE patient_id = ? "
		);

		if ("open".equalsIgnoreCase(filter)) {
			sql.append("AND status IN ('OPEN','IN_PROGRESS') ");
		} else if ("completed".equalsIgnoreCase(filter)) {
			sql.append("AND status = 'COMPLETED' ");
		}

		sql.append("ORDER BY appointment_time DESC");

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			ps.setLong(1, patientId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Appointment appointment = new Appointment();
					appointment.setId(rs.getLong("id"));
					appointment.setPatientId(rs.getLong("patient_id"));
					appointment.setAppointmentTime(rs.getTimestamp("appointment_time"));
					appointment.setStatus(rs.getString("status"));
					appointment.setNurseName(rs.getString("nurse_name"));
					appointment.setDoctorName(rs.getString("doctor_name"));
					appointment.setVisitSummary(rs.getString("visit_summary"));
					results.add(appointment);
				}
			}
		}
		return results;
	}

	public Appointment findOpenAppointmentByPatient(Long patientId) throws SQLException {
		String sql = "SELECT id, patient_id, appointment_time, status, nurse_name, doctor_name, visit_summary " +
				"FROM appointments WHERE patient_id = ? AND status IN ('OPEN','IN_PROGRESS') " +
				"ORDER BY appointment_time DESC LIMIT 1";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, patientId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Appointment appointment = new Appointment();
					appointment.setId(rs.getLong("id"));
					appointment.setPatientId(rs.getLong("patient_id"));
					appointment.setAppointmentTime(rs.getTimestamp("appointment_time"));
					appointment.setStatus(rs.getString("status"));
					appointment.setNurseName(rs.getString("nurse_name"));
					appointment.setDoctorName(rs.getString("doctor_name"));
					appointment.setVisitSummary(rs.getString("visit_summary"));
					return appointment;
				}
			}
		}
		return null;
	}
}
