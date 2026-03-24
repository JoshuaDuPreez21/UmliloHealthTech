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
		--surface: #ffffff;
		--muted: #667085;
	}
	body {
		background: radial-gradient(circle at top, #f7f9fb 0%, #eef3f7 45%, #e8eef5 100%);
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	.hero {
		background: var(--brand);
		color: #fff;
		border-radius: 24px;
		padding: 2rem;
		box-shadow: 0 18px 40px rgba(15, 61, 62, 0.2);
	}
	.hero h1 {
		font-size: clamp(1.6rem, 1.2rem + 1.6vw, 2.4rem);
	}
	.card-action {
		border: none;
		border-radius: 18px;
		box-shadow: 0 14px 35px rgba(20, 35, 60, 0.08);
		transition: transform 0.2s ease, box-shadow 0.2s ease;
	}
	.card-action:hover {
		transform: translateY(-4px);
		box-shadow: 0 20px 45px rgba(20, 35, 60, 0.12);
	}
	.badge-phase {
		background: #fbd38d;
		color: #4a2c0a;
		border-radius: 999px;
		padding: 0.35rem 0.7rem;
		font-size: 0.8rem;
	}
	.navbar {
		background: #ffffffcc;
		backdrop-filter: blur(8px);
	}
	.quick-stat {
		border: 1px solid #e6eef5;
		border-radius: 16px;
		padding: 1rem;
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
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top border-bottom">
		<div class="container py-2">
			<span class="fw-semibold">Umlilo HealthTech</span>
			<div class="d-flex align-items-center gap-3">
				<span class="text-muted">Nurse Portal</span>
				<a href="profile.jsp" class="btn btn-sm btn-outline-primary">My Profile</a>
				<a href="login.jsp" class="btn btn-sm btn-outline-secondary">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="hero mb-4">
			<div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center">
				<div>
					<h1 class="display-6 fw-semibold mt-2 mb-1">Welcome back, Nurse Thandi</h1>
					<p class="mb-0">Quick access to patient onboarding and appointment records.</p>
				</div>
				<div class="mt-3 mt-lg-0">
					<a href="current-appointment.jsp" class="btn btn-outline-light">Open Appointment</a>
				</div>
			</div>
		</div>

		<div class="row g-3 mb-4">
			<div class="col-md-4">
				<div class="quick-stat bg-white">
					<div class="text-muted">Patients Captured Today</div>
					<div class="h3 fw-bold mb-0">12</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="quick-stat bg-white">
					<div class="text-muted">Appointments Waiting</div>
					<div class="h3 fw-bold mb-0">7</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="quick-stat bg-white">
					<div class="text-muted">Consent Pending</div>
					<div class="h3 fw-bold mb-0">3</div>
				</div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-md-6 col-lg-4">
				<div class="card card-action h-100">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">New Patient Profile</h3>
						<p class="text-muted">Capture personal information and initial health profile.</p>
						<a href="patient.jsp" class="btn btn-primary">Start Capture</a>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-4">
				<div class="card card-action h-100">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">Search Patient</h3>
						<p class="text-muted">Find an existing patient and add appointment notes.</p>
						<a href="appointment.jsp" class="btn btn-primary">Search Patient</a>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-4">
				<div class="card card-action h-100">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">Current Appointment</h3>
						<p class="text-muted">Review nurse notes, prescriptions, and doctor sign-off.</p>
						<a href="current-appointment.jsp" class="btn btn-primary">Open Appointment</a>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
