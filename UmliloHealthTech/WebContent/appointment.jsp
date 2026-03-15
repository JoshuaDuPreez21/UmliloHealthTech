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
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top border-bottom bg-white">
		<div class="container py-2">
			<span class="fw-semibold">Umlilo HealthTech</span>
			<div class="d-flex align-items-center gap-3">
				<a href="home.jsp" class="btn btn-sm btn-outline-secondary">Back to Dashboard</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
			<div>
				<h1 class="page-title fw-bold mb-1">Search Patient by ID</h1>
				<p class="text-muted mb-0">Find a patient, view results, and check appointment history.</p>
			</div>
			<div class="badge bg-light text-dark border">Search</div>
		</div>

		<div class="card panel mb-4">
			<div class="card-body p-4">
				<h2 class="h5 section-label mb-3">Search Patient by ID</h2>
				<div class="row g-3 align-items-end">
					<div class="col-md-6">
						<label class="form-label">Patient ID Number</label>
						<input type="text" class="form-control" placeholder="Enter patient ID">
					</div>
					<div class="col-md-3">
						<label class="form-label">Search Option</label>
						<select class="form-select">
							<option selected>All records</option>
							<option>Open appointments</option>
							<option>Completed visits</option>
						</select>
					</div>
					<div class="col-md-3">
						<button class="btn btn-primary w-100">Search</button>
					</div>
				</div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-4">
				<div class="card panel mb-4">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Patient Result</h3>
						<ul class="list-unstyled mb-3">
							<li><strong>Name:</strong> Lerato Mokoena</li>
							<li><strong>ID:</strong> 900101 1234 567</li>
							<li><strong>Cell:</strong> 071 555 9876</li>
							<li><strong>Next of Kin:</strong> K. Mokoena</li>
						</ul>
						<button class="btn btn-outline-secondary w-100">Open Patient Profile</button>
					</div>
				</div>

				<div class="card panel">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Appointment History</h3>
						<div class="timeline-item">
							<p class="mb-1"><strong>12 Feb 2026</strong> - Flu symptoms, paracetamol prescription.</p>
							<small class="text-muted">Nurse: K. Dlamini | Doctor: Dr. Naidoo</small>
						</div>
						<div class="timeline-item">
							<p class="mb-1"><strong>18 Jan 2026</strong> - Follow-up, blood pressure reviewed.</p>
							<small class="text-muted">Nurse: S. Maseko | Doctor: Dr. Patel</small>
						</div>
						<button class="btn btn-outline-primary mt-2">View Full History</button>
					</div>
				</div>
			</div>

			<div class="col-lg-8">
				<div class="card panel">
					<div class="card-body p-4">
						<h3 class="h5 section-label mb-3">Open Appointment (if any)</h3>
						<p class="text-muted mb-3">Shows only when the patient has an active appointment.</p>
						<div class="border rounded-3 p-3">
							<div class="d-flex flex-wrap justify-content-between align-items-center">
								<div>
									<div class="fw-semibold">15 Mar 2026, 10:30</div>
									<div class="text-muted">Status: In Progress</div>
								</div>
								<a href="current-appointment.jsp" class="btn btn-outline-primary">Open</a>
							</div>
						</div>
						<div class="text-muted small mt-3">No open appointment? Create one from the Current Appointment page.</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
