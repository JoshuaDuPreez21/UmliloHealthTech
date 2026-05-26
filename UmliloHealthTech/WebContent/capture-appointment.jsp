<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Capture Appointment</title>
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
				<a href="current-appointment" class="btn btn-sm btn-outline-secondary">Back to Appointments</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
			<div>
				<h1 class="page-title fw-bold mb-1">Capture Appointment</h1>
				<p class="text-muted mb-0">Open the patient appointment and update nurse notes.</p>
			</div>
			<div class="badge bg-light text-dark border">Nurse: Thandi Mthembu</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-4">
				<div class="card panel h-100">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Patient Details</h3>
						<ul class="list-unstyled mb-3">
							<li><strong>Name:</strong> <span id="patientName">-</span></li>
							<li><strong>ID:</strong> <span id="patientIdNumber">-</span></li>
							<li><strong>Cell:</strong> <span id="patientCell">-</span></li>
							<li><strong>Appointment:</strong> <span id="appointmentTime">-</span></li>
						</ul>
						<div class="alert alert-info mb-0" id="appointmentStatus">Status: -</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8">
				<div class="card panel">
					<div class="card-body p-4">
						<h2 class="h5 section-label mb-3">Nurse Notes</h2>
						<div class="row g-3">
							<div class="col-12">
								<label class="form-label">Nurse Notes</label>
								<textarea class="form-control" rows="8" id="nurseNotes" placeholder="Record vitals, symptoms, observations, and intake notes"></textarea>
							</div>
						</div>
						<div class="d-flex flex-wrap gap-2 mt-3">
							<button class="btn btn-primary" id="saveAppointmentBtn" type="button">Update Appointment</button>
							<button class="btn btn-outline-primary" id="attachFilesBtn" type="button">Attach Files</button>
						</div>
						<input type="file" id="attachmentInput" class="d-none">
						<div id="attachmentList" class="mt-3"></div>
						<div id="captureAlert" class="alert alert-info mt-3 d-none"></div>
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

	function showCaptureAlert(message, type) {
		var alertEl = document.getElementById("captureAlert");
		alertEl.className = "alert alert-" + type + " mt-3";
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function clearValidation() {
		["nurseNotes"].forEach(function (id) {
			var el = document.getElementById(id);
			if (el) el.classList.remove("is-invalid");
		});
	}

	function markInvalid(id) {
		var el = document.getElementById(id);
		if (el) el.classList.add("is-invalid");
	}

	function loadAppointment() {
		var params = new URLSearchParams(window.location.search);
		var appointmentId = params.get("appointmentId");
		if (!appointmentId) {
			showCaptureAlert("Appointment ID is missing.", "warning");
			return;
		}

		showLoading();
		fetch("rest/appointments/detail?id=" + encodeURIComponent(appointmentId))
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					document.getElementById("patientName").textContent = result.data.patient.name || "-";
					document.getElementById("patientIdNumber").textContent = result.data.patient.idNumber || "-";
					document.getElementById("patientCell").textContent = result.data.patient.cell || "-";
					document.getElementById("appointmentTime").textContent = result.data.appointment.appointmentTime || "-";
					document.getElementById("appointmentStatus").textContent = "Status: " + (result.data.appointment.status || "-");
					document.getElementById("nurseNotes").value = result.data.appointment.nurseNotes || "";
				} else {
					var message = result.data && result.data.message ? result.data.message : "Unable to load appointment.";
					showCaptureAlert(message, "warning");
				}
			})
			.catch(function () {
				showCaptureAlert("Unable to reach server. Please try again.", "danger");
			})
			.finally(function () {
				hideLoading();
			});
	}

	function loadAttachments() {
		var params = new URLSearchParams(window.location.search);
		var appointmentId = params.get("appointmentId");
		if (!appointmentId) return;
		showLoading();
		fetch("rest/appointments/attachments?appointmentId=" + encodeURIComponent(appointmentId))
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				var listEl = document.getElementById("attachmentList");
				listEl.innerHTML = "";
				if (result.status === 200 && result.data.success && result.data.attachments.length > 0) {
					var header = document.createElement("div");
					header.className = "small text-muted mb-2";
					header.textContent = "Attachments";
					listEl.appendChild(header);
					result.data.attachments.forEach(function (att) {
						var row = document.createElement("div");
						row.className = "d-flex justify-content-between align-items-center border rounded-3 p-2 mb-2";
						var link = document.createElement("a");
						link.href = "uploads/" + encodeURIComponent(att.storedName);
						link.textContent = att.originalName;
						link.target = "_blank";
						link.rel = "noopener";
						var size = document.createElement("span");
						size.className = "small text-muted";
						size.textContent = att.fileSize ? Math.round(att.fileSize / 1024) + " KB" : "";
						row.appendChild(link);
						row.appendChild(size);
						listEl.appendChild(row);
					});
				}
			})
			.catch(function () {
				// no-op
			})
			.finally(function () {
				hideLoading();
			});
	}

	document.getElementById("attachFilesBtn").addEventListener("click", function () {
		document.getElementById("attachmentInput").click();
	});

	document.getElementById("attachmentInput").addEventListener("change", function () {
		var fileInput = document.getElementById("attachmentInput");
		if (!fileInput.files || fileInput.files.length === 0) return;
		var params = new URLSearchParams(window.location.search);
		var appointmentId = params.get("appointmentId");
		if (!appointmentId) {
			showCaptureAlert("Appointment ID is missing.", "warning");
			return;
		}
		var formData = new FormData();
		formData.append("appointmentId", appointmentId);
		formData.append("file", fileInput.files[0]);

		showLoading();
		fetch("rest/appointments/upload", {
			method: "POST",
			body: formData
		})
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showCaptureAlert("Attachment uploaded.", "success");
				fileInput.value = "";
				loadAttachments();
			} else {
				var message = result.data && result.data.message ? result.data.message : "Unable to upload attachment.";
				showCaptureAlert(message, "warning");
			}
		})
		.catch(function () {
			showCaptureAlert("Unable to reach server. Please try again.", "danger");
		})
		.finally(function () {
			hideLoading();
		});
	});

	document.getElementById("saveAppointmentBtn").addEventListener("click", function () {
		clearValidation();
		var params = new URLSearchParams(window.location.search);
		var appointmentId = params.get("appointmentId");
		var nurseNotes = document.getElementById("nurseNotes").value.trim();

		var missing = false;
		if (!nurseNotes) { markInvalid("nurseNotes"); missing = true; }

		if (missing) {
			showCaptureAlert("Nurse notes are required.", "warning");
			return;
		}

		showLoading();
		fetch("rest/appointments/nurse-notes", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({
				appointmentId: Number(appointmentId),
				nurseNotes: nurseNotes
			})
		})
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showCaptureAlert("Appointment updated. Pending doctor sign-off.", "success");
				document.getElementById("appointmentStatus").textContent = "Status: PENDING_DOCTOR";
				setTimeout(function () {
					window.location.href = "current-appointment";
				}, 2500);
			} else {
				var message = result.data && result.data.message ? result.data.message : "Unable to capture appointment.";
				showCaptureAlert(message, "warning");
			}
		})
		.catch(function () {
			showCaptureAlert("Unable to reach server. Please try again.", "danger");
		})
		.finally(function () {
			hideLoading();
		});
	});

	loadAppointment();
	loadAttachments();
</script>
</body>
</html>
