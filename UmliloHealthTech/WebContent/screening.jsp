<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Screening Forms</title>
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
		--purple: #7c3aed;
		--red: #dc2626;
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
		height: 130px;
		background: #fff;
		border-bottom: 1px solid var(--line);
		display: flex;
		align-items: center;
		justify-content: flex-end;
		padding: 0 2.35rem;
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
		padding: 2.7rem 2.35rem 3rem;
		max-width: 1120px;
	}
	.page-head {
		display: flex;
		align-items: flex-start;
		justify-content: space-between;
		gap: 1rem;
		margin-bottom: 2.25rem;
	}
	.page-title {
		font-size: clamp(1.65rem, 1.35rem + 1vw, 2rem);
		font-weight: 800;
		margin: 0 0 0.35rem;
	}
	.page-subtitle {
		color: var(--muted);
		font-weight: 700;
		margin: 0;
	}
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
		border-radius: 9px;
		font-weight: 800;
		min-height: 45px;
		box-shadow: 0 5px 12px rgba(8, 121, 173, 0.22);
	}
	.btn-primary:hover,
	.btn-primary:focus {
		background: #075f88;
		border-color: #075f88;
	}
	.metric-grid {
		display: grid;
		grid-template-columns: repeat(4, minmax(0, 1fr));
		gap: 1rem;
		margin-bottom: 1.85rem;
	}
	.metric-card {
		background: #fff;
		border: 1px solid var(--line);
		border-radius: 13px;
		box-shadow: 0 2px 7px rgba(15, 35, 55, 0.12);
		padding: 1.35rem 1.4rem;
		min-height: 108px;
	}
	.metric-label {
		color: #526985;
		font-size: 0.88rem;
		font-weight: 600;
		margin-bottom: 0.25rem;
	}
	.metric-value {
		font-size: 2rem;
		line-height: 1;
		font-weight: 800;
		color: #020617;
	}
	.metric-value.red { color: var(--red); }
	.metric-value.purple { color: var(--purple); }
	.metric-value.orange { color: #d97706; }
	.search-box {
		position: relative;
		margin-bottom: 1rem;
	}
	.search-box i {
		position: absolute;
		left: 1rem;
		top: 50%;
		transform: translateY(-50%);
		color: #60758b;
		font-size: 1.1rem;
		pointer-events: none;
	}
	.search-box .form-control {
		padding-left: 2.9rem;
	}
	.form-control,
	.form-select {
		border-color: var(--line);
		border-radius: 10px;
		min-height: 45px;
		box-shadow: 0 2px 8px rgba(15, 35, 55, 0.04);
		font-weight: 600;
	}
	textarea.form-control { min-height: 76px; }
	.form-label {
		font-weight: 800;
		margin-bottom: 0.65rem;
	}
	.category-tabs {
		display: flex;
		flex-wrap: wrap;
		gap: 0.35rem;
		margin-bottom: 5.8rem;
	}
	.category-tab {
		border: 1px solid var(--line);
		background: #fff;
		color: #536b83;
		border-radius: 9px;
		padding: 0.55rem 1rem;
		font-weight: 800;
	}
	.category-tab.active {
		background: var(--brand);
		border-color: var(--brand);
		color: #fff;
	}
	.screening-list {
		display: grid;
		gap: 0.85rem;
	}
	.screening-card {
		background: #fff;
		border: 1px solid var(--line);
		border-radius: 13px;
		box-shadow: 0 2px 7px rgba(15, 35, 55, 0.09);
		padding: 1rem 1.15rem;
		display: grid;
		grid-template-columns: minmax(0, 1fr) auto;
		gap: 1rem;
		align-items: start;
	}
	.screening-title {
		font-weight: 800;
		margin-bottom: 0.2rem;
	}
	.screening-meta {
		color: var(--muted);
		font-size: 0.86rem;
	}
	.result-pill {
		border-radius: 999px;
		font-size: 0.76rem;
		font-weight: 800;
		padding: 0.36rem 0.75rem;
		background: #f8fafc;
		color: #334155;
	}
	.result-positive { background: #fee2e2; color: #b91c1c; }
	.result-negative { background: #dcfce7; color: #047857; }
	.result-referred { background: #fff7ed; color: #c2410c; }
	.empty-state {
		text-align: center;
		color: #526985;
		font-weight: 600;
		padding: 0.3rem 1rem 2rem;
	}
	.empty-state i {
		display: block;
		color: #c7d1dc;
		font-size: 3rem;
		margin-bottom: 0.6rem;
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
		top: 161px;
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
		height: 150px;
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
	.modal-backdrop.show { opacity: 0.78; }
	.modal-dialog { max-width: 720px; }
	.modal-content {
		border: 1px solid #b8c4d0;
		border-radius: 12px;
		box-shadow: 0 24px 60px rgba(0, 0, 0, 0.28);
	}
	.modal-header {
		border-bottom: 0;
		padding: 1.45rem 1.9rem 0.5rem;
	}
	.modal-title {
		font-size: 1.25rem;
		font-weight: 800;
	}
	.modal-body {
		padding: 1rem 1.9rem;
		max-height: 72vh;
		overflow-y: auto;
	}
	.modal-footer {
		border-top: 0;
		padding: 1rem 1.9rem 1.45rem;
	}
	.form-check-input {
		width: 20px;
		height: 20px;
		border-color: var(--brand);
	}
	@media (max-width: 1180px) {
		.metric-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
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
		.main-content { padding: 1.5rem 1rem 2rem; }
		.page-head {
			flex-direction: column;
			margin-bottom: 1.5rem;
		}
		.metric-grid { grid-template-columns: 1fr; }
		.category-tabs { margin-bottom: 2.5rem; }
		.screening-card { grid-template-columns: 1fr; }
		.modal-dialog { margin: 0.5rem; }
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
			<a href="capture-appointment" class="nav-item-link"><i class="bi bi-stethoscope"></i><span class="nav-label">Nurse Workspace</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-activity"></i><span class="nav-label">Visits Today</span></a>
			<a href="#" class="nav-item-link"><i class="bi bi-heart-pulse"></i><span class="nav-label">Vitals Overview</span></a>
			<a href="#" class="nav-item-link"><i class="bi bi-arrow-left-right"></i><span class="nav-label">Referrals</span></a>
			<a href="screening" class="nav-item-link active"><i class="bi bi-clipboard2-pulse"></i><span class="nav-label">Screening</span></a>
			<a href="health-education" class="nav-item-link"><i class="bi bi-book"></i><span class="nav-label">Health Education</span></a>
		</nav>
		<div class="sidebar-footer">
			<div class="role-switch">
				<a href="home"><i class="bi bi-stethoscope"></i> Nurse</a>
				<a href="doctor" class="active"><i class="bi bi-person-gear"></i> Doctor</a>
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
			<div class="page-head">
				<div>
					<h1 class="page-title">Screening Forms</h1>
					<p class="page-subtitle">TB, HIV, Maternal, Chronic Disease and more</p>
				</div>
				<button class="btn btn-primary px-4" type="button" data-bs-toggle="modal" data-bs-target="#screeningModal">
					<i class="bi bi-plus-lg me-2"></i> New Screening
				</button>
			</div>

			<section class="metric-grid" aria-label="Screening metrics">
				<div class="metric-card">
					<div class="metric-label">Total Screenings</div>
					<div class="metric-value" id="totalScreenings">0</div>
				</div>
				<div class="metric-card">
					<div class="metric-label">Positive Results</div>
					<div class="metric-value red" id="positiveResults">0</div>
				</div>
				<div class="metric-card">
					<div class="metric-label">Referred</div>
					<div class="metric-value purple" id="referredCount">0</div>
				</div>
				<div class="metric-card">
					<div class="metric-label">Follow-up Required</div>
					<div class="metric-value orange" id="followupCount">0</div>
				</div>
			</section>

			<div class="search-box">
				<i class="bi bi-search"></i>
				<input type="text" class="form-control" id="screeningSearch" placeholder="Search patient...">
			</div>

			<div class="category-tabs" role="tablist" aria-label="Screening categories">
				<button class="category-tab active" type="button" data-type="">All</button>
				<button class="category-tab" type="button" data-type="TB Screening">TB Screening</button>
				<button class="category-tab" type="button" data-type="HIV Screening">HIV Screening</button>
				<button class="category-tab" type="button" data-type="Maternal Health">Maternal Health</button>
				<button class="category-tab" type="button" data-type="Hypertension">Hypertension</button>
				<button class="category-tab" type="button" data-type="Diabetes">Diabetes</button>
				<button class="category-tab" type="button" data-type="Mental Health (PHQ-9)">Mental Health (PHQ-9)</button>
			</div>

			<section class="screening-list" id="screeningList" aria-live="polite"></section>
		</main>
	</div>

	<div class="modal fade" id="screeningModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="modal-title">New Screening</h2>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row g-4">
						<div class="col-12">
							<label class="form-label" for="patientSelect">Patient *</label>
							<select class="form-select" id="patientSelect">
								<option value="">Select patient</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="formType">Form Type *</label>
							<select class="form-select" id="formType">
								<option value="">Select type</option>
								<option>TB Screening</option>
								<option>HIV Screening</option>
								<option>Maternal Health</option>
								<option>Hypertension</option>
								<option>Diabetes</option>
								<option>Mental Health (PHQ-9)</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="screeningDate">Screening Date</label>
							<input type="date" class="form-control" id="screeningDate">
						</div>
						<div class="col-md-6">
							<label class="form-label" for="screeningResult">Result</label>
							<select class="form-select" id="screeningResult">
								<option value="">Select</option>
								<option>Negative</option>
								<option>Positive</option>
								<option>Referred</option>
								<option>Inconclusive</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="screenedBy">Screened By</label>
							<input type="text" class="form-control" id="screenedBy" placeholder="Clinician name">
						</div>
						<div class="col-12">
							<label class="form-label" for="actionTaken">Action Taken</label>
							<input type="text" class="form-control" id="actionTaken" placeholder="e.g. Referred for sputum test, initiated ART">
						</div>
						<div class="col-12">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="followupRequired">
								<label class="form-check-label fw-semibold ms-2" for="followupRequired">Follow-up required</label>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label" for="screeningNotes">Notes</label>
							<textarea class="form-control" id="screeningNotes" rows="3" placeholder="Additional notes..."></textarea>
						</div>
						<div class="col-12">
							<div id="screeningAlert" class="alert alert-warning d-none mb-0"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary px-4" id="saveScreeningBtn">Save Screening</button>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	var storageKey = "uhtScreenings";
	var screenings = [];
	var activeType = "";

	function escapeHtml(value) {
		return String(value == null ? "" : value)
			.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#039;");
	}

	function todayValue() {
		var now = new Date();
		now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
		return now.toISOString().slice(0, 10);
	}

	function loadScreenings() {
		try {
			screenings = JSON.parse(localStorage.getItem(storageKey) || "[]");
		} catch (error) {
			screenings = [];
		}
	}

	function saveScreenings() {
		localStorage.setItem(storageKey, JSON.stringify(screenings));
	}

	function resultClass(result) {
		var normalized = String(result || "").toLowerCase();
		if (normalized === "positive") return "result-positive";
		if (normalized === "negative") return "result-negative";
		if (normalized === "referred") return "result-referred";
		return "";
	}

	function updateMetrics() {
		document.getElementById("totalScreenings").textContent = screenings.length;
		document.getElementById("positiveResults").textContent = screenings.filter(function (item) { return item.result === "Positive"; }).length;
		document.getElementById("referredCount").textContent = screenings.filter(function (item) { return item.result === "Referred"; }).length;
		document.getElementById("followupCount").textContent = screenings.filter(function (item) { return item.followupRequired; }).length;
	}

	function renderScreenings() {
		var list = document.getElementById("screeningList");
		var query = document.getElementById("screeningSearch").value.trim().toLowerCase();
		var filtered = screenings.filter(function (item) {
			var matchesType = !activeType || item.formType === activeType;
			var matchesQuery = !query || String(item.patientName || "").toLowerCase().indexOf(query) >= 0;
			return matchesType && matchesQuery;
		});

		updateMetrics();
		list.innerHTML = "";
		if (!filtered.length) {
			list.innerHTML = "<div class=\"empty-state\"><i class=\"bi bi-clipboard2-pulse\"></i>No screenings found</div>";
			return;
		}

		filtered.forEach(function (item) {
			var card = document.createElement("article");
			card.className = "screening-card";
			card.innerHTML =
				"<div>" +
					"<div class=\"screening-title\">" + escapeHtml(item.patientName) + "</div>" +
					"<div class=\"screening-meta\">" + escapeHtml(item.formType) + " | " + escapeHtml(item.date) + "</div>" +
					"<div class=\"screening-meta\">Action: " + escapeHtml(item.actionTaken || "No action recorded") + "</div>" +
					(item.notes ? "<div class=\"screening-meta\">Notes: " + escapeHtml(item.notes) + "</div>" : "") +
				"</div>" +
				"<div class=\"text-end\">" +
					"<span class=\"result-pill " + resultClass(item.result) + "\">" + escapeHtml(item.result || "Not recorded") + "</span>" +
					(item.followupRequired ? "<div class=\"screening-meta mt-2\">Follow-up required</div>" : "") +
				"</div>";
			list.appendChild(card);
		});
	}

	function showAlert(message) {
		var alertEl = document.getElementById("screeningAlert");
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function clearAlert() {
		document.getElementById("screeningAlert").classList.add("d-none");
	}

	function resetForm() {
		document.getElementById("patientSelect").value = "";
		document.getElementById("formType").value = "";
		document.getElementById("screeningDate").value = todayValue();
		document.getElementById("screeningResult").value = "";
		document.getElementById("screenedBy").value = "";
		document.getElementById("actionTaken").value = "";
		document.getElementById("followupRequired").checked = false;
		document.getElementById("screeningNotes").value = "";
		clearAlert();
	}

	function loadPatients() {
		var select = document.getElementById("patientSelect");
		fetch("rest/patients/list?query=")
			.then(function (response) { return response.json(); })
			.then(function (data) {
				var patients = data.patients || [];
				select.innerHTML = "<option value=\"\">Select patient</option>" + patients.map(function (patient) {
					var name = patient.fullName || patient.idNumber || "Unnamed patient";
					return "<option value=\"" + escapeHtml(name) + "\">" + escapeHtml(name) + "</option>";
				}).join("");
			})
			.catch(function () {
				select.innerHTML = "<option value=\"\">Select patient</option>";
			});
	}

	document.getElementById("sidebarToggle").addEventListener("click", function () {
		if (window.matchMedia("(max-width: 880px)").matches) {
			document.body.classList.toggle("sidebar-open");
		} else {
			document.body.classList.toggle("sidebar-collapsed");
		}
	});

	document.getElementById("screeningSearch").addEventListener("input", renderScreenings);
	document.querySelectorAll(".category-tab").forEach(function (tab) {
		tab.addEventListener("click", function () {
			activeType = tab.getAttribute("data-type") || "";
			document.querySelectorAll(".category-tab").forEach(function (item) { item.classList.remove("active"); });
			tab.classList.add("active");
			renderScreenings();
		});
	});

	document.getElementById("saveScreeningBtn").addEventListener("click", function () {
		clearAlert();
		var patientName = document.getElementById("patientSelect").value;
		var formType = document.getElementById("formType").value;
		if (!patientName || !formType) {
			showAlert("Patient and form type are required.");
			return;
		}
		screenings.unshift({
			id: Date.now(),
			patientName: patientName,
			formType: formType,
			date: document.getElementById("screeningDate").value || todayValue(),
			result: document.getElementById("screeningResult").value,
			screenedBy: document.getElementById("screenedBy").value.trim(),
			actionTaken: document.getElementById("actionTaken").value.trim(),
			followupRequired: document.getElementById("followupRequired").checked,
			notes: document.getElementById("screeningNotes").value.trim()
		});
		saveScreenings();
		renderScreenings();
		bootstrap.Modal.getOrCreateInstance(document.getElementById("screeningModal")).hide();
		resetForm();
	});

	document.getElementById("screeningModal").addEventListener("show.bs.modal", function () {
		loadPatients();
		if (!document.getElementById("screeningDate").value) {
			document.getElementById("screeningDate").value = todayValue();
		}
	});

	loadScreenings();
	document.getElementById("screeningDate").value = todayValue();
	renderScreenings();
</script>
</body>
</html>
