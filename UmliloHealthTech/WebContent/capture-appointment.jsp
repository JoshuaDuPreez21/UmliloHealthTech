<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Nurse Workspace</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
	:root {
		--ink: #061427;
		--muted: #64748b;
		--line: #d9e5ec;
		--page: #f6f8fb;
		--panel: #ffffff;
		--brand: #0879ad;
		--brand-soft: #dff0fa;
		--teal: #10bfa6;
		--orange: #f59e0b;
		--sidebar: #0d1b27;
		--sidebar-soft: #172a3d;
	}
	* { box-sizing: border-box; }
	body {
		margin: 0;
		background: var(--page);
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	.app-shell {
		min-height: 100vh;
		padding-right: 326px;
		transition: padding-right 0.2s ease;
	}
	body.sidebar-collapsed .app-shell { padding-right: 92px; }
	.topbar {
		height: 116px;
		background: #fff;
		border-bottom: 1px solid var(--line);
		display: flex;
		align-items: center;
		justify-content: flex-end;
		padding: 0 2.2rem;
	}
	.notification {
		width: 42px;
		height: 42px;
		border: 0;
		border-radius: 50%;
		background: #f2f6fa;
		color: #52677d;
		position: relative;
		display: inline-flex;
		align-items: center;
		justify-content: center;
	}
	.notification-count {
		position: absolute;
		top: -5px;
		right: -2px;
		background: var(--orange);
		color: #fff;
		border-radius: 50%;
		min-width: 21px;
		height: 21px;
		font-size: 0.74rem;
		font-weight: 800;
		display: inline-flex;
		align-items: center;
		justify-content: center;
	}
	.main-content {
		padding: 2.7rem 2.4rem 3rem;
		max-width: 1120px;
	}
	.page-title {
		font-size: clamp(1.65rem, 1.35rem + 1vw, 2rem);
		font-weight: 800;
		margin: 0 0 0.35rem;
	}
	.page-subtitle {
		color: var(--muted);
		font-weight: 600;
		margin: 0;
	}
	.segmented-tabs {
		display: inline-flex;
		align-items: center;
		gap: 0.15rem;
		background: #e9eef2;
		border-radius: 10px;
		padding: 0.25rem;
		margin: 2rem 0;
	}
	.workspace-tab {
		border: 0;
		background: transparent;
		color: #52677d;
		border-radius: 8px;
		min-height: 36px;
		padding: 0 1rem;
		font-weight: 700;
		display: inline-flex;
		align-items: center;
		gap: 0.55rem;
		white-space: nowrap;
	}
	.workspace-tab.active {
		background: #fff;
		color: #020617;
		box-shadow: 0 1px 4px rgba(15, 35, 55, 0.18);
	}
	.workspace-panel,
	.capture-panel {
		background: var(--panel);
		border: 1px solid var(--line);
		border-radius: 14px;
		box-shadow: 0 2px 7px rgba(15, 35, 55, 0.14);
		padding: 1.9rem;
	}
	.workspace-panel h2,
	.capture-panel h2 {
		font-size: 1.08rem;
		font-weight: 800;
		margin: 0 0 1.8rem;
	}
	.form-label {
		font-weight: 800;
		color: #020617;
		margin-bottom: 0.6rem;
	}
	.form-control,
	.form-select {
		border: 1px solid var(--line);
		border-radius: 9px;
		min-height: 45px;
		box-shadow: 0 2px 7px rgba(15, 35, 55, 0.05);
		font-weight: 600;
	}
	.form-control::placeholder { color: #6b7f94; }
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
		font-weight: 800;
		border-radius: 8px;
		min-height: 44px;
		padding-left: 1rem;
		padding-right: 1rem;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		gap: 0.5rem;
	}
	.btn-primary:hover {
		background: #075f88;
		border-color: #075f88;
	}
	.btn-primary:disabled {
		background: #83b9d4;
		border-color: #83b9d4;
	}
	.btn-outline-primary {
		color: var(--brand);
		border-color: var(--brand);
		font-weight: 800;
		border-radius: 8px;
		min-height: 44px;
	}
	.register-copy {
		color: #52677d;
		font-weight: 600;
		margin-bottom: 1.35rem;
	}
	.lookup-row {
		display: grid;
		grid-template-columns: minmax(0, 1fr) 132px;
		gap: 0.65rem;
	}
	.search-input-wrap {
		position: relative;
	}
	.search-input-wrap i {
		position: absolute;
		left: 1rem;
		top: 50%;
		transform: translateY(-50%);
		color: #60758b;
		font-size: 1.1rem;
	}
	.search-input-wrap .form-control {
		padding-left: 2.85rem;
	}
	.patient-results {
		display: grid;
		gap: 0.75rem;
		margin-top: 1rem;
	}
	.empty-state {
		background: #fff;
		border: 1px dashed var(--line);
		border-radius: 8px;
		color: var(--muted);
		padding: 1rem;
		font-weight: 700;
	}
	.patient-result {
		border: 1px solid var(--line);
		border-radius: 8px;
		padding: 0.85rem 1rem;
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 1rem;
	}
	.result-title {
		font-weight: 800;
	}
	.result-meta {
		color: var(--muted);
		font-size: 0.85rem;
		font-weight: 600;
	}
	.book-grid {
		display: grid;
		grid-template-columns: repeat(2, minmax(0, 1fr));
		gap: 1.25rem 1.2rem;
	}
	.book-grid .full-width {
		grid-column: 1 / -1;
	}
	.form-actions {
		display: flex;
		justify-content: flex-end;
		margin-top: 1.55rem;
	}
	.patient-chip {
		display: none;
		align-items: center;
		gap: 0.5rem;
		margin-top: 0.75rem;
		border: 1px solid #b7ddeb;
		background: #eef8fc;
		color: #075f88;
		border-radius: 8px;
		padding: 0.55rem 0.75rem;
		font-size: 0.86rem;
		font-weight: 800;
	}
	.patient-chip.show { display: inline-flex; }
	.hidden { display: none !important; }
	.sidebar {
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		width: 326px;
		background: var(--sidebar);
		color: #d7e4ee;
		z-index: 1000;
		display: flex;
		flex-direction: column;
		transition: width 0.2s ease;
	}
	body.sidebar-collapsed .sidebar { width: 92px; }
	.sidebar-toggle {
		position: absolute;
		left: -17px;
		top: 146px;
		width: 34px;
		height: 34px;
		border: 1px solid var(--line);
		border-radius: 50%;
		background: #fff;
		color: #102033;
		box-shadow: 0 8px 18px rgba(15, 35, 55, 0.16);
		display: inline-flex;
		align-items: center;
		justify-content: center;
	}
	.brand-block {
		height: 136px;
		display: flex;
		align-items: center;
		gap: 0.95rem;
		padding: 1.45rem 1.5rem;
		border-bottom: 1px solid rgba(255, 255, 255, 0.08);
	}
	.brand-mark {
		width: 46px;
		height: 46px;
		border-radius: 14px;
		background: #0879ad;
		overflow: hidden;
		flex: 0 0 auto;
	}
	.brand-mark img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	.brand-title {
		font-weight: 800;
		font-size: 1.18rem;
		line-height: 1.1;
		color: #fff;
		white-space: nowrap;
	}
	.brand-subtitle {
		color: #95a8b8;
		font-size: 0.78rem;
		margin-top: 0.15rem;
	}
	.nav-menu {
		padding: 1.35rem 1.1rem;
		overflow-y: auto;
		flex: 1 1 auto;
	}
	.nav-item-link {
		display: flex;
		align-items: center;
		gap: 1rem;
		min-height: 50px;
		border-radius: 12px;
		color: #98a9b6;
		text-decoration: none;
		padding: 0 1rem;
		font-weight: 800;
		margin-bottom: 0.55rem;
	}
	.nav-item-link:hover,
	.nav-item-link.active {
		background: var(--sidebar-soft);
		color: #16d6bd;
	}
	.nav-item-link i {
		font-size: 1.25rem;
		width: 24px;
		text-align: center;
		flex: 0 0 auto;
	}
	.sidebar-footer {
		padding: 1rem 1.1rem 1.35rem;
		border-top: 1px solid rgba(255, 255, 255, 0.06);
	}
	.role-switch {
		background: #142536;
		border-radius: 12px;
		padding: 0.35rem;
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 0.35rem;
		margin-bottom: 0.85rem;
	}
	.role-switch a {
		border-radius: 9px;
		text-align: center;
		padding: 0.55rem 0.35rem;
		color: #99aab8;
		text-decoration: none;
		font-weight: 800;
		font-size: 0.86rem;
	}
	.role-switch a.active {
		background: var(--teal);
		color: #fff;
	}
	.sign-out {
		color: #99aab8;
		text-decoration: none;
		font-weight: 800;
		display: flex;
		align-items: center;
		gap: 0.8rem;
		padding: 0.7rem 1rem;
		border-radius: 12px;
	}
	.sign-out:hover {
		background: var(--sidebar-soft);
		color: #fff;
	}
	body.sidebar-collapsed .brand-copy,
	body.sidebar-collapsed .nav-label,
	body.sidebar-collapsed .role-switch,
	body.sidebar-collapsed .sign-out span {
		display: none;
	}
	body.sidebar-collapsed .brand-block,
	body.sidebar-collapsed .nav-item-link,
	body.sidebar-collapsed .sign-out {
		justify-content: center;
		padding-left: 0;
		padding-right: 0;
	}
	body.sidebar-collapsed .nav-menu,
	body.sidebar-collapsed .sidebar-footer {
		padding-left: 0.85rem;
		padding-right: 0.85rem;
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
		box-shadow: 0 18px 35px rgba(15, 23, 42, 0.28);
	}
	.loading-logo {
		width: 180px;
		max-width: 100%;
		height: auto;
		margin: 0 auto 0.75rem;
		filter: drop-shadow(0 6px 12px rgba(15, 23, 42, 0.35));
	}
	@media (max-width: 880px) {
		.app-shell,
		body.sidebar-collapsed .app-shell { padding-right: 0; }
		.sidebar,
		body.sidebar-collapsed .sidebar {
			width: min(86vw, 326px);
			transform: translateX(100%);
		}
		body.sidebar-open .sidebar { transform: translateX(0); }
		.sidebar-toggle {
			left: -44px;
			top: 18px;
			width: 38px;
			height: 38px;
		}
		.topbar {
			height: 72px;
			padding: 0 1rem;
		}
		.main-content { padding: 1.6rem 1rem 2rem; }
		.segmented-tabs {
			width: 100%;
			overflow-x: auto;
		}
		.workspace-tab { flex: 0 0 auto; }
		.workspace-panel,
		.capture-panel { padding: 1.35rem; }
		.lookup-row,
		.book-grid { grid-template-columns: 1fr; }
	}
</style>
</head>
<body>
	<aside class="sidebar" aria-label="Nurse workspace menu">
		<button class="sidebar-toggle" id="sidebarToggle" type="button" aria-label="Toggle menu">
			<i class="bi bi-chevron-right"></i>
		</button>
		<div class="brand-block">
			<div class="brand-mark"><img src="img/uht_bg.png" alt="Umlilo HealthTech logo"></div>
			<div class="brand-copy">
				<div class="brand-title">Umlilo Health</div>
				<div class="brand-subtitle">Technologies</div>
			</div>
		</div>
		<nav class="nav-menu">
			<a href="home" class="nav-item-link"><i class="bi bi-grid"></i><span class="nav-label">Dashboard</span></a>
			<a href="appointment" class="nav-item-link"><i class="bi bi-people"></i><span class="nav-label">Patients</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-diagram-3"></i><span class="nav-label">Patient Flow</span></a>
			<a href="capture-appointment" class="nav-item-link active"><i class="bi bi-stethoscope"></i><span class="nav-label">Nurse Workspace</span></a>
			<a href="visits-today" class="nav-item-link"><i class="bi bi-activity"></i><span class="nav-label">Visits Today</span></a>
			<a href="vitals-overview" class="nav-item-link"><i class="bi bi-heart-pulse"></i><span class="nav-label">Vitals Overview</span></a>
			<a href="referrals" class="nav-item-link"><i class="bi bi-arrow-left-right"></i><span class="nav-label">Referrals</span></a>
			<a href="screening" class="nav-item-link"><i class="bi bi-clipboard2-pulse"></i><span class="nav-label">Screening</span></a>
			<a href="health-education" class="nav-item-link"><i class="bi bi-book"></i><span class="nav-label">Health Education</span></a>
		</nav>
		<div class="sidebar-footer">
			<div class="role-switch">
				<a href="home" class="active"><i class="bi bi-stethoscope"></i> Nurse</a>
				<a href="doctor"><i class="bi bi-person-gear"></i> Doctor</a>
			</div>
			<a href="logout" class="sign-out"><i class="bi bi-box-arrow-right"></i><span>Sign Out</span></a>
		</div>
	</aside>

	<div class="app-shell">
		<header class="topbar">
			<button class="notification" type="button" aria-label="Notifications">
				<i class="bi bi-bell"></i>
				<span class="notification-count">4</span>
			</button>
		</header>

		<main class="main-content">
			<section id="workspaceHub">
				<h1 class="page-title">Nurse Workspace</h1>
				<p class="page-subtitle">Register patients, look up records, and book appointments</p>

				<div class="segmented-tabs" role="tablist" aria-label="Nurse workspace actions">
					<button class="workspace-tab active" type="button" data-tab="register"><i class="bi bi-person-plus"></i> Register Patient</button>
					<button class="workspace-tab" type="button" data-tab="lookup"><i class="bi bi-search"></i> Lookup by ID</button>
					<button class="workspace-tab" type="button" data-tab="book"><i class="bi bi-calendar2-plus"></i> Book Appointment</button>
				</div>

				<div class="workspace-panel" id="registerPanel">
					<h2>Register a New Patient</h2>
					<p class="register-copy">Click below to open the registration form and capture the patient's details.</p>
					<a href="patient" class="btn btn-primary"><i class="bi bi-person-plus"></i> Open Registration Form</a>
				</div>

				<div class="workspace-panel hidden" id="lookupPanel">
					<h2>Look Up Patient by ID or Passport Number</h2>
					<div class="lookup-row">
						<div class="search-input-wrap">
							<i class="bi bi-search" aria-hidden="true"></i>
							<input class="form-control" id="lookupQuery" type="search" placeholder="Enter SA ID number or Passport number...">
						</div>
						<button class="btn btn-primary" id="lookupBtn" type="button"><i class="bi bi-search"></i> Search</button>
					</div>
					<div id="lookupAlert" class="alert alert-info mt-3 d-none"></div>
					<div class="patient-results" id="lookupResults"></div>
				</div>

				<div class="workspace-panel hidden" id="bookPanel">
					<h2>Book a Patient Appointment</h2>
					<div class="book-grid">
						<div class="full-width">
							<label class="form-label" for="bookPatientSearch">Search Patient</label>
							<div class="search-input-wrap">
								<i class="bi bi-search" aria-hidden="true"></i>
								<input class="form-control" id="bookPatientSearch" type="search" placeholder="Search by name or ID number...">
							</div>
							<div class="patient-chip" id="selectedPatientChip"></div>
							<div class="patient-results" id="bookPatientResults"></div>
						</div>
						<div>
							<label class="form-label" for="appointmentDateTime">Date &amp; Time</label>
							<input class="form-control" id="appointmentDateTime" type="datetime-local">
						</div>
						<div>
							<label class="form-label" for="visitType">Visit Type</label>
							<select class="form-select" id="visitType">
								<option>Walk-in</option>
								<option>Follow-up</option>
								<option>Screening</option>
								<option>Emergency</option>
								<option>Chronic Care</option>
							</select>
						</div>
						<div>
							<label class="form-label" for="department">Department</label>
							<select class="form-select" id="department">
								<option>General</option>
								<option>Primary Care</option>
								<option>Screening</option>
								<option>Maternal Health</option>
								<option>Chronic Care</option>
							</select>
						</div>
						<div>
							<label class="form-label" for="attendingProvider">Attending Provider</label>
							<input class="form-control" id="attendingProvider" type="text" placeholder="Doctor or nurse name">
						</div>
						<div class="full-width">
							<label class="form-label" for="chiefComplaint">Chief Complaint / Reason for Visit</label>
							<input class="form-control" id="chiefComplaint" type="text" placeholder="e.g. Persistent headache, routine follow-up...">
						</div>
					</div>
					<div id="bookAlert" class="alert alert-info mt-3 d-none"></div>
					<div class="form-actions">
						<button class="btn btn-primary" id="bookAppointmentBtn" type="button" disabled><i class="bi bi-calendar2-plus"></i> Book Appointment</button>
					</div>
				</div>
			</section>

			<section id="appointmentCapture" class="hidden">
				<h1 class="page-title">Appointment Assessment</h1>
				<p class="page-subtitle">Open the patient appointment and update nurse notes.</p>

				<div class="row g-4 mt-2">
					<div class="col-lg-4">
						<div class="capture-panel h-100">
							<h2>Patient Details</h2>
							<ul class="list-unstyled mb-3">
								<li><strong>Name:</strong> <span id="patientName">-</span></li>
								<li><strong>ID:</strong> <span id="patientIdNumber">-</span></li>
								<li><strong>Cell:</strong> <span id="patientCell">-</span></li>
								<li><strong>Appointment:</strong> <span id="appointmentTime">-</span></li>
							</ul>
							<div class="alert alert-info mb-0" id="appointmentStatus">Status: -</div>
						</div>
					</div>
					<div class="col-lg-8">
						<div class="capture-panel">
							<h2>Nurse Notes</h2>
							<label class="form-label" for="nurseNotes">Nurse Notes</label>
							<textarea class="form-control" rows="8" id="nurseNotes" placeholder="Record vitals, symptoms, observations, and intake notes"></textarea>
							<div class="d-flex flex-wrap gap-2 mt-3">
								<button class="btn btn-primary" id="saveAppointmentBtn" type="button"><i class="bi bi-check2-circle"></i> Update Appointment</button>
								<button class="btn btn-outline-primary" id="attachFilesBtn" type="button"><i class="bi bi-paperclip"></i> Attach Files</button>
								<a href="current-appointment" class="btn btn-outline-primary">Back to Flow</a>
							</div>
							<input type="file" id="attachmentInput" class="d-none">
							<div id="attachmentList" class="mt-3"></div>
							<div id="captureAlert" class="alert alert-info mt-3 d-none"></div>
						</div>
					</div>
				</div>
			</section>
		</main>
	</div>

	<div class="loading-overlay" id="loadingOverlay">
		<div class="loading-card">
			<img src="img/uht_bg.png" alt="Umlilo HealthTech logo" class="loading-logo">
			<div class="spinner-border text-light" role="status"></div>
			<div class="mt-3 fw-bold">Loading...</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	var loadingCount = 0;
	var loadingStart = 0;
	var loadingMinMs = 350;
	var selectedPatient = null;
	var bookSearchTimer = null;

	function showLoading() {
		loadingCount += 1;
		if (loadingCount === 1) loadingStart = Date.now();
		document.getElementById("loadingOverlay").classList.add("show");
	}

	function hideLoading() {
		loadingCount = Math.max(0, loadingCount - 1);
		if (loadingCount === 0) {
			var elapsed = Date.now() - loadingStart;
			var remaining = Math.max(0, loadingMinMs - elapsed);
			setTimeout(function () {
				if (loadingCount === 0) document.getElementById("loadingOverlay").classList.remove("show");
			}, remaining);
		}
	}

	function escapeHtml(value) {
		return String(value == null ? "" : value)
			.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#039;");
	}

	function showAlert(id, message, type) {
		var alertEl = document.getElementById(id);
		alertEl.className = "alert alert-" + (type || "info") + " mt-3";
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function hideAlert(id) {
		document.getElementById(id).classList.add("d-none");
	}

	function setActiveTab(tabName) {
		document.querySelectorAll(".workspace-tab").forEach(function (tab) {
			tab.classList.toggle("active", tab.getAttribute("data-tab") === tabName);
		});
		["register", "lookup", "book"].forEach(function (name) {
			document.getElementById(name + "Panel").classList.toggle("hidden", name !== tabName);
		});
	}

	function renderPatientResults(containerId, patients, mode) {
		var container = document.getElementById(containerId);
		container.innerHTML = "";
		if (!patients.length) {
			container.innerHTML = "<div class=\"empty-state\">No matching patients found.</div>";
			return;
		}
		patients.forEach(function (patient) {
			var row = document.createElement("div");
			row.className = "patient-result";
			var name = patient.fullName || patient.name || ((patient.firstName || "") + " " + (patient.surname || "")).trim() || "Unnamed Patient";
			var idNumber = patient.idNumber || "";
			var cell = patient.cell || "";
			row.innerHTML =
				"<div>" +
					"<div class=\"result-title\">" + escapeHtml(name) + "</div>" +
					"<div class=\"result-meta\">" + escapeHtml(idNumber || "No ID") + (cell ? " | " + escapeHtml(cell) : "") + "</div>" +
				"</div>";
			if (mode === "book") {
				var button = document.createElement("button");
				button.className = "btn btn-sm btn-outline-primary";
				button.type = "button";
				button.textContent = "Select";
				button.addEventListener("click", function () {
					selectedPatient = { name: name, idNumber: idNumber, cell: cell };
					document.getElementById("selectedPatientChip").innerHTML = "<i class=\"bi bi-person-check\"></i> " + escapeHtml(name) + " - " + escapeHtml(idNumber);
					document.getElementById("selectedPatientChip").classList.add("show");
					document.getElementById("bookPatientResults").innerHTML = "";
					document.getElementById("bookAppointmentBtn").disabled = !selectedPatient.idNumber;
				});
				row.appendChild(button);
			} else {
				var link = document.createElement("a");
				link.className = "btn btn-sm btn-outline-primary";
				link.href = "appointment";
				link.textContent = "Open Records";
				row.appendChild(link);
			}
			container.appendChild(row);
		});
	}

	function lookupPatients() {
		var query = document.getElementById("lookupQuery").value.trim();
		if (!query) {
			showAlert("lookupAlert", "Enter an ID or passport number to search.", "warning");
			return;
		}
		hideAlert("lookupAlert");
		showLoading();
		fetch("rest/patients/list?query=" + encodeURIComponent(query))
			.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					renderPatientResults("lookupResults", result.data.patients || [], "lookup");
				} else {
					showAlert("lookupAlert", result.data.message || "Unable to search patients.", "warning");
				}
			})
			.catch(function () { showAlert("lookupAlert", "Unable to reach server.", "danger"); })
			.finally(hideLoading);
	}

	function searchBookPatients() {
		var query = document.getElementById("bookPatientSearch").value.trim();
		if (!query) {
			document.getElementById("bookPatientResults").innerHTML = "";
			return;
		}
		showLoading();
		fetch("rest/patients/search-list?query=" + encodeURIComponent(query))
			.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					renderPatientResults("bookPatientResults", result.data.patients || [], "book");
				} else {
					showAlert("bookAlert", result.data.message || "Unable to search patients.", "warning");
				}
			})
			.catch(function () { showAlert("bookAlert", "Unable to reach server.", "danger"); })
			.finally(hideLoading);
	}

	function setDefaultAppointmentTime() {
		var now = new Date();
		now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
		document.getElementById("appointmentDateTime").value = now.toISOString().slice(0, 16);
	}

	function bookAppointment() {
		if (!selectedPatient || !selectedPatient.idNumber) {
			showAlert("bookAlert", "Select a patient before booking.", "warning");
			return;
		}
		var dateTime = document.getElementById("appointmentDateTime").value;
		if (!dateTime) {
			showAlert("bookAlert", "Date and time are required.", "warning");
			return;
		}
		var notes = [
			"Visit Type: " + document.getElementById("visitType").value,
			"Department: " + document.getElementById("department").value,
			"Attending Provider: " + document.getElementById("attendingProvider").value.trim(),
			"Chief Complaint: " + document.getElementById("chiefComplaint").value.trim()
		].join("\n");

		showLoading();
		fetch("rest/appointments/create", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({
				idNumber: selectedPatient.idNumber,
				date: dateTime.slice(0, 10),
				time: dateTime.slice(11, 16),
				notes: notes
			})
		})
		.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showAlert("bookAlert", "Appointment booked successfully.", "success");
				setTimeout(function () { window.location.href = "visits-today"; }, 1200);
			} else {
				showAlert("bookAlert", result.data.message || "Unable to book appointment.", "warning");
			}
		})
		.catch(function () { showAlert("bookAlert", "Unable to reach server.", "danger"); })
		.finally(hideLoading);
	}

	function showCaptureAlert(message, type) {
		showAlert("captureAlert", message, type);
	}

	function loadAppointment() {
		var appointmentId = new URLSearchParams(window.location.search).get("appointmentId");
		if (!appointmentId) return;
		showLoading();
		fetch("rest/appointments/detail?id=" + encodeURIComponent(appointmentId))
			.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					document.getElementById("patientName").textContent = result.data.patient.name || "-";
					document.getElementById("patientIdNumber").textContent = result.data.patient.idNumber || "-";
					document.getElementById("patientCell").textContent = result.data.patient.cell || "-";
					document.getElementById("appointmentTime").textContent = result.data.appointment.appointmentTime || "-";
					document.getElementById("appointmentStatus").textContent = "Status: " + (result.data.appointment.status || "-");
					document.getElementById("nurseNotes").value = result.data.appointment.nurseNotes || "";
				} else {
					showCaptureAlert(result.data.message || "Unable to load appointment.", "warning");
				}
			})
			.catch(function () { showCaptureAlert("Unable to reach server. Please try again.", "danger"); })
			.finally(hideLoading);
	}

	function loadAttachments() {
		var appointmentId = new URLSearchParams(window.location.search).get("appointmentId");
		if (!appointmentId) return;
		showLoading();
		fetch("rest/appointments/attachments?appointmentId=" + encodeURIComponent(appointmentId))
			.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
			.then(function (result) {
				var listEl = document.getElementById("attachmentList");
				listEl.innerHTML = "";
				if (result.status === 200 && result.data.success && result.data.attachments.length > 0) {
					result.data.attachments.forEach(function (att) {
						var row = document.createElement("div");
						row.className = "d-flex justify-content-between align-items-center border rounded-3 p-2 mb-2";
						row.innerHTML = "<a target=\"_blank\" rel=\"noopener\" href=\"uploads/" + encodeURIComponent(att.storedName) + "\">" + escapeHtml(att.originalName) + "</a><span class=\"small text-muted\">" + (att.fileSize ? Math.round(att.fileSize / 1024) + " KB" : "") + "</span>";
						listEl.appendChild(row);
					});
				}
			})
			.catch(function () {})
			.finally(hideLoading);
	}

	function uploadAttachment() {
		var fileInput = document.getElementById("attachmentInput");
		if (!fileInput.files || fileInput.files.length === 0) return;
		var appointmentId = new URLSearchParams(window.location.search).get("appointmentId");
		if (!appointmentId) {
			showCaptureAlert("Appointment ID is missing.", "warning");
			return;
		}
		var formData = new FormData();
		formData.append("appointmentId", appointmentId);
		formData.append("file", fileInput.files[0]);
		showLoading();
		fetch("rest/appointments/upload", { method: "POST", body: formData })
			.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					showCaptureAlert("Attachment uploaded.", "success");
					fileInput.value = "";
					loadAttachments();
				} else {
					showCaptureAlert(result.data.message || "Unable to upload attachment.", "warning");
				}
			})
			.catch(function () { showCaptureAlert("Unable to reach server. Please try again.", "danger"); })
			.finally(hideLoading);
	}

	function saveAppointmentNotes() {
		var appointmentId = new URLSearchParams(window.location.search).get("appointmentId");
		var nurseNotes = document.getElementById("nurseNotes").value.trim();
		document.getElementById("nurseNotes").classList.remove("is-invalid");
		if (!nurseNotes) {
			document.getElementById("nurseNotes").classList.add("is-invalid");
			showCaptureAlert("Nurse notes are required.", "warning");
			return;
		}
		showLoading();
		fetch("rest/appointments/nurse-notes", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ appointmentId: Number(appointmentId), nurseNotes: nurseNotes })
		})
		.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showCaptureAlert("Appointment updated. Pending doctor sign-off.", "success");
				document.getElementById("appointmentStatus").textContent = "Status: PENDING_DOCTOR";
				setTimeout(function () { window.location.href = "current-appointment"; }, 1800);
			} else {
				showCaptureAlert(result.data.message || "Unable to capture appointment.", "warning");
			}
		})
		.catch(function () { showCaptureAlert("Unable to reach server. Please try again.", "danger"); })
		.finally(hideLoading);
	}

	document.getElementById("sidebarToggle").addEventListener("click", function () {
		if (window.matchMedia("(max-width: 880px)").matches) {
			document.body.classList.toggle("sidebar-open");
		} else {
			document.body.classList.toggle("sidebar-collapsed");
		}
	});

	document.querySelectorAll(".workspace-tab").forEach(function (tab) {
		tab.addEventListener("click", function () { setActiveTab(tab.getAttribute("data-tab")); });
	});
	document.getElementById("lookupBtn").addEventListener("click", lookupPatients);
	document.getElementById("lookupQuery").addEventListener("keydown", function (event) {
		if (event.key === "Enter") lookupPatients();
	});
	document.getElementById("bookPatientSearch").addEventListener("keydown", function (event) {
		if (event.key === "Enter") searchBookPatients();
	});
	document.getElementById("bookPatientSearch").addEventListener("input", function () {
		clearTimeout(bookSearchTimer);
		bookSearchTimer = setTimeout(searchBookPatients, 350);
	});
	document.getElementById("bookAppointmentBtn").addEventListener("click", bookAppointment);
	document.getElementById("attachFilesBtn").addEventListener("click", function () {
		document.getElementById("attachmentInput").click();
	});
	document.getElementById("attachmentInput").addEventListener("change", uploadAttachment);
	document.getElementById("saveAppointmentBtn").addEventListener("click", saveAppointmentNotes);

	setDefaultAppointmentTime();
	var pageParams = new URLSearchParams(window.location.search);
	var requestedTab = pageParams.get("tab");
	if (requestedTab === "lookup" || requestedTab === "book" || requestedTab === "register") {
		setActiveTab(requestedTab);
	}
	if (pageParams.get("appointmentId")) {
		document.getElementById("workspaceHub").classList.add("hidden");
		document.getElementById("appointmentCapture").classList.remove("hidden");
		loadAppointment();
		loadAttachments();
	}
</script>
</body>
</html>
