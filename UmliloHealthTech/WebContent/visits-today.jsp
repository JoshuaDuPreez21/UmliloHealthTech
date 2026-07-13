<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Visit Records</title>
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
		--blue: #2563eb;
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
		padding: 1.55rem 2.15rem 3rem;
		max-width: 1110px;
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
	.filters {
		display: flex;
		align-items: center;
		gap: 0.9rem;
		margin: 2rem 0 1.85rem;
	}
	.filter-icon {
		color: #60758b;
		font-size: 1.25rem;
	}
	.form-select {
		width: 200px;
		min-height: 45px;
		border: 1px solid var(--line);
		border-radius: 10px;
		box-shadow: 0 3px 10px rgba(15, 35, 55, 0.05);
		font-weight: 600;
	}
	.visit-list {
		display: grid;
		gap: 1rem;
	}
	.visit-card {
		background: var(--panel);
		border: 1px solid var(--line);
		border-radius: 14px;
		box-shadow: 0 2px 6px rgba(15, 35, 55, 0.12);
		padding: 1.35rem 1.35rem 1.25rem;
		display: grid;
		grid-template-columns: auto minmax(0, 1fr) auto;
		gap: 1rem;
		align-items: start;
	}
	.visit-icon {
		width: 46px;
		height: 46px;
		border-radius: 12px;
		background: #e7f3f9;
		color: var(--brand);
		display: inline-flex;
		align-items: center;
		justify-content: center;
		font-size: 1.25rem;
		flex: 0 0 auto;
	}
	.patient-line {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		gap: 0.55rem;
		margin-bottom: 0.2rem;
	}
	.patient-name {
		font-size: 1.02rem;
		font-weight: 800;
	}
	.assess-link {
		border: 0;
		border-radius: 5px;
		background: #dff0fa;
		color: #0879ad;
		font-size: 0.72rem;
		font-weight: 800;
		text-decoration: none;
		padding: 0.28rem 0.5rem;
		display: inline-flex;
		align-items: center;
		gap: 0.25rem;
	}
	.complaint {
		color: #5f7186;
		font-size: 0.9rem;
		margin-bottom: 0.65rem;
	}
	.chip-row {
		display: flex;
		flex-wrap: wrap;
		gap: 0.45rem;
		margin-bottom: 0.65rem;
	}
	.chip {
		display: inline-flex;
		align-items: center;
		border: 1px solid var(--line);
		background: #fff;
		border-radius: 8px;
		padding: 0.25rem 0.7rem;
		font-size: 0.75rem;
		font-weight: 800;
		color: #061427;
		line-height: 1.2;
	}
	.diagnosis {
		color: #526985;
		font-size: 0.88rem;
	}
	.visit-side {
		display: flex;
		flex-direction: column;
		align-items: flex-end;
		gap: 0.65rem;
		padding-top: 0.15rem;
		min-width: 150px;
	}
	.status-pill {
		border: 0;
		border-radius: 10px;
		font-size: 0.76rem;
		font-weight: 800;
		padding: 0.45rem 0.8rem;
		box-shadow: 0 5px 12px rgba(15, 35, 55, 0.08);
	}
	.status-waiting { background: #f8fafc; color: #111827; }
	.status-triage { background: #fff7ed; color: #c2410c; }
	.status-consultation { background: #eef4ff; color: #1d4ed8; }
	.status-completed { background: #ecfdf5; color: #047857; }
	.visit-time {
		color: #526985;
		font-size: 0.78rem;
		white-space: nowrap;
		display: inline-flex;
		align-items: center;
		gap: 0.35rem;
	}
	.empty-state {
		background: #fff;
		border: 1px dashed var(--line);
		border-radius: 14px;
		color: var(--muted);
		padding: 1.4rem;
		font-weight: 700;
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
		.main-content { padding: 1.4rem 1rem 2rem; }
		.filters {
			align-items: stretch;
			flex-direction: column;
			margin: 1.45rem 0;
		}
		.form-select { width: 100%; }
		.visit-card {
			grid-template-columns: auto minmax(0, 1fr);
		}
		.visit-side {
			grid-column: 1 / -1;
			align-items: flex-start;
			min-width: 0;
			padding-left: 62px;
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
			<a href="appointment" class="nav-item-link"><i class="bi bi-people"></i><span class="nav-label">Patients</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-diagram-3"></i><span class="nav-label">Patient Flow</span></a>
			<a href="capture-appointment" class="nav-item-link"><i class="bi bi-stethoscope"></i><span class="nav-label">Nurse Workspace</span></a>
			<a href="visits-today" class="nav-item-link active"><i class="bi bi-activity"></i><span class="nav-label">Visits Today</span></a>
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
			<h1 class="page-title">Visit Records</h1>
			<p class="page-subtitle"><span id="visitCount">0</span> total visits</p>

			<section class="filters" aria-label="Visit filters">
				<i class="bi bi-funnel filter-icon" aria-hidden="true"></i>
				<select class="form-select" id="statusFilter" aria-label="Filter by status">
					<option value="">All Statuses</option>
				</select>
				<select class="form-select" id="departmentFilter" aria-label="Filter by department">
					<option value="">All Departments</option>
				</select>
			</section>

			<section class="visit-list" id="visitList" aria-live="polite">
				<div class="empty-state">Loading visit records...</div>
			</section>
		</main>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	var allVisits = [];

	function escapeHtml(value) {
		return String(value == null ? "" : value)
			.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#039;");
	}

	function titleCase(value) {
		return String(value || "")
			.replace(/_/g, " ")
			.toLowerCase()
			.replace(/\b\w/g, function (letter) { return letter.toUpperCase(); });
	}

	function getSummaryField(summary, label) {
		var escaped = label.replace(/[.*+?^\x24{}()|[\]\\]/g, "\\$&");
		var pattern = new RegExp(escaped + ":\\s*([^\\n]+)", "i");
		var match = pattern.exec(summary || "");
		return match ? match[1].trim() : "";
	}

	function firstValue(values) {
		for (var i = 0; i < values.length; i += 1) {
			if (values[i] != null && String(values[i]).trim()) {
				return String(values[i]).trim();
			}
		}
		return "";
	}

	function cleanSummary(summary) {
		if (!summary) return "";
		if (getSummaryField(summary, "Visit Type") || getSummaryField(summary, "Chief Complaint")) return "";
		return String(summary).trim();
	}

	function normalizeVisit(item) {
		var summary = item.visitSummary || "";
		var details = getSummaryField(summary, "Additional Details");
		return {
			id: item.id,
			patientName: item.patientName || "Unnamed Patient",
			dateTime: item.dateTime || "-",
			status: statusText(item.status || "WAITING"),
			visitType: firstValue([item.visitType, getSummaryField(summary, "Visit Type"), "Walk-in"]),
			department: firstValue([item.department, getSummaryField(summary, "Department"), "General"]),
			provider: firstValue([item.attendingProvider, getSummaryField(summary, "Attending Provider"), item.doctorName, item.nurseName, "Provider not assigned"]),
			complaint: firstValue([item.chiefComplaint, getSummaryField(summary, "Chief Complaint"), item.nurseNotes, cleanSummary(summary), "Clinical visit"]),
			diagnosis: firstValue([item.diagnosis, item.doctorSummary, item.additionalNotes, details, cleanSummary(summary), "Assessment pending"]),
			prescription: item.prescription || ""
		};
	}

	function statusClass(status) {
		var normalized = String(status || "").toLowerCase();
		if (normalized.indexOf("consult") >= 0 || normalized.indexOf("progress") >= 0) return "status-consultation";
		if (normalized.indexOf("triage") >= 0 || normalized.indexOf("pending") >= 0) return "status-triage";
		if (normalized.indexOf("complete") >= 0) return "status-completed";
		return "status-waiting";
	}

	function statusText(status) {
		var normalized = String(status || "").replace(/_/g, " ").trim().toLowerCase();
		if (!normalized || normalized === "new" || normalized === "waiting") return "Waiting";
		if (normalized === "pending" || normalized === "pending doctor" || normalized === "triage") return "Triage";
		if (normalized === "in progress" || normalized === "in consultation") return "In Consultation";
		if (normalized === "completed" || normalized === "complete") return "Completed";
		return titleCase(normalized);
	}

	function setVisitMessage(message) {
		document.getElementById("visitList").innerHTML = "<div class=\"empty-state\">" + escapeHtml(message) + "</div>";
	}

	function updateFilterOptions(visits) {
		var statusFilter = document.getElementById("statusFilter");
		var departmentFilter = document.getElementById("departmentFilter");
		var currentStatus = statusFilter.value;
		var currentDepartment = departmentFilter.value;
		var statuses = Array.from(new Set(visits.map(function (visit) { return visit.status; }))).sort();
		var departments = Array.from(new Set(visits.map(function (visit) { return visit.department; }))).sort();

		statusFilter.innerHTML = "<option value=\"\">All Statuses</option>" + statuses.map(function (status) {
			return "<option value=\"" + escapeHtml(status) + "\">" + escapeHtml(status) + "</option>";
		}).join("");
		departmentFilter.innerHTML = "<option value=\"\">All Departments</option>" + departments.map(function (department) {
			return "<option value=\"" + escapeHtml(department) + "\">" + escapeHtml(department) + "</option>";
		}).join("");
		statusFilter.value = statuses.indexOf(currentStatus) >= 0 ? currentStatus : "";
		departmentFilter.value = departments.indexOf(currentDepartment) >= 0 ? currentDepartment : "";
	}

	function renderVisits() {
		var list = document.getElementById("visitList");
		var statusValue = document.getElementById("statusFilter").value;
		var departmentValue = document.getElementById("departmentFilter").value;
		var filtered = allVisits.filter(function (visit) {
			return (!statusValue || visit.status === statusValue) &&
				(!departmentValue || visit.department === departmentValue);
		});

		document.getElementById("visitCount").textContent = allVisits.length;
		list.innerHTML = "";
		if (!filtered.length) {
			setVisitMessage(allVisits.length ? "No visit records match the selected filters." : "No visits scheduled for today.");
			return;
		}

		filtered.forEach(function (visit) {
			var status = visit.status;
			var card = document.createElement("article");
			card.className = "visit-card";
			card.innerHTML =
				"<div class=\"visit-icon\"><i class=\"bi bi-activity\"></i></div>" +
				"<div>" +
					"<div class=\"patient-line\">" +
						"<div class=\"patient-name\">" + escapeHtml(visit.patientName) + "</div>" +
						"<a class=\"assess-link\" href=\"capture-appointment?appointmentId=" + encodeURIComponent(visit.id) + "\"><i class=\"bi bi-stethoscope\"></i> Assess</a>" +
					"</div>" +
					"<div class=\"complaint\">" + escapeHtml(visit.complaint) + "</div>" +
					"<div class=\"chip-row\">" +
						"<span class=\"chip\">" + escapeHtml(visit.visitType) + "</span>" +
						"<span class=\"chip\">" + escapeHtml(visit.department) + "</span>" +
						"<span class=\"chip\">" + escapeHtml(visit.provider) + "</span>" +
					"</div>" +
					"<div class=\"diagnosis\">Dx: " + escapeHtml(visit.diagnosis) + "</div>" +
				"</div>" +
				"<div class=\"visit-side\">" +
					"<span class=\"status-pill " + statusClass(status) + "\">" + escapeHtml(status) + "</span>" +
					"<span class=\"visit-time\"><i class=\"bi bi-clock\"></i>" + escapeHtml(visit.dateTime) + "</span>" +
				"</div>";
			list.appendChild(card);
		});
	}

	document.getElementById("sidebarToggle").addEventListener("click", function () {
		if (window.matchMedia("(max-width: 880px)").matches) {
			document.body.classList.toggle("sidebar-open");
		} else {
			document.body.classList.toggle("sidebar-collapsed");
		}
	});

	document.getElementById("statusFilter").addEventListener("change", renderVisits);
	document.getElementById("departmentFilter").addEventListener("change", renderVisits);

	setVisitMessage("Loading visit records...");
	fetch("rest/appointments/today")
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				allVisits = (result.data.appointments || []).map(normalizeVisit);
				updateFilterOptions(allVisits);
				renderVisits();
			} else {
				allVisits = [];
				document.getElementById("visitCount").textContent = "0";
				updateFilterOptions(allVisits);
				setVisitMessage(result.data.message || "Unable to load visit records.");
			}
		})
		.catch(function () {
			allVisits = [];
			document.getElementById("visitCount").textContent = "0";
			updateFilterOptions(allVisits);
			setVisitMessage("Unable to load visit records. Please refresh and try again.");
		});
</script>
</body>
</html>
