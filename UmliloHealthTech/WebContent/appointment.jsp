<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Patients</title>
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
		--teal: #10bfa6;
		--orange: #f59e0b;
		--blue: #3b82f6;
		--red: #ef4444;
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
		height: 72px;
		background: #fff;
		border-bottom: 1px solid var(--line);
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0 2.35rem;
		gap: 1rem;
	}
	.topbar-title {
		font-weight: 800;
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
		top: -4px;
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
		padding: 2rem 2.35rem 3rem;
		max-width: 1260px;
	}
	.page-title {
		font-size: clamp(1.6rem, 1.35rem + 1vw, 2rem);
		font-weight: 800;
		margin: 0 0 0.35rem;
	}
	.page-subtitle {
		color: var(--muted);
		margin: 0;
	}
	.search-panel,
	.patient-card,
	.profile-card,
	.history-panel {
		background: var(--panel);
		border: 1px solid var(--line);
		box-shadow: 0 10px 24px rgba(15, 35, 55, 0.08);
		border-radius: 14px;
	}
	.search-panel {
		padding: 1rem;
		display: grid;
		grid-template-columns: minmax(220px, 1fr) auto auto;
		gap: 0.8rem;
		align-items: center;
	}
	.form-control,
	.form-select {
		border-radius: 11px;
		border-color: var(--line);
		min-height: 44px;
	}
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
		border-radius: 11px;
		font-weight: 800;
		min-height: 44px;
	}
	.btn-primary:hover {
		background: #075f88;
		border-color: #075f88;
	}
	.btn-outline-secondary,
	.btn-outline-primary {
		border-radius: 11px;
		font-weight: 800;
		min-height: 44px;
	}
	.patients-grid {
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 1rem;
	}
	.patient-card {
		padding: 1rem;
		display: grid;
		grid-template-columns: auto minmax(0, 1fr);
		gap: 0.9rem;
		cursor: pointer;
		text-align: left;
		width: 100%;
		transition: transform 0.16s ease, border-color 0.16s ease, box-shadow 0.16s ease;
	}
	.patient-card:hover,
	.patient-card.active {
		transform: translateY(-2px);
		border-color: #9ccfe5;
		box-shadow: 0 14px 28px rgba(15, 35, 55, 0.1);
	}
	.patient-avatar,
	.profile-avatar {
		border-radius: 16px;
		background: #e7f1f6;
		color: var(--brand);
		font-weight: 800;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		flex: 0 0 auto;
	}
	.patient-avatar {
		width: 48px;
		height: 48px;
	}
	.patient-name {
		font-weight: 800;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.patient-meta,
	.muted-small {
		color: var(--muted);
		font-size: 0.86rem;
	}
	.chip {
		display: inline-flex;
		align-items: center;
		gap: 0.3rem;
		border-radius: 999px;
		border: 1px solid var(--line);
		background: #fff;
		padding: 0.28rem 0.65rem;
		font-size: 0.78rem;
		font-weight: 800;
		margin: 0.2rem 0.25rem 0.2rem 0;
	}
	.chip-green {
		background: #dcfce7;
		border-color: #86efac;
		color: #047857;
	}
	.chip-red {
		background: #fff1f2;
		border-color: #fecdd3;
		color: #dc2626;
	}
	.chip-orange {
		background: #fff7ed;
		border-color: #fed7aa;
		color: #c2410c;
	}
	.profile-card {
		padding: 1.45rem;
	}
	.profile-main {
		display: grid;
		grid-template-columns: auto minmax(0, 1fr) auto;
		gap: 1rem;
		align-items: start;
	}
	.profile-avatar {
		width: 54px;
		height: 54px;
	}
	.profile-name {
		font-size: 1.15rem;
		font-weight: 800;
		margin-bottom: 0.15rem;
	}
	.profile-contact {
		text-align: right;
		color: #34495e;
		font-size: 0.9rem;
	}
	.details-grid {
		border-top: 1px solid var(--line);
		margin-top: 1.2rem;
		padding-top: 1.2rem;
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 1rem;
	}
	.detail-label {
		color: #536b83;
		font-size: 0.72rem;
		font-weight: 800;
		letter-spacing: 0.08em;
		text-transform: uppercase;
		margin-bottom: 0.35rem;
	}
	.detail-value {
		font-weight: 700;
		overflow-wrap: anywhere;
	}
	.tabs-wrap {
		display: inline-flex;
		gap: 0.35rem;
		background: #e9eef3;
		padding: 0.35rem;
		border-radius: 12px;
		max-width: 100%;
		overflow-x: auto;
	}
	.record-tab {
		border: 0;
		background: transparent;
		color: #526985;
		border-radius: 9px;
		padding: 0.55rem 0.85rem;
		font-weight: 800;
		white-space: nowrap;
	}
	.record-tab.active {
		background: #fff;
		color: var(--ink);
		box-shadow: 0 6px 14px rgba(15, 35, 55, 0.08);
	}
	.history-count {
		color: #536b83;
		font-size: 0.84rem;
		margin: 1.5rem 0 1rem;
	}
	.timeline {
		position: relative;
		padding-left: 1.6rem;
	}
	.timeline:before {
		content: "";
		position: absolute;
		left: 0.35rem;
		top: 0.5rem;
		bottom: 0.5rem;
		width: 1px;
		background: var(--line);
	}
	.timeline-item {
		position: relative;
		margin-bottom: 1rem;
	}
	.timeline-dot {
		position: absolute;
		left: -1.55rem;
		top: 0.7rem;
		width: 12px;
		height: 12px;
		border-radius: 50%;
		background: var(--brand);
	}
	.event-card {
		border: 1px solid var(--line);
		background: #fff;
		border-radius: 12px;
		padding: 1rem;
	}
	.event-title {
		font-weight: 800;
		margin-bottom: 0.4rem;
	}
	.empty-state {
		color: var(--muted);
		padding: 1.4rem;
		border: 1px dashed var(--line);
		border-radius: 12px;
		background: #fff;
	}
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
		top: 102px;
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
		height: 92px;
		display: flex;
		align-items: center;
		gap: 0.9rem;
		padding: 1.45rem 1.5rem;
		border-bottom: 1px solid rgba(255, 255, 255, 0.05);
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
		padding: 1.25rem 1.1rem;
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
	}
	.loading-logo {
		width: 210px;
		max-width: 100%;
		height: auto;
		margin: 0 auto 0.75rem;
		filter: drop-shadow(0 6px 12px rgba(15, 23, 42, 0.35));
	}
	@media (max-width: 1180px) {
		.patients-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
		.details-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
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
		.topbar { padding: 0 1rem; }
		.main-content { padding: 1.5rem 1rem 2rem; }
		.search-panel { grid-template-columns: 1fr; }
		.patients-grid,
		.details-grid { grid-template-columns: 1fr; }
		.profile-main {
			grid-template-columns: auto minmax(0, 1fr);
		}
		.profile-contact {
			grid-column: 1 / -1;
			text-align: left;
		}
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
			<a href="appointment" class="nav-item-link active"><i class="bi bi-people"></i><span class="nav-label">Patients</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-diagram-3"></i><span class="nav-label">Patient Flow</span></a>
			<a href="capture-appointment" class="nav-item-link"><i class="bi bi-stethoscope"></i><span class="nav-label">Nurse Workspace</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-activity"></i><span class="nav-label">Visits Today</span></a>
			<a href="#" class="nav-item-link"><i class="bi bi-heart-pulse"></i><span class="nav-label">Vitals Overview</span></a>
			<a href="#" class="nav-item-link"><i class="bi bi-arrow-left-right"></i><span class="nav-label">Referrals</span></a>
			<a href="screening" class="nav-item-link"><i class="bi bi-clipboard2-pulse"></i><span class="nav-label">Screening</span></a>
			<a href="health-education" class="nav-item-link"><i class="bi bi-book"></i><span class="nav-label">Health Education</span></a>
		</nav>
		<div class="sidebar-footer">
			<a href="logout" class="sign-out"><i class="bi bi-box-arrow-right"></i><span>Sign Out</span></a>
		</div>
	</aside>

	<div class="app-shell">
		<header class="topbar">
			<div class="topbar-title">Patients</div>
			<button class="notification" type="button" aria-label="Notifications">
				<i class="bi bi-bell"></i>
				<span class="notification-count">4</span>
			</button>
		</header>

		<main class="main-content">
			<div class="d-flex flex-column flex-lg-row justify-content-between gap-3 mb-4">
				<div>
					<h1 class="page-title">Patients</h1>
					<p class="page-subtitle">Search, add, and review patient medical records.</p>
				</div>
				<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#addPatientModal">
					<i class="bi bi-plus-lg me-1"></i> Add Patient
				</button>
			</div>

			<section class="search-panel mb-4">
				<input type="text" class="form-control" id="patientSearch" placeholder="Search by name, surname, or ID number">
				<button class="btn btn-outline-primary" type="button" id="searchBtn"><i class="bi bi-search me-1"></i> Search</button>
				<button class="btn btn-outline-secondary" type="button" id="clearBtn">Clear</button>
			</section>

			<section class="patients-grid mb-4" id="patientsGrid">
				<div class="empty-state">Loading patients...</div>
			</section>

			<section class="profile-card mb-4 d-none" id="patientProfile">
				<div class="profile-main">
					<div class="profile-avatar" id="profileInitials">--</div>
					<div>
						<div class="profile-name" id="profileName">Select a patient</div>
						<div class="muted-small">ID: <span id="profileIdNumber">-</span></div>
						<div class="mt-2" id="profileChips"></div>
					</div>
					<div class="profile-contact">
						<div><i class="bi bi-telephone me-1"></i><span id="profileCell">-</span></div>
						<div id="profileFacility">Livingstone Hospital</div>
						<div>DOB: <span id="profileDob">-</span></div>
						<button class="btn btn-sm btn-outline-secondary mt-2" type="button"><i class="bi bi-download me-1"></i> Export PDF</button>
					</div>
				</div>

				<div class="details-grid">
					<div>
						<div class="detail-label"><i class="bi bi-exclamation-triangle text-danger me-1"></i>Allergies</div>
						<div id="profileAllergies"><span class="chip chip-red">Not recorded</span></div>
					</div>
					<div>
						<div class="detail-label">Chronic Conditions</div>
						<div id="profileChronic"><span class="chip chip-orange">Not recorded</span></div>
					</div>
					<div>
						<div class="detail-label">Address</div>
						<div class="detail-value" id="profileAddress">-</div>
					</div>
					<div>
						<div class="detail-label">Sex</div>
						<div class="detail-value" id="profileGender">-</div>
					</div>
					<div>
						<div class="detail-label">Next of Kin</div>
						<div class="detail-value" id="profileKin">-</div>
					</div>
					<div>
						<div class="detail-label">Notes</div>
						<div class="detail-value" id="profileNotes">-</div>
					</div>
				</div>
			</section>

			<section class="history-panel p-3 p-lg-4 d-none" id="historyPanel">
				<div class="tabs-wrap" role="tablist">
					<button class="record-tab active" type="button" data-tab="medicalHistory"><i class="bi bi-clock-history me-1"></i> Medical History <span id="medicalHistoryCount">(0)</span></button>
					<button class="record-tab" type="button" data-tab="visits"><i class="bi bi-stethoscope me-1"></i> Visits <span id="visitsCount">(0)</span></button>
					<button class="record-tab" type="button" data-tab="prescriptions"><i class="bi bi-capsule me-1"></i> Prescriptions <span id="prescriptionsCount">(0)</span></button>
					<button class="record-tab" type="button" data-tab="labResults"><i class="bi bi-flask me-1"></i> Lab Results <span id="labResultsCount">(0)</span></button>
				</div>
				<div class="history-count" id="historySummary">0 events, most recent first</div>
				<div class="timeline" id="historyTimeline"></div>
			</section>
		</main>
	</div>

	<div class="modal fade" id="addPatientModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Add Patient</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="row g-3">
						<div class="col-md-6">
							<label class="form-label">First Name</label>
							<input type="text" class="form-control" id="addFirstName">
						</div>
						<div class="col-md-6">
							<label class="form-label">Surname</label>
							<input type="text" class="form-control" id="addSurname">
						</div>
						<div class="col-md-6">
							<label class="form-label">ID Number</label>
							<input type="text" class="form-control" id="addIdNumber">
						</div>
						<div class="col-md-6">
							<label class="form-label">Cellphone</label>
							<input type="text" class="form-control" id="addCell">
						</div>
						<div class="col-md-6">
							<label class="form-label">Sex</label>
							<select class="form-select" id="addGender">
								<option value="">Choose...</option>
								<option>Female</option>
								<option>Male</option>
								<option>Other</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label">Email</label>
							<input type="email" class="form-control" id="addEmail">
						</div>
						<div class="col-12">
							<label class="form-label">Address</label>
							<input type="text" class="form-control" id="addAddress">
						</div>
						<div class="col-md-6">
							<label class="form-label">Chronic Conditions</label>
							<input type="text" class="form-control" id="addIllnesses" placeholder="e.g. Hypertension, Diabetes">
						</div>
						<div class="col-md-6">
							<label class="form-label">Notes</label>
							<input type="text" class="form-control" id="addIllnessNotes">
						</div>
						<div class="col-12">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="addConsent">
								<label class="form-check-label" for="addConsent">Patient consent captured</label>
							</div>
						</div>
					</div>
					<div id="addPatientAlert" class="alert alert-warning mt-3 d-none"></div>
				</div>
				<div class="modal-footer">
					<a href="patient" class="btn btn-outline-secondary">Open Full Capture</a>
					<button type="button" class="btn btn-primary" id="savePatientBtn">Save Patient</button>
				</div>
			</div>
		</div>
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
	var currentDetail = null;
	var activeTab = "medicalHistory";
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

	function escapeHtml(value) {
		return String(value == null ? "" : value)
			.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#039;");
	}

	function initials(name) {
		var parts = String(name || "").trim().split(/\s+/).filter(Boolean);
		if (!parts.length) return "--";
		return parts.slice(0, 2).map(function (part) { return part.charAt(0).toUpperCase(); }).join("");
	}

	function splitTags(value) {
		if (!value) return [];
		return String(value).split(",").map(function (item) { return item.trim(); }).filter(Boolean);
	}

	function parseDob(idNumber) {
		if (!/^\d{6}/.test(idNumber || "")) return "-";
		var yy = parseInt(idNumber.substring(0, 2), 10);
		var mm = parseInt(idNumber.substring(2, 4), 10);
		var dd = parseInt(idNumber.substring(4, 6), 10);
		var now = new Date();
		var fullYear = (yy + 2000) <= now.getFullYear() ? yy + 2000 : yy + 1900;
		var dob = new Date(fullYear, mm - 1, dd);
		if (isNaN(dob.getTime())) return "-";
		return dob.toLocaleDateString([], { day: "2-digit", month: "short", year: "numeric" });
	}

	function showAddAlert(message, type) {
		var alertEl = document.getElementById("addPatientAlert");
		alertEl.className = "alert alert-" + type + " mt-3";
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function renderPatients(patients) {
		var grid = document.getElementById("patientsGrid");
		grid.innerHTML = "";
		if (!patients || !patients.length) {
			grid.innerHTML = "<div class=\"empty-state\">No patients found.</div>";
			return;
		}
		patients.forEach(function (patient) {
			var button = document.createElement("button");
			button.type = "button";
			button.className = "patient-card";
			button.setAttribute("data-id", patient.id);
			button.innerHTML =
				"<span class=\"patient-avatar\">" + escapeHtml(initials(patient.fullName)) + "</span>" +
				"<span>" +
					"<span class=\"patient-name d-block\">" + escapeHtml(patient.fullName || "-") + "</span>" +
					"<span class=\"patient-meta d-block\">ID: " + escapeHtml(patient.idNumber || "-") + "</span>" +
					"<span class=\"patient-meta d-block\">" + escapeHtml(patient.gender || "Sex not recorded") + " | " + escapeHtml(patient.cell || "No cell") + "</span>" +
					"<span class=\"chip chip-green\">Active</span>" +
				"</span>";
			button.addEventListener("click", function () {
				document.querySelectorAll(".patient-card").forEach(function (card) { card.classList.remove("active"); });
				button.classList.add("active");
				loadPatientDetail(patient.id);
			});
			grid.appendChild(button);
		});
	}

	function renderChips(containerId, values, className) {
		var container = document.getElementById(containerId);
		container.innerHTML = "";
		if (!values.length) {
			container.innerHTML = "<span class=\"chip " + className + "\">Not recorded</span>";
			return;
		}
		values.forEach(function (value) {
			var chip = document.createElement("span");
			chip.className = "chip " + className;
			chip.textContent = value;
			container.appendChild(chip);
		});
	}

	function renderProfile(patient) {
		document.getElementById("patientProfile").classList.remove("d-none");
		document.getElementById("historyPanel").classList.remove("d-none");
		document.getElementById("profileInitials").textContent = initials(patient.fullName);
		document.getElementById("profileName").textContent = patient.fullName || "-";
		document.getElementById("profileIdNumber").textContent = patient.idNumber || "-";
		document.getElementById("profileCell").textContent = patient.cell || "-";
		document.getElementById("profileDob").textContent = parseDob(patient.idNumber);
		document.getElementById("profileAddress").textContent = patient.address || "-";
		document.getElementById("profileGender").textContent = patient.gender || "-";
		document.getElementById("profileKin").textContent = patient.nextOfKinName || "-";
		document.getElementById("profileNotes").textContent = patient.illnessNotes || "-";
		document.getElementById("profileChips").innerHTML =
			"<span class=\"chip\">" + escapeHtml(patient.gender || "Sex not recorded") + "</span>" +
			"<span class=\"chip\">" + escapeHtml(patient.nationality || "Nationality not recorded") + "</span>" +
			"<span class=\"chip chip-green\">Active</span>";
		renderChips("profileAllergies", splitTags(patient.allergies === "Not recorded" ? "" : patient.allergies), "chip-red");
		renderChips("profileChronic", splitTags(patient.illnesses), "chip-orange");
	}

	function renderTimeline(rows, type) {
		var timeline = document.getElementById("historyTimeline");
		timeline.innerHTML = "";
		document.getElementById("historySummary").textContent = rows.length + " events, most recent first";
		if (!rows.length) {
			timeline.innerHTML = "<div class=\"empty-state\">No records found for this tab.</div>";
			return;
		}
		rows.forEach(function (item) {
			var title = item.summary || item.doctorSummary || item.prescription || "Clinical record";
			var body = item.nurseNotes || item.doctorSummary || item.additionalNotes || "No detailed notes recorded.";
			if (type === "prescriptions") {
				title = item.prescription || "Prescription";
				body = "Provider: " + (item.doctorName || item.nurseName || "Not recorded");
			}
			var node = document.createElement("div");
			node.className = "timeline-item";
			node.innerHTML =
				"<span class=\"timeline-dot\"></span>" +
				"<div class=\"mb-1\"><span class=\"chip\">" + escapeHtml(type === "prescriptions" ? "Prescription" : "Visit") + "</span> <span class=\"muted-small\">" + escapeHtml(item.date || "-") + "</span></div>" +
				"<div class=\"event-card\">" +
					"<div class=\"event-title\">" + escapeHtml(title) + "</div>" +
					"<div class=\"mb-2\">" + escapeHtml(body) + "</div>" +
					"<div class=\"muted-small\">Diagnosis: " + escapeHtml(item.doctorSummary || item.summary || "-") + "</div>" +
					"<div class=\"muted-small\">Nurse: " + escapeHtml(item.nurseName || "-") + " | Doctor: " + escapeHtml(item.doctorName || "-") + "</div>" +
				"</div>";
			timeline.appendChild(node);
		});
	}

	function refreshTabs() {
		if (!currentDetail) return;
		var rows = currentDetail[activeTab] || [];
		document.getElementById("medicalHistoryCount").textContent = "(" + (currentDetail.medicalHistory || []).length + ")";
		document.getElementById("visitsCount").textContent = "(" + (currentDetail.visits || []).length + ")";
		document.getElementById("prescriptionsCount").textContent = "(" + (currentDetail.prescriptions || []).length + ")";
		document.getElementById("labResultsCount").textContent = "(" + (currentDetail.labResults || []).length + ")";
		renderTimeline(rows, activeTab);
	}

	function loadPatients() {
		var query = document.getElementById("patientSearch").value.trim();
		showLoading();
		fetch("rest/patients/list?query=" + encodeURIComponent(query))
			.then(function (response) { return response.json(); })
			.then(function (data) { renderPatients(data.patients || []); })
			.catch(function () { renderPatients([]); })
			.finally(hideLoading);
	}

	function loadPatientDetail(id) {
		showLoading();
		fetch("rest/patients/detail?id=" + encodeURIComponent(id))
			.then(function (response) { return response.json(); })
			.then(function (data) {
				if (!data.success) return;
				currentDetail = data;
				activeTab = "medicalHistory";
				document.querySelectorAll(".record-tab").forEach(function (tab) {
					tab.classList.toggle("active", tab.getAttribute("data-tab") === activeTab);
				});
				renderProfile(data.patient);
				refreshTabs();
			})
			.finally(hideLoading);
	}

	document.getElementById("sidebarToggle").addEventListener("click", function () {
		if (window.matchMedia("(max-width: 880px)").matches) {
			document.body.classList.toggle("sidebar-open");
		} else {
			document.body.classList.toggle("sidebar-collapsed");
		}
	});

	document.getElementById("searchBtn").addEventListener("click", loadPatients);
	document.getElementById("patientSearch").addEventListener("keydown", function (event) {
		if (event.key === "Enter") loadPatients();
	});
	document.getElementById("clearBtn").addEventListener("click", function () {
		document.getElementById("patientSearch").value = "";
		loadPatients();
	});
	document.querySelectorAll(".record-tab").forEach(function (tab) {
		tab.addEventListener("click", function () {
			activeTab = tab.getAttribute("data-tab");
			document.querySelectorAll(".record-tab").forEach(function (item) { item.classList.remove("active"); });
			tab.classList.add("active");
			refreshTabs();
		});
	});

	document.getElementById("savePatientBtn").addEventListener("click", function () {
		var payload = {
			firstName: document.getElementById("addFirstName").value.trim(),
			surname: document.getElementById("addSurname").value.trim(),
			idNumber: document.getElementById("addIdNumber").value.trim(),
			cell: document.getElementById("addCell").value.trim(),
			gender: document.getElementById("addGender").value,
			email: document.getElementById("addEmail").value.trim(),
			address: document.getElementById("addAddress").value.trim(),
			employmentStatus: "",
			jobTitle: "",
			nextOfKinName: "",
			nextOfKinRelation: "",
			emergencyContact: "",
			isSouthAfrican: true,
			nationality: "South Africa",
			foreignId: "",
			illnesses: document.getElementById("addIllnesses").value.trim(),
			illnessNotes: document.getElementById("addIllnessNotes").value.trim(),
			consent: document.getElementById("addConsent").checked
		};
		if (!payload.firstName || !payload.surname || !payload.cell || !payload.consent) {
			showAddAlert("First name, surname, cellphone, and consent are required.", "warning");
			return;
		}
		showLoading();
		fetch("rest/patients/save", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(payload)
		})
		.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showAddAlert("Patient saved.", "success");
				loadPatients();
			} else {
				showAddAlert(result.data.message || "Unable to save patient.", "warning");
			}
		})
		.catch(function () { showAddAlert("Unable to reach server.", "danger"); })
		.finally(hideLoading);
	});

	loadPatients();
</script>
</body>
</html>
