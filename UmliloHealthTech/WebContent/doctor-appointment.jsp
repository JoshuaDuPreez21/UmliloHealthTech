<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Doctor Sign Off</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
	:root {
		--ink: #0f172a;
		--brand: #1b7a6d;
		--surface: #ffffff;
		--muted: #667085;
	}
	body {
		background: #f4f7fb;
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	.panel {
		border: none;
		border-radius: 18px;
		box-shadow: 0 14px 35px rgba(20, 35, 60, 0.08);
	}
	.section-label {
		font-weight: 600;
	}
	.page-title {
		font-size: clamp(1.4rem, 1.1rem + 1.4vw, 2rem);
	}
	.form-control {
		border-radius: 12px;
	}
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
	}
	.btn-primary:hover {
		background: #0b2f30;
		border-color: #0b2f30;
	}
	.note-box {
		white-space: pre-wrap;
	}
	.loading-overlay {
		position: fixed;
		inset: 0;
		background: rgba(15, 23, 42, 0.55);
		display: flex;
		align-items: center;
		justify-content: center;
		opacity: 0;
		visibility: hidden;
		transition: opacity 0.2s ease, visibility 0.2s ease;
		z-index: 2000;
	}
	.loading-overlay.show {
		opacity: 1;
		visibility: visible;
	}
	.loading-card {
		background: rgba(255, 255, 255, 0.14);
		border: 1px solid rgba(255, 255, 255, 0.25);
		backdrop-filter: blur(8px);
		border-radius: 18px;
		padding: 1.5rem;
		width: min(70vw, 260px);
		text-align: center;
		color: #fff;
	}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top border-bottom bg-white">
		<div class="container py-2">
			<span class="fw-semibold">Umlilo HealthTech</span>
			<div class="d-flex align-items-center gap-3">
				<a href="doctor" class="btn btn-sm btn-outline-secondary">Back to Doctor Dashboard</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
			<div>
				<h1 class="page-title fw-bold mb-1">Doctor Sign Off</h1>
				<p class="text-muted mb-0">Review nurse notes, patient details, and previous prescriptions.</p>
			</div>
			<div class="badge bg-warning text-dark border" id="appointmentStatus">Status: -</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-4">
				<div class="card panel mb-4">
					<div class="card-body p-4">
						<h2 class="h5 section-label">Patient Personal Info</h2>
						<ul class="list-unstyled mb-0">
							<li><strong>Name:</strong> <span id="patientName">-</span></li>
							<li><strong>ID:</strong> <span id="patientIdNumber">-</span></li>
							<li><strong>Cell:</strong> <span id="patientCell">-</span></li>
							<li><strong>Gender:</strong> <span id="patientGender">-</span></li>
							<li><strong>Email:</strong> <span id="patientEmail">-</span></li>
							<li><strong>Address:</strong> <span id="patientAddress">-</span></li>
							<li><strong>Emergency:</strong> <span id="patientEmergency">-</span></li>
							<li><strong>Illnesses:</strong> <span id="patientIllnesses">-</span></li>
							<li><strong>Notes:</strong> <span id="patientNotes">-</span></li>
						</ul>
					</div>
				</div>

				<div class="card panel">
					<div class="card-body p-4">
						<h2 class="h5 section-label">Previous Prescriptions</h2>
						<div id="previousPrescriptions" class="text-muted">No previous prescriptions loaded.</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8">
				<div class="card panel mb-4">
					<div class="card-body p-4">
						<div class="d-flex flex-wrap justify-content-between gap-2 mb-3">
							<h2 class="h5 section-label mb-0">Current Appointment</h2>
							<span class="text-muted" id="appointmentTime">-</span>
						</div>
						<div class="row g-3">
							<div class="col-md-6">
								<div class="border rounded-3 p-3 h-100">
									<div class="small text-muted mb-1">Nurse</div>
									<div class="fw-semibold" id="nurseName">-</div>
									<div class="note-box mt-2" id="nurseNotes">No nurse notes recorded.</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="border rounded-3 p-3 h-100">
									<div class="small text-muted mb-1">Current Prescription</div>
									<div class="note-box" id="currentPrescription">No prescription recorded yet.</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="card panel">
					<div class="card-body p-4">
						<h2 class="h5 section-label mb-3">Doctor Notes</h2>
						<div class="row g-3">
							<div class="col-12">
								<label class="form-label">Doctor Note</label>
								<textarea class="form-control" rows="6" id="doctorSummary" placeholder="Assessment, diagnosis, and sign-off notes"></textarea>
							</div>
							<div class="col-12">
								<label class="form-label">Prescription</label>
								<textarea class="form-control" rows="4" id="prescription" placeholder="Medication, dose, frequency, and duration"></textarea>
							</div>
						</div>
						<div class="d-flex flex-wrap gap-2 mt-3">
							<button class="btn btn-primary" id="signOffBtn" type="button">Save Sign Off</button>
							<a href="doctor" class="btn btn-outline-secondary">Cancel</a>
						</div>
						<div id="signOffAlert" class="alert alert-info mt-3 d-none"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="loading-overlay" id="loadingOverlay">
		<div class="loading-card">
			<div class="spinner-border text-light" role="status"></div>
			<div class="mt-3 fw-semibold">Loading...</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	var currentAppointmentId = null;
	var loadingCount = 0;
	function showLoading() {
		loadingCount += 1;
		document.getElementById("loadingOverlay").classList.add("show");
	}
	function hideLoading() {
		loadingCount = Math.max(0, loadingCount - 1);
		if (loadingCount === 0) {
			document.getElementById("loadingOverlay").classList.remove("show");
		}
	}
	function text(value) {
		return value || "-";
	}
	function showAlert(message, type) {
		var alertEl = document.getElementById("signOffAlert");
		alertEl.className = "alert alert-" + type + " mt-3";
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}
	function renderPreviousPrescriptions(items) {
		var container = document.getElementById("previousPrescriptions");
		container.innerHTML = "";
		if (!items || items.length === 0) {
			container.textContent = "No previous prescriptions found.";
			container.classList.add("text-muted");
			return;
		}
		container.classList.remove("text-muted");
		items.forEach(function (item) {
			var row = document.createElement("div");
			row.className = "border rounded-3 p-3 mb-2";
			row.innerHTML =
				"<div class=\"fw-semibold\">" + text(item.dateTime) + "</div>" +
				"<div class=\"small text-muted mb-2\">Doctor: " + text(item.doctorName) + "</div>" +
				"<div class=\"note-box\">" + text(item.prescription) + "</div>";
			container.appendChild(row);
		});
	}
	function renderDetail(data) {
		var patient = data.patient || {};
		var appointment = data.appointment || {};
		currentAppointmentId = appointment.id;

		document.getElementById("patientName").textContent = text(patient.fullName);
		document.getElementById("patientIdNumber").textContent = text(patient.idNumber);
		document.getElementById("patientCell").textContent = text(patient.cell);
		document.getElementById("patientGender").textContent = text(patient.gender);
		document.getElementById("patientEmail").textContent = text(patient.email);
		document.getElementById("patientAddress").textContent = text(patient.address);
		document.getElementById("patientEmergency").textContent = text(patient.emergencyContact);
		document.getElementById("patientIllnesses").textContent = text(patient.illnesses);
		document.getElementById("patientNotes").textContent = text(patient.illnessNotes);

		document.getElementById("appointmentStatus").textContent = "Status: " + text(appointment.status);
		document.getElementById("appointmentTime").textContent = text(appointment.appointmentTime);
		document.getElementById("nurseName").textContent = text(appointment.nurseName);
		document.getElementById("nurseNotes").textContent = appointment.nurseNotes || "No nurse notes recorded.";
		document.getElementById("currentPrescription").textContent = appointment.prescription || "No prescription recorded yet.";
		document.getElementById("doctorSummary").value = appointment.doctorSummary || "";
		document.getElementById("prescription").value = appointment.prescription || "";
		renderPreviousPrescriptions(data.previousPrescriptions || []);
	}
	function loadAppointment() {
		var params = new URLSearchParams(window.location.search);
		var appointmentId = params.get("appointmentId");
		if (!appointmentId) {
			showAlert("Appointment ID is missing.", "warning");
			return;
		}
		showLoading();
		fetch("rest/appointments/doctor-detail?id=" + encodeURIComponent(appointmentId))
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					renderDetail(result.data);
				} else {
					var message = result.data && result.data.message ? result.data.message : "Unable to load appointment.";
					showAlert(message, "warning");
				}
			})
			.catch(function () {
				showAlert("Unable to reach server. Please try again.", "danger");
			})
			.finally(function () {
				hideLoading();
			});
	}
	document.getElementById("signOffBtn").addEventListener("click", function () {
		var doctorSummary = document.getElementById("doctorSummary").value.trim();
		var prescription = document.getElementById("prescription").value.trim();
		document.getElementById("doctorSummary").classList.remove("is-invalid");
		if (!doctorSummary) {
			document.getElementById("doctorSummary").classList.add("is-invalid");
			showAlert("Doctor note is required.", "warning");
			return;
		}
		showLoading();
		fetch("rest/appointments/signoff", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({
				appointmentId: Number(currentAppointmentId),
				doctorSummary: doctorSummary,
				prescription: prescription
			})
		})
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showAlert("Appointment signed off.", "success");
				document.getElementById("appointmentStatus").textContent = "Status: COMPLETED";
				setTimeout(function () {
					window.location.href = "doctor";
				}, 1500);
			} else {
				var message = result.data && result.data.message ? result.data.message : "Unable to sign off appointment.";
				showAlert(message, "warning");
			}
		})
		.catch(function () {
			showAlert("Unable to reach server. Please try again.", "danger");
		})
		.finally(function () {
			hideLoading();
		});
	});
	loadAppointment();
</script>
</body>
</html>
