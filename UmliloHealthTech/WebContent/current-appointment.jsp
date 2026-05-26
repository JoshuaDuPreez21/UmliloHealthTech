<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Current Appointment</title>
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
	.status-select {
		width: 120px;
		min-width: 120px;
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
				<a href="home" class="btn btn-sm btn-outline-secondary">Back to Dashboard</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
			<div>
				<h1 class="page-title fw-bold mb-1">Current Appointment</h1>
				<p class="text-muted mb-0">Create an appointment and review open appointments.</p>
			</div>
			<div class="badge bg-light text-dark border">Nurse View</div>
		</div>

		<div class="card panel mb-4">
			<div class="card-body p-4">
				<h2 class="h5 section-label mb-3">Create Appointment</h2>
				<div class="row g-3">
					<div class="col-md-5">
						<label class="form-label">Assign Patient (ID / Name / Surname)</label>
						<div class="position-relative">
							<div class="input-group">
							<input type="text" class="form-control" id="appointmentPatientId" placeholder="Enter ID, name, or surname">
							<button class="btn btn-outline-secondary" id="findPatientBtn" type="button">Find</button>
							</div>
							<div id="patientSearchResults" class="list-group position-absolute w-100 shadow-sm d-none" style="z-index: 1050;"></div>
						</div>
					</div>
					<div class="col-md-4">
						<label class="form-label">Patient Name</label>
						<input type="text" class="form-control" id="appointmentPatientName" placeholder="Patient name" readonly>
					</div>
					<div class="col-md-3">
						<label class="form-label">Confirmed ID</label>
						<input type="text" class="form-control" id="appointmentPatientIdConfirm" placeholder="ID" readonly>
					</div>
					<div class="col-md-3">
						<label class="form-label">Appointment Date</label>
						<input type="date" class="form-control" id="appointmentDate">
					</div>
					<div class="col-md-2">
						<label class="form-label">Time</label>
						<input type="time" class="form-control" id="appointmentTime">
					</div>
					<div class="col-md-2 d-flex align-items-end">
						<button class="btn btn-primary w-100" id="createAppointmentBtn" type="button">Create</button>
					</div>
					<div class="col-12">
						<label class="form-label">Appointment Notes</label>
						<textarea class="form-control" rows="2" id="appointmentNotes" placeholder="Reason for visit, quick notes"></textarea>
					</div>
					<div class="col-12">
						<div id="appointmentAlert" class="alert alert-info d-none"></div>
					</div>
				</div>
			</div>
		</div>

		<div class="card panel mb-4">
			<div class="card-body p-4">
				<h2 class="h5 section-label mb-3">Today's Appointments</h2>
				<div class="table-responsive">
					<table class="table align-middle mb-0">
						<thead>
							<tr>
								<th>Patient</th>
								<th>Date</th>
								<th>Status</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="appointmentsTableBody"></tbody>
					</table>
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

	function showAppointmentAlert(message, type) {
		var alertEl = document.getElementById("appointmentAlert");
		alertEl.className = "alert alert-" + type;
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function clearAppointmentAlert() {
		var alertEl = document.getElementById("appointmentAlert");
		alertEl.classList.add("d-none");
	}

	function clearPatientSelection() {
		document.getElementById("appointmentPatientName").value = "";
		document.getElementById("appointmentPatientIdConfirm").value = "";
	}

	function renderPatientSearchResults(patients) {
		var resultsBox = document.getElementById("patientSearchResults");
		resultsBox.innerHTML = "";
		if (!patients || patients.length === 0) {
			resultsBox.classList.add("d-none");
			return;
		}
		patients.forEach(function (patient) {
			var item = document.createElement("button");
			item.type = "button";
			item.className = "list-group-item list-group-item-action";
			item.innerHTML =
				"<div class=\"fw-semibold\">" + patient.fullName + "</div>" +
				"<div class=\"small text-muted\">" + (patient.idNumber || "-") + " • " + (patient.cell || "-") + "</div>";
			item.addEventListener("click", function () {
				document.getElementById("appointmentPatientId").value = patient.idNumber || "";
				document.getElementById("appointmentPatientName").value = patient.fullName || "";
				document.getElementById("appointmentPatientIdConfirm").value = patient.idNumber || "";
				resultsBox.classList.add("d-none");
			});
			resultsBox.appendChild(item);
		});
		resultsBox.classList.remove("d-none");
	}

	function fetchPatientMatches(query) {
		showLoading();
		fetch("rest/patients/search-list?query=" + encodeURIComponent(query))
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					renderPatientSearchResults(result.data.patients);
				} else {
					renderPatientSearchResults([]);
				}
			})
			.catch(function () {
				renderPatientSearchResults([]);
			})
			.finally(function () {
				hideLoading();
			});
	}

	function statusBadge(status) {
		var normalized = (status || "").toUpperCase();
		var label = normalized.replace("_", " ");
		var badgeClass = "bg-secondary";
		if (normalized === "NEW") badgeClass = "bg-secondary";
		if (normalized === "PENDING") badgeClass = "bg-warning text-dark";
		if (normalized === "WAITING") badgeClass = "bg-info text-dark";
		if (normalized === "IN_PROGRESS") badgeClass = "bg-primary";
		if (normalized === "PENDING_DOCTOR") badgeClass = "bg-warning text-dark";
		if (normalized === "COMPLETED") badgeClass = "bg-success";
		if (normalized === "PENDING_DOCTOR") label = "Pending Doctor";
		return "<span class=\"badge " + badgeClass + "\">" + label + "</span>";
	}

	function renderAppointments(rows) {
		var body = document.getElementById("appointmentsTableBody");
		body.innerHTML = "";
		if (!rows || rows.length === 0) {
			var emptyRow = document.createElement("tr");
			emptyRow.innerHTML = "<td colspan=\"4\" class=\"text-muted\">No appointments for today.</td>";
			body.appendChild(emptyRow);
			return;
		}

		rows.forEach(function (item) {
			var tr = document.createElement("tr");
			var status = (item.status || "NEW").toUpperCase();
			var statusSelect = "";
			if (status !== "COMPLETED" && status !== "PENDING_DOCTOR") {
				statusSelect =
					"<select class=\"form-select form-select-sm status-select\" data-appointment-status>" +
					"<option value=\"NEW\"" + (status === "NEW" ? " selected" : "") + ">New</option>" +
					"<option value=\"PENDING\"" + (status === "PENDING" ? " selected" : "") + ">Pending</option>" +
					"<option value=\"WAITING\"" + (status === "WAITING" ? " selected" : "") + ">Waiting</option>" +
					"<option value=\"IN_PROGRESS\"" + (status === "IN_PROGRESS" ? " selected" : "") + ">In Progress</option>" +
					"</select>";
			} else {
				statusSelect = "";
			}

			var actionCell = "";
			if (status !== "COMPLETED") {
				var updateStatusButton = statusSelect ? "<button class=\"btn btn-sm btn-outline-secondary\" data-update-status>Update</button>" : "";
				actionCell =
					"<div class=\"d-flex gap-2 justify-content-end align-items-center\">" +
					"<a href=\"capture-appointment?appointmentId=" + item.id + "\" class=\"btn btn-sm btn-outline-primary\">Open</a>" +
					statusSelect +
					updateStatusButton +
					"</div>";
			}

			tr.innerHTML =
				"<td>" + item.patientName + "<div class=\"small text-muted\">" + item.patientIdNumber + "</div></td>" +
				"<td>" + item.dateTime + "</td>" +
				"<td>" + statusBadge(status) + "</td>" +
				"<td class=\"text-end\">" + actionCell + "</td>";

			var updateBtn = tr.querySelector("[data-update-status]");
			if (updateBtn) {
				updateBtn.addEventListener("click", function () {
					var select = tr.querySelector("[data-appointment-status]");
					if (!select) return;
					updateAppointmentStatus(item.id, select.value);
				});
			}

			body.appendChild(tr);
		});
	}

	function fetchAppointments() {
		showLoading();
		fetch("rest/appointments/today")
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					renderAppointments(result.data.appointments);
				} else {
					renderAppointments([]);
				}
			})
			.catch(function () {
				renderAppointments([]);
			})
			.finally(function () {
				hideLoading();
			});
	}

	function updateAppointmentStatus(appointmentId, status) {
		showLoading();
		fetch("rest/appointments/status", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ appointmentId: appointmentId, status: status })
		})
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showAppointmentAlert("Status updated.", "success");
				fetchAppointments();
			} else {
				var message = result.data && result.data.message ? result.data.message : "Unable to update status.";
				showAppointmentAlert(message, "warning");
			}
		})
		.catch(function () {
			showAppointmentAlert("Unable to reach server. Please try again.", "danger");
		})
		.finally(function () {
			hideLoading();
		});
	}

	document.getElementById("createAppointmentBtn").addEventListener("click", function () {
		clearAppointmentAlert();
		var idNumber = document.getElementById("appointmentPatientId").value.trim();
		var dateValue = document.getElementById("appointmentDate").value;
		var timeValue = document.getElementById("appointmentTime").value;
		var notes = document.getElementById("appointmentNotes").value.trim();

		if (!idNumber || !dateValue || !timeValue) {
			showAppointmentAlert("Patient ID, date, and time are required.", "warning");
			return;
		}

		showLoading();
		fetch("rest/appointments/create", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ idNumber: idNumber, date: dateValue, time: timeValue, notes: notes })
		})
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showAppointmentAlert("Appointment created. Status set to New.", "success");
				document.getElementById("appointmentPatientId").value = "";
				document.getElementById("appointmentDate").value = "";
				document.getElementById("appointmentTime").value = "";
				document.getElementById("appointmentNotes").value = "";
				clearPatientSelection();
				fetchAppointments();
			} else {
				var message = result.data && result.data.message ? result.data.message : "Unable to create appointment.";
				showAppointmentAlert(message, "warning");
			}
		})
		.catch(function () {
			showAppointmentAlert("Unable to reach server. Please try again.", "danger");
		})
		.finally(function () {
			hideLoading();
		});
	});

	document.getElementById("findPatientBtn").addEventListener("click", function () {
		var query = document.getElementById("appointmentPatientId").value.trim();
		if (!query) {
			showAppointmentAlert("Enter a patient ID, name, or surname to find.", "warning");
			return;
		}
		showLoading();
		fetch("rest/patients/search-list?query=" + encodeURIComponent(query))
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					var matches = result.data.patients || [];
					if (matches.length === 1) {
						showAppointmentAlert("Patient found: " + matches[0].fullName, "success");
						document.getElementById("appointmentPatientName").value = matches[0].fullName || "";
						document.getElementById("appointmentPatientIdConfirm").value = matches[0].idNumber || "";
						if (matches[0].idNumber) {
							document.getElementById("appointmentPatientId").value = matches[0].idNumber;
						}
						document.getElementById("patientSearchResults").classList.add("d-none");
					} else if (matches.length > 1) {
						showAppointmentAlert("Multiple matches found. Please select the correct patient.", "warning");
						renderPatientSearchResults(matches);
					} else {
						showAppointmentAlert("Patient not found.", "warning");
						clearPatientSelection();
						renderPatientSearchResults([]);
					}
				} else {
					var message = result.data && result.data.message ? result.data.message : "Patient not found.";
					showAppointmentAlert(message, "warning");
					clearPatientSelection();
					renderPatientSearchResults([]);
				}
			})
			.catch(function () {
				showAppointmentAlert("Unable to reach server. Please try again.", "danger");
			})
			.finally(function () {
				hideLoading();
			});
	});

	var searchInput = document.getElementById("appointmentPatientId");
	var searchTimer = null;
	searchInput.addEventListener("input", function () {
		clearPatientSelection();
		var query = searchInput.value.trim();
		if (searchTimer) {
			clearTimeout(searchTimer);
		}
		if (query.length < 2) {
			renderPatientSearchResults([]);
			return;
		}
		searchTimer = setTimeout(function () {
			fetchPatientMatches(query);
		}, 250);
	});

	document.addEventListener("click", function (event) {
		var resultsBox = document.getElementById("patientSearchResults");
		if (!resultsBox.contains(event.target) && event.target !== searchInput) {
			resultsBox.classList.add("d-none");
		}
	});

	fetchAppointments();
</script>
</body>
</html>
