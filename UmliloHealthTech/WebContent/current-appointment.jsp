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
						<label class="form-label">Assign Patient (ID number)</label>
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Enter patient ID">
							<button class="btn btn-outline-secondary" type="button">Find</button>
						</div>
					</div>
					<div class="col-md-3">
						<label class="form-label">Appointment Date</label>
						<input type="date" class="form-control">
					</div>
					<div class="col-md-2">
						<label class="form-label">Time</label>
						<input type="time" class="form-control">
					</div>
					<div class="col-md-2 d-flex align-items-end">
						<button class="btn btn-primary w-100">Create</button>
					</div>
					<div class="col-12">
						<label class="form-label">Appointment Notes</label>
						<textarea class="form-control" rows="2" placeholder="Reason for visit, quick notes"></textarea>
					</div>
				</div>
			</div>
		</div>

		<div class="card panel mb-4">
			<div class="card-body p-4">
				<h2 class="h5 section-label mb-3">Open Appointments</h2>
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
						<tbody>
							<tr>
								<td>Lerato Mokoena</td>
								<td>15 Mar 2026</td>
								<td><span class="badge bg-info text-dark">In Progress</span></td>
								<td><a href="capture-appointment.jsp" class="btn btn-sm btn-outline-primary">Capture</a></td>
							</tr>
							<tr>
								<td>Samuel Ndlovu</td>
								<td>15 Mar 2026</td>
								<td><span class="badge bg-warning text-dark">Waiting</span></td>
								<td><a href="capture-appointment.jsp" class="btn btn-sm btn-outline-primary">Capture</a></td>
							</tr>
							<tr>
								<td>Nandi Khumalo</td>
								<td>15 Mar 2026</td>
								<td><span class="badge bg-secondary">Pending</span></td>
								<td><a href="capture-appointment.jsp" class="btn btn-sm btn-outline-primary">Capture</a></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
