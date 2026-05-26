<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Patient Search</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
	:root {
		--ink: #0f172a;
		--brand: #1b7a6d;
		--brand-soft: #e7f3f1;
		--accent: #f4b400;
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
	.timeline-item {
		border-left: 3px solid var(--brand);
		padding-left: 1rem;
		margin-bottom: 1rem;
	}
	.page-title {
		font-size: clamp(1.4rem, 1.1rem + 1.4vw, 2rem);
	}
	@media (max-width: 768px) {
		.panel .card-body {
			padding: 1.5rem;
		}
	}
	.form-control, .form-select {
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
	.loading-overlay {
		position: fixed;
		inset: 0;
		background: rgba(15, 23, 42, 0.55);
		display: none;
		align-items: center;
		justify-content: center;
		opacity: 0;
		visibility: hidden;
		transition: opacity 0.2s ease, visibility 0.2s ease;
		z-index: 9999;
	}
	.loading-overlay.show {
		display: flex;
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
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: #fff;
		box-shadow: 0 18px 35px rgba(15, 23, 42, 0.28);
	}
	.loading-logo {
		width: 230px;
		max-width: 100%;
		height: auto;
		margin: 0 auto 0.75rem;
		filter: drop-shadow(0 6px 12px rgba(15, 23, 42, 0.35));
	}
	.loading-text {
		margin-top: 0.6rem;
		font-weight: 700;
		font-size: 1.2rem;
		letter-spacing: 0.04em;
	}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top border-bottom bg-white">
		<div class="container py-2">
			<span class="fw-semibold">Umlilo HealthTech</span>
			<div class="d-flex align-items-center gap-3">
				<a href="home" class="btn btn-sm btn-outline-secondary">Back to Dashboard</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
			<div>
				<h1 class="page-title fw-bold mb-1">Search Patient</h1>
				<p class="text-muted mb-0">Find a patient, view results, and check appointment history.</p>
			</div>
		</div>

		<div class="card panel mb-4">
			<div class="card-body p-4">
				<h2 class="h5 section-label mb-3">Search Patient</h2>
				<div class="row g-3 align-items-end">
					<div class="col-md-6">
						<label class="form-label">Patient ID / Name / Surname</label>
						<input type="text" class="form-control" id="searchQuery" placeholder="Enter ID, name, or surname">
					</div>
					<div class="col-md-3">
						<label class="form-label">Search Option</label>
						<select class="form-select" id="searchFilter">
							<option value="all" selected>All records</option>
							<option value="open">Open appointments</option>
							<option value="completed">Completed visits</option>
						</select>
					</div>
					<div class="col-md-3">
						<button class="btn btn-primary w-100" id="searchBtn" type="button">Search</button>
					</div>
				</div>
				<div id="searchAlert" class="alert alert-warning mt-3 d-none"></div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-4">
				<div class="card panel mb-4">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Patient Result</h3>
						<ul class="list-unstyled mb-3" id="patientResultBox">
							<li><strong>Name:</strong> <span id="patientName">-</span></li>
							<li><strong>ID:</strong> <span id="patientIdNumber">-</span></li>
							<li><strong>Cell:</strong> <span id="patientCell">-</span></li>
							<li><strong>Next of Kin:</strong> <span id="patientNextOfKin">-</span></li>
						</ul>
						<div id="patientDetailsBox" class="border rounded-3 p-3 mb-3 d-none">
							<div class="small text-muted mb-2">Full Patient Details</div>
							<ul class="list-unstyled mb-0">
								<li><strong>Gender:</strong> <span id="patientGender">-</span></li>
								<li><strong>Email:</strong> <span id="patientEmail">-</span></li>
								<li><strong>Address:</strong> <span id="patientAddress">-</span></li>
								<li><strong>Employment:</strong> <span id="patientEmployment">-</span></li>
								<li><strong>Job Title:</strong> <span id="patientJobTitle">-</span></li>
								<li><strong>Kin Relation:</strong> <span id="patientKinRelation">-</span></li>
								<li><strong>Emergency:</strong> <span id="patientEmergency">-</span></li>
								<li><strong>Nationality:</strong> <span id="patientNationality">-</span></li>
								<li><strong>Foreign ID:</strong> <span id="patientForeignId">-</span></li>
								<li><strong>Illnesses:</strong> <span id="patientIllnesses">-</span></li>
								<li><strong>Notes:</strong> <span id="patientNotes">-</span></li>
							</ul>
						</div>
						<button class="btn btn-outline-secondary w-100" id="openPatientBtn" type="button" disabled>Open Patient Profile</button>
					</div>
				</div>

				<div class="card panel">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Appointment History</h3>
						<div id="appointmentHistoryBox" class="text-muted">No history loaded.</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8">
				<div class="card panel">
					<div class="card-body p-4">
						<h3 class="h5 section-label mb-3">Open Appointment</h3>
						<p class="text-muted mb-3">Shows only when the patient has an active appointment.</p>
						<div id="openAppointmentBox"></div>
						<div class="text-muted small mt-3">No open appointment? Create one from the Current Appointment page.</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="loading-overlay" id="loadingOverlay">
		<div class="loading-card">
			<img src="img/uht_bg.png" alt="Umlilo HealthTech logo" class="loading-logo">
			<div class="spinner-border text-light" role="status"></div>
			<div class="loading-text">Loading...</div>
		</div>
	</div>

	<div class="position-fixed top-0 end-0 p-3" id="toastContainer" style="z-index: 1080;"></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	var loadingCount = 0;
	var loadingStart = 0;
	var loadingMinMs = 500;
	function showLoading() {
		loadingCount += 1;
		if (loadingCount === 1) {
			loadingStart = Date.now();
		}
		document.getElementById("loadingOverlay").classList.add("show");
	}
	function hideLoading() {
		loadingCount = Math.max(0, loadingCount - 1);
		if (loadingCount === 0) {
			var elapsed = Date.now() - loadingStart;
			var remaining = Math.max(0, loadingMinMs - elapsed);
			setTimeout(function () {
				if (loadingCount === 0) {
					document.getElementById("loadingOverlay").classList.remove("show");
				}
			}, remaining);
		}
	}

	function showSearchAlert(message, type) {
		var alertEl = document.getElementById("searchAlert");
		alertEl.className = "alert alert-" + type + " mt-3";
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function clearSearchAlert() {
		var alertEl = document.getElementById("searchAlert");
		alertEl.classList.add("d-none");
	}

	function showToast(message) {
		var container = document.getElementById("toastContainer");
		if (!container) return;
		var toastEl = document.createElement("div");
		toastEl.className = "toast align-items-center text-bg-warning border-0";
		toastEl.setAttribute("role", "alert");
		toastEl.setAttribute("aria-live", "assertive");
		toastEl.setAttribute("aria-atomic", "true");
		toastEl.innerHTML =
			"<div class=\"d-flex\">" +
			"<div class=\"toast-body\">" + message + "</div>" +
			"<button type=\"button\" class=\"btn-close btn-close-white me-2 m-auto\" data-bs-dismiss=\"toast\"></button>" +
			"</div>";
		container.appendChild(toastEl);
		var toast = new bootstrap.Toast(toastEl, { delay: 4000 });
		toast.show();
		toastEl.addEventListener("hidden.bs.toast", function () {
			toastEl.remove();
		});
	}

	function renderPatient(patient) {
		document.getElementById("patientName").textContent = patient.fullName || "-";
		document.getElementById("patientIdNumber").textContent = patient.idNumber || "-";
		document.getElementById("patientCell").textContent = patient.cell || "-";
		document.getElementById("patientNextOfKin").textContent = patient.nextOfKinName || "-";
		document.getElementById("patientGender").textContent = patient.gender || "-";
		document.getElementById("patientEmail").textContent = patient.email || "-";
		document.getElementById("patientAddress").textContent = patient.address || "-";
		document.getElementById("patientEmployment").textContent = patient.employmentStatus || "-";
		document.getElementById("patientJobTitle").textContent = patient.jobTitle || "-";
		document.getElementById("patientKinRelation").textContent = patient.nextOfKinRelation || "-";
		document.getElementById("patientEmergency").textContent = patient.emergencyContact || "-";
		document.getElementById("patientNationality").textContent = patient.nationality || "-";
		document.getElementById("patientForeignId").textContent = patient.foreignId || "-";
		document.getElementById("patientIllnesses").textContent = patient.illnesses || "-";
		document.getElementById("patientNotes").textContent = patient.illnessNotes || "-";

		var openBtn = document.getElementById("openPatientBtn");
		if (patient.id) {
			openBtn.disabled = false;
			openBtn.textContent = "Show Patient Details";
			openBtn.onclick = function () {
				var detailsBox = document.getElementById("patientDetailsBox");
				if (!detailsBox) return;
				detailsBox.classList.toggle("d-none");
				openBtn.textContent = detailsBox.classList.contains("d-none") ? "Show Patient Details" : "Hide Patient Details";
			};
		} else {
			openBtn.disabled = true;
			openBtn.textContent = "Open Patient Profile";
		}
	}

	function clearPatientPanels() {
		renderPatient({
			fullName: "-",
			idNumber: "-",
			cell: "-",
			nextOfKinName: "-",
			gender: "-",
			email: "-",
			address: "-",
			employmentStatus: "-",
			jobTitle: "-",
			nextOfKinRelation: "-",
			emergencyContact: "-",
			nationality: "-",
			foreignId: "-",
			illnesses: "-",
			illnessNotes: "-"
		});
		var detailsBox = document.getElementById("patientDetailsBox");
		if (detailsBox) {
			detailsBox.classList.add("d-none");
		}
		var openBtn = document.getElementById("openPatientBtn");
		openBtn.disabled = true;
		openBtn.textContent = "Open Patient Profile";
	}

	function renderHistory(history) {
		var historyBox = document.getElementById("appointmentHistoryBox");
		historyBox.innerHTML = "";
		if (!history || history.length === 0) {
			historyBox.textContent = "No appointment history found.";
			historyBox.classList.add("text-muted");
			return;
		}
		historyBox.classList.remove("text-muted");
		history.forEach(function (item) {
			var wrapper = document.createElement("div");
			wrapper.className = "timeline-item";

			var summary = document.createElement("p");
			summary.className = "mb-1";
			summary.innerHTML = "<strong>" + item.date + "</strong> - " + (item.summary || "Visit recorded.");
			wrapper.appendChild(summary);

			var meta = document.createElement("small");
			meta.className = "text-muted";
			meta.textContent = "Nurse: " + (item.nurseName || "N/A") + " | Doctor: " + (item.doctorName || "N/A");
			wrapper.appendChild(meta);

			historyBox.appendChild(wrapper);
		});
	}

	function renderOpenAppointment(openAppointment) {
		var container = document.getElementById("openAppointmentBox");
		container.innerHTML = "";
		if (!openAppointment) {
			container.classList.remove("text-muted");
			return;
		}
		var wrapper = document.createElement("div");
		wrapper.className = "border rounded-3 p-3";
		wrapper.innerHTML =
			"<div class=\"d-flex flex-wrap justify-content-between align-items-center\">" +
			"<div>" +
			"<div class=\"fw-semibold\">" + openAppointment.date + "</div>" +
			"<div class=\"text-muted\">Status: " + openAppointment.status + "</div>" +
			"</div>" +
			"<a href=\"capture-appointment?appointmentId=" + openAppointment.id + "\" class=\"btn btn-outline-primary\">Open</a>" +
			"</div>";
		container.appendChild(wrapper);
	}

	document.getElementById("searchBtn").addEventListener("click", function () {
		clearSearchAlert();
		var query = document.getElementById("searchQuery").value.trim();
		var filter = document.getElementById("searchFilter").value;
		if (!query) {
			showSearchAlert("Please enter a patient ID, name, or surname to search.", "warning");
			return;
		}

		showLoading();
		fetch("rest/patients/search?query=" + encodeURIComponent(query) + "&filter=" + encodeURIComponent(filter))
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					renderPatient(result.data.patient);
					renderHistory(result.data.appointmentHistory);
					renderOpenAppointment(result.data.openAppointment);
				} else {
					var message = result.data && result.data.message ? result.data.message : "Patient not found.";
					showSearchAlert(message, "warning");
					showToast(message);
					clearPatientPanels();
					renderHistory([]);
					renderOpenAppointment(null);
				}
			})
			.catch(function () {
				showSearchAlert("Unable to reach server. Please try again.", "danger");
			})
			.finally(function () {
				hideLoading();
			});
	});
</script>
</body>
</html>
