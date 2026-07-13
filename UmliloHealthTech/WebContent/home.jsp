<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Nurse Dashboard</title>
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
		--purple: #a855f7;
		--sidebar: #0d1b27;
		--sidebar-soft: #172a3d;
	}
	* {
		box-sizing: border-box;
	}
	body {
		margin: 0;
		background: var(--page);
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	a {
		color: inherit;
	}
	.app-shell {
		min-height: 100vh;
		padding-right: 326px;
		transition: padding-right 0.2s ease;
	}
	body.sidebar-collapsed .app-shell {
		padding-right: 92px;
	}
	.topbar {
		height: 72px;
		background: #ffffff;
		border-bottom: 1px solid var(--line);
		display: flex;
		align-items: center;
		justify-content: flex-end;
		padding: 0 2.35rem;
		gap: 1rem;
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
		.notification-count.is-empty {
			display: none;
		}
	.main-content {
		padding: 2.85rem 2.35rem;
		max-width: 1180px;
	}
	.page-title {
		font-size: clamp(1.6rem, 1.35rem + 1vw, 2rem);
		font-weight: 800;
		margin: 0 0 0.35rem;
	}
	.page-subtitle {
		color: var(--muted);
		font-size: 1rem;
		margin: 0;
	}
	.role-pill {
		border: 1px solid #b8d7e9;
		background: #e9f5fb;
		color: #0879ad;
		border-radius: 999px;
		font-weight: 800;
		padding: 0.55rem 1rem;
		display: inline-flex;
		align-items: center;
		gap: 0.5rem;
	}
	.profile-panel,
	.metric-card,
	.content-panel {
		background: var(--panel);
		border: 1px solid var(--line);
		box-shadow: 0 10px 24px rgba(15, 35, 55, 0.08);
	}
	.profile-panel {
		background: #eef7fb;
		border-color: #b9d9ea;
		border-radius: 16px;
		padding: 1.25rem 1.55rem;
		display: flex;
		align-items: center;
		gap: 1.1rem;
	}
	.avatar {
		width: 52px;
		height: 52px;
		border-radius: 50%;
		background: var(--brand);
		color: #fff;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		font-weight: 800;
		flex: 0 0 auto;
	}
	.profile-name {
		font-size: 1.05rem;
		font-weight: 800;
		margin-bottom: 0.1rem;
	}
	.profile-meta {
		color: #5f7890;
		font-size: 0.92rem;
	}
	.metrics-grid {
		display: grid;
		grid-template-columns: repeat(4, minmax(0, 1fr));
		gap: 1.25rem;
	}
	.metric-card {
		border-radius: 14px;
		padding: 1.55rem 1.6rem;
		min-height: 166px;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
	}
	.metric-top {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		gap: 1rem;
	}
	.metric-label {
		color: #526985;
		font-size: 0.78rem;
		font-weight: 800;
		letter-spacing: 0.08em;
		text-transform: uppercase;
		line-height: 1.5;
	}
	.metric-icon,
	.action-icon,
	.patient-avatar {
		width: 50px;
		height: 50px;
		border-radius: 16px;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		color: #fff;
		flex: 0 0 auto;
	}
	.metric-icon {
		font-size: 1.55rem;
	}
	.metric-value {
		font-size: 1.9rem;
		font-weight: 800;
		line-height: 1;
		margin: 0.85rem 0 0.55rem;
	}
	.metric-note {
		color: #059669;
		font-size: 0.9rem;
		margin: 0;
	}
	.note-danger {
		color: #ef4444;
	}
	.bg-brand { background: var(--brand); }
	.bg-blue { background: var(--blue); }
	.bg-orange { background: var(--orange); }
	.bg-purple { background: var(--purple); }
	.bg-teal { background: var(--teal); }
	.dashboard-lower {
		display: grid;
		grid-template-columns: minmax(280px, 0.75fr) minmax(420px, 1.55fr);
		gap: 1.25rem;
	}
	.content-panel {
		border-radius: 14px;
		padding: 1.65rem;
	}
	.panel-header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 1rem;
		margin-bottom: 1.35rem;
	}
	.panel-title {
		font-size: 1.1rem;
		font-weight: 800;
		margin: 0;
	}
	.action-grid {
		display: grid;
		grid-template-columns: repeat(2, minmax(0, 1fr));
		gap: 1rem;
	}
	.action-card {
		border: 1px solid var(--line);
		border-radius: 13px;
		min-height: 112px;
		padding: 1rem;
		display: flex;
		gap: 0.9rem;
		text-decoration: none;
		background: #ffffff;
		transition: transform 0.18s ease, border-color 0.18s ease, box-shadow 0.18s ease;
	}
	.action-card:hover {
		transform: translateY(-2px);
		border-color: #b9d9ea;
		box-shadow: 0 12px 22px rgba(15, 35, 55, 0.08);
	}
	.action-title {
		font-weight: 800;
		line-height: 1.2;
		margin-bottom: 0.25rem;
	}
	.action-copy {
		color: var(--muted);
		font-size: 0.9rem;
		margin: 0;
	}
	.patient-list {
		border-top: 1px solid var(--line);
	}
	.patient-row {
		display: grid;
		grid-template-columns: auto minmax(0, 1fr) auto;
		align-items: center;
		gap: 1rem;
		padding: 1rem 0;
		border-bottom: 1px solid var(--line);
	}
	.patient-avatar {
		width: 42px;
		height: 42px;
		border-radius: 50%;
		background: #e7f1f6;
		color: var(--brand);
		font-size: 0.78rem;
		font-weight: 800;
	}
	.patient-name {
		font-weight: 800;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.patient-id,
		.patient-date {
			color: var(--muted);
			font-size: 0.88rem;
		}
		.patient-action {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			gap: 0.35rem;
			border-radius: 7px;
			background: #dff0fa;
			color: #0879ad;
			text-decoration: none;
			font-size: 0.76rem;
			font-weight: 800;
			padding: 0.36rem 0.62rem;
			margin-top: 0.55rem;
		}
		.patient-action:hover {
			background: #c8e6f3;
			color: #075f88;
		}
		.patient-status {
			background: #dcfce7;
			border: 1px solid #86efac;
		color: #047857;
		border-radius: 999px;
		padding: 0.32rem 0.8rem;
		font-size: 0.78rem;
		font-weight: 800;
	}
	.empty-state {
		color: var(--muted);
		padding: 1.25rem 0 0.25rem;
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
	body.sidebar-collapsed .sidebar {
		width: 92px;
	}
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
		display: inline-flex;
		align-items: center;
		justify-content: center;
		flex: 0 0 auto;
		overflow: hidden;
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
	@media (max-width: 1180px) {
		.metrics-grid {
			grid-template-columns: repeat(2, minmax(0, 1fr));
		}
		.dashboard-lower {
			grid-template-columns: 1fr;
		}
	}
	@media (max-width: 880px) {
		.app-shell,
		body.sidebar-collapsed .app-shell {
			padding-right: 0;
		}
		.sidebar,
		body.sidebar-collapsed .sidebar {
			width: min(86vw, 326px);
			transform: translateX(100%);
		}
		body.sidebar-open .sidebar {
			transform: translateX(0);
		}
		.sidebar-toggle {
			left: -44px;
			top: 18px;
			width: 38px;
			height: 38px;
		}
		.topbar {
			padding: 0 1rem;
		}
		.main-content {
			padding: 1.5rem 1rem 2rem;
		}
		.metrics-grid,
		.action-grid {
			grid-template-columns: 1fr;
		}
		.patient-row {
			grid-template-columns: auto minmax(0, 1fr);
		}
		.patient-date {
			grid-column: 2;
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
			<div class="brand-mark">
				<img src="img/uht_bg.png" alt="Umlilo HealthTech logo">
			</div>
			<div class="brand-copy">
				<div class="brand-title">Umlilo Health</div>
				<div class="brand-subtitle">Technologies</div>
			</div>
		</div>
		<nav class="nav-menu">
			<a href="home" class="nav-item-link active"><i class="bi bi-grid"></i><span class="nav-label">Dashboard</span></a>
			<a href="appointment" class="nav-item-link"><i class="bi bi-people"></i><span class="nav-label">Patients</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-diagram-3"></i><span class="nav-label">Patient Flow</span></a>
			<a href="capture-appointment" class="nav-item-link"><i class="bi bi-stethoscope"></i><span class="nav-label">Nurse Workspace</span></a>
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
				<button class="notification" id="notificationBtn" type="button" aria-label="Open today's visits">
					<i class="bi bi-bell"></i>
					<span class="notification-count is-empty" id="notificationCount">0</span>
				</button>
		</header>

		<main class="main-content">
			<div class="d-flex flex-column flex-lg-row align-items-lg-end justify-content-between gap-3 mb-4">
				<div>
					<h1 class="page-title">Dashboard</h1>
					<p class="page-subtitle">Umlilo Health Technologies - Electronic Health Records Overview</p>
				</div>
				<span class="role-pill"><i class="bi bi-stethoscope"></i> Nurse</span>
			</div>

			<section class="profile-panel mb-4">
				<div class="avatar" id="nurseInitials">N</div>
				<div>
					<div class="profile-name" id="nurseName">Nurse</div>
					<div class="profile-meta">Registered Nurse</div>
					<div class="profile-meta">Primary Care and Patient Intake</div>
				</div>
			</section>

			<section class="metrics-grid mb-4" aria-label="Dashboard metrics">
					<div class="metric-card">
						<div class="metric-top">
							<div class="metric-label">Patients Captured Today</div>
							<div class="metric-icon bg-brand"><i class="bi bi-person-plus"></i></div>
						</div>
						<div>
							<div class="metric-value" id="patientsCapturedTodayCount">0</div>
							<p class="metric-note">New records opened</p>
						</div>
					</div>
					<div class="metric-card">
						<div class="metric-top">
							<div class="metric-label">Total Patients</div>
							<div class="metric-icon bg-blue"><i class="bi bi-people"></i></div>
						</div>
						<div>
							<div class="metric-value" id="totalPatientsCount">0</div>
							<p class="metric-note">Records in the system</p>
						</div>
					</div>
					<div class="metric-card">
						<div class="metric-top">
							<div class="metric-label">Active Prescriptions</div>
							<div class="metric-icon bg-orange"><i class="bi bi-capsule"></i></div>
						</div>
						<div>
							<div class="metric-value" id="activePrescriptionsCount">0</div>
							<p class="metric-note">Medication items recorded</p>
						</div>
					</div>
				<div class="metric-card">
					<div class="metric-top">
						<div class="metric-label">Visits Today</div>
						<div class="metric-icon bg-purple"><i class="bi bi-activity"></i></div>
					</div>
					<div>
						<div class="metric-value" id="visitsTodayCount">0</div>
						<p class="metric-note">Total scheduled</p>
					</div>
				</div>
			</section>

			<section class="dashboard-lower">
					<div class="content-panel">
						<div class="panel-header">
							<h2 class="panel-title">Quick Actions</h2>
						</div>
						<div class="action-grid">
							<a href="patient" class="action-card">
								<span class="action-icon bg-brand"><i class="bi bi-person-plus"></i></span>
								<span>
									<span class="action-title d-block">Register Patient</span>
									<span class="action-copy">Capture a new patient record</span>
								</span>
							</a>
							<a href="appointment" class="action-card">
								<span class="action-icon bg-blue"><i class="bi bi-search"></i></span>
								<span>
									<span class="action-title d-block">Look Up Records</span>
									<span class="action-copy">Search patients and histories</span>
								</span>
							</a>
							<a href="capture-appointment?tab=book" class="action-card">
								<span class="action-icon bg-orange"><i class="bi bi-calendar2-plus"></i></span>
								<span>
									<span class="action-title d-block">Book Appointment</span>
									<span class="action-copy">Schedule a patient visit</span>
								</span>
							</a>
							<a href="current-appointment" class="action-card">
								<span class="action-icon bg-teal"><i class="bi bi-diagram-3"></i></span>
								<span>
									<span class="action-title d-block">Patient Flow</span>
									<span class="action-copy">Track today's care stages</span>
								</span>
							</a>
						</div>
				</div>

				<div class="content-panel">
					<div class="panel-header">
						<h2 class="panel-title">Recent Patients</h2>
						<a href="appointment" class="fw-bold text-decoration-none">View All <i class="bi bi-arrow-right"></i></a>
					</div>
					<div class="patient-list" id="recentPatientsList">
						<div class="empty-state">Loading recent patients...</div>
					</div>
				</div>
			</section>
		</main>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	function setText(id, value) {
		var element = document.getElementById(id);
		if (element) element.textContent = value;
	}

	function initialsFromName(name) {
		if (!name) return "N";
		var parts = name.trim().split(/\s+/).filter(Boolean);
		if (!parts.length) return "N";
		return parts.slice(0, 2).map(function (part) { return part.charAt(0).toUpperCase(); }).join("");
	}

		function statusLabel(status) {
			if (!status) return "Active";
			return status.replace(/_/g, " ").toLowerCase().replace(/\b\w/g, function (letter) {
				return letter.toUpperCase();
			});
		}

		function escapeHtml(value) {
			return String(value == null ? "" : value)
				.replace(/&/g, "&amp;")
				.replace(/</g, "&lt;")
				.replace(/>/g, "&gt;")
				.replace(/"/g, "&quot;")
				.replace(/'/g, "&#039;");
		}

	function renderRecentPatients(patients) {
		var list = document.getElementById("recentPatientsList");
		list.innerHTML = "";
		if (!patients || !patients.length) {
			list.innerHTML = "<div class=\"empty-state\">No recent patient visits found for today.</div>";
			return;
		}

			patients.slice(0, 6).forEach(function (patient) {
				var name = patient.patientName || "Unnamed Patient";
				var appointmentHref = patient.appointmentId ? "capture-appointment?appointmentId=" + encodeURIComponent(patient.appointmentId) : "visits-today";
				var row = document.createElement("div");
				row.className = "patient-row";
				row.innerHTML =
					"<div class=\"patient-avatar\">" + escapeHtml(initialsFromName(name)) + "</div>" +
					"<div>" +
						"<div class=\"patient-name\">" + escapeHtml(name) + "</div>" +
						"<div class=\"patient-id\">ID: " + escapeHtml(patient.idNumber || "-") + "</div>" +
					"</div>" +
					"<div class=\"text-end\">" +
						"<div class=\"patient-status\">" + escapeHtml(statusLabel(patient.status)) + "</div>" +
						"<div class=\"patient-date mt-2\">" + escapeHtml(patient.dateOfVisit || "-") + "</div>" +
						"<a class=\"patient-action\" href=\"" + appointmentHref + "\"><i class=\"bi bi-stethoscope\"></i> Open</a>" +
					"</div>";
				list.appendChild(row);
			});
	}

	function setDashboardFallback() {
		renderRecentPatients([]);
	}

		document.getElementById("sidebarToggle").addEventListener("click", function () {
			if (window.matchMedia("(max-width: 880px)").matches) {
				document.body.classList.toggle("sidebar-open");
			} else {
				document.body.classList.toggle("sidebar-collapsed");
			}
		});

		document.getElementById("notificationBtn").addEventListener("click", function () {
			window.location.href = "visits-today";
		});

	fetch("rest/patients/dashboard")
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
					var fullName = result.data.fullName || "Nurse";
					setText("nurseName", fullName);
					setText("nurseInitials", initialsFromName(fullName));
					setText("patientsCapturedTodayCount", result.data.patientsCapturedToday || 0);
					setText("totalPatientsCount", result.data.totalPatients || 0);
					setText("activePrescriptionsCount", result.data.activePrescriptions || 0);
						setText("visitsTodayCount", result.data.todaysAppointments || 0);
						setText("notificationCount", result.data.todaysAppointments || 0);
						document.getElementById("notificationCount").classList.toggle("is-empty", !result.data.todaysAppointments);
				renderRecentPatients(result.data.recentPatients || []);
			} else {
				setDashboardFallback();
			}
		})
		.catch(function () {
			setDashboardFallback();
		});
</script>
</body>
</html>
