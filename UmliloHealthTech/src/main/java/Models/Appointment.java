package Models;

import java.sql.Timestamp;

public class Appointment {
	private Long id;
	private Long patientId;
	private Timestamp appointmentTime;
	private String status;
	private String nurseName;
	private String doctorName;
	private String visitSummary;
	private String patientName;
	private String patientIdNumber;
	private String patientCell;
	private String nurseNotes;
	private String prescription;
	private String doctorSummary;
	private String additionalNotes;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getPatientId() {
		return patientId;
	}

	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}

	public Timestamp getAppointmentTime() {
		return appointmentTime;
	}

	public void setAppointmentTime(Timestamp appointmentTime) {
		this.appointmentTime = appointmentTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNurseName() {
		return nurseName;
	}

	public void setNurseName(String nurseName) {
		this.nurseName = nurseName;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public String getVisitSummary() {
		return visitSummary;
	}

	public void setVisitSummary(String visitSummary) {
		this.visitSummary = visitSummary;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public String getPatientIdNumber() {
		return patientIdNumber;
	}

	public void setPatientIdNumber(String patientIdNumber) {
		this.patientIdNumber = patientIdNumber;
	}

	public String getPatientCell() {
		return patientCell;
	}

	public void setPatientCell(String patientCell) {
		this.patientCell = patientCell;
	}

	public String getNurseNotes() {
		return nurseNotes;
	}

	public void setNurseNotes(String nurseNotes) {
		this.nurseNotes = nurseNotes;
	}

	public String getPrescription() {
		return prescription;
	}

	public void setPrescription(String prescription) {
		this.prescription = prescription;
	}

	public String getDoctorSummary() {
		return doctorSummary;
	}

	public void setDoctorSummary(String doctorSummary) {
		this.doctorSummary = doctorSummary;
	}

	public String getAdditionalNotes() {
		return additionalNotes;
	}

	public void setAdditionalNotes(String additionalNotes) {
		this.additionalNotes = additionalNotes;
	}
}
