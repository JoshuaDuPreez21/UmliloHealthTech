<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
	:root {
		--ink: #0f172a;
		--brand: #1b7a6d;
		--brand-soft: #e7f3f1;
		--accent: #f4b400;
		--coral: #f9735b;
		--blue: #2563eb;
		--violet: #7c3aed;
		--surface: #ffffff;
		--muted: #667085;
	}
	body {
		background: linear-gradient(135deg, #f7fafc 0%, #eef6f4 44%, #fff7e5 100%);
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	.hero {
		background:
			linear-gradient(135deg, rgba(27, 122, 109, 0.96), rgba(37, 99, 235, 0.86)),
			url("img/uht_bg.png");
		background-position: center;
		background-size: cover;
		color: #fff;
		border-radius: 22px;
		padding: 2.25rem;
		box-shadow: 0 18px 45px rgba(15, 61, 62, 0.22);
		position: relative;
		overflow: hidden;
	}
	.hero h1 {
		font-size: clamp(1.6rem, 1.2rem + 1.6vw, 2.4rem);
	}
	.hero .btn {
		border-radius: 12px;
		font-weight: 700;
	}
	.card-action {
		border: none;
		border-radius: 16px;
		box-shadow: 0 14px 35px rgba(20, 35, 60, 0.1);
		transition: transform 0.2s ease, box-shadow 0.2s ease;
		overflow: hidden;
	}
	.card-action:hover {
		transform: translateY(-4px);
		box-shadow: 0 20px 45px rgba(20, 35, 60, 0.12);
	}
	.tile-strip {
		height: 6px;
	}
	.navbar {
		background: #ffffffcc;
		backdrop-filter: blur(8px);
	}
	.home-kicker {
		background: rgba(255, 255, 255, 0.18);
		border: 1px solid rgba(255, 255, 255, 0.32);
		border-radius: 999px;
		display: inline-flex;
		padding: 0.35rem 0.75rem;
		font-size: 0.82rem;
		font-weight: 700;
	}
	.tile-icon {
		width: 48px;
		height: 48px;
		border-radius: 14px;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		color: #fff;
		font-weight: 800;
		font-size: 1.1rem;
	}
	.tile-count {
		font-size: clamp(2rem, 1.5rem + 1.2vw, 2.8rem);
		font-weight: 800;
		line-height: 1;
	}
	.tile-label {
		color: var(--muted);
		font-size: 0.92rem;
	}
	.support-panel {
		border: 1px solid #e6eef5;
		border-radius: 16px;
		background: rgba(255, 255, 255, 0.86);
		box-shadow: 0 12px 28px rgba(20, 35, 60, 0.07);
	}
	@media (max-width: 992px) {
		.hero {
			padding: 1.5rem;
		}
	}
	@media (max-width: 768px) {
		.hero {
			padding: 1.25rem;
		}
	}
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
	}
	.btn-primary:hover {
		background: #0b2f30;
		border-color: #0b2f30;
	}
	.btn-outline-primary {
		border-color: var(--brand);
		color: var(--brand);
	}
	.btn-outline-primary:hover {
		background: var(--brand);
		border-color: var(--brand);
		color: #fff;
	}
	.bg-brand { background: var(--brand); }
	.bg-coral { background: var(--coral); }
	.bg-blue { background: var(--blue); }
	.text-brand { color: var(--brand); }
	.text-coral { color: var(--coral); }
	.text-blue { color: var(--blue); }
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top border-bottom">
		<div class="container py-2">
			<span class="fw-semibold">Umlilo HealthTech</span>
			<div class="d-flex align-items-center gap-3">
				<span class="text-muted">Nurse Portal</span>
				<a href="profile" class="btn btn-sm btn-outline-primary">My Profile</a>
				<a href="logout" class="btn btn-sm btn-outline-secondary">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="hero mb-4">
			<div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center">
				<div>
					<div class="home-kicker mb-3">Nurse workspace</div>
					<h1 class="display-6 fw-semibold mb-2">Welcome back, <span id="nurseName">Nurse</span></h1>
					<p class="mb-0">Start a patient profile, find a record, or open today's appointments from one calm place.</p>
				</div>
				<div class="mt-4 mt-lg-0 d-flex flex-wrap gap-2">
					<a href="patient" class="btn btn-light">New Patient</a>
					<a href="current-appointment" class="btn btn-outline-light">Open Appointments</a>
				</div>
			</div>
		</div>

		<div class="row g-3 mb-4">
			<div class="col-lg-8">
				<div class="support-panel p-3 p-lg-4 h-100">
					<div class="d-flex flex-column flex-md-row justify-content-between gap-3">
						<div>
							<h2 class="h5 fw-bold mb-1">Today's focus</h2>
							<p class="text-muted mb-0">Use the cards below to keep intake, search, and appointment work moving.</p>
						</div>
						<div class="d-flex align-items-center gap-2">
							<span class="badge rounded-pill text-bg-light border">Session active</span>
							<span class="badge rounded-pill text-bg-warning">30 min timeout</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="support-panel p-3 p-lg-4 h-100">
					<div class="text-muted small">Last refreshed</div>
					<div class="fw-bold" id="lastRefreshed">Loading dashboard...</div>
				</div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-md-6 col-lg-4">
				<div class="card card-action h-100">
					<div class="tile-strip bg-coral"></div>
					<div class="card-body p-4">
						<div class="d-flex justify-content-between align-items-start mb-3">
							<div class="tile-icon bg-coral">NP</div>
							<div class="tile-count text-coral" id="patientsTodayCount">0</div>
						</div>
						<h3 class="h5 fw-semibold">New Patient Profile</h3>
						<div class="tile-label mb-3">Patients captured today</div>
						<p class="text-muted">Capture personal information and initial health profile.</p>
						<a href="patient" class="btn btn-primary w-100">Start Capture</a>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-4">
				<div class="card card-action h-100">
					<div class="tile-strip bg-blue"></div>
					<div class="card-body p-4">
						<div class="d-flex justify-content-between align-items-start mb-3">
							<div class="tile-icon bg-blue">SP</div>
							<div class="tile-count text-blue" id="totalPatientsCount">0</div>
						</div>
						<h3 class="h5 fw-semibold">Search Patient</h3>
						<div class="tile-label mb-3">Registered patient records</div>
						<p class="text-muted">Find an existing patient and open their appointment record.</p>
						<a href="appointment" class="btn btn-primary w-100">Search Patient</a>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-4">
				<div class="card card-action h-100">
					<div class="tile-strip bg-brand"></div>
					<div class="card-body p-4">
						<div class="d-flex justify-content-between align-items-start mb-3">
							<div class="tile-icon bg-brand">CA</div>
							<div class="tile-count text-brand" id="appointmentsTodayCount">0</div>
						</div>
						<h3 class="h5 fw-semibold">Current Appointment</h3>
						<div class="tile-label mb-3">Appointments assigned to you today</div>
						<p class="text-muted">Create appointments, update status, and add nurse notes.</p>
						<a href="current-appointment" class="btn btn-primary w-100">Open Appointment</a>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	function setText(id, value) {
		var element = document.getElementById(id);
		if (element) element.textContent = value;
	}

	function setDashboardFallback() {
		setText("lastRefreshed", "Unable to load live counts");
	}

	fetch("rest/patients/dashboard")
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				setText("nurseName", result.data.fullName || "Nurse");
				setText("patientsTodayCount", result.data.patientsCapturedToday || 0);
				setText("totalPatientsCount", result.data.totalPatients || 0);
				setText("appointmentsTodayCount", result.data.todaysAppointments || 0);
				setText("lastRefreshed", new Date().toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" }));
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
