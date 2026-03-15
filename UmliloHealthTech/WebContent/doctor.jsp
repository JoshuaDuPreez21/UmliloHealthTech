<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Doctor Dashboard</title>
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
	.badge-phase {
		background: #fbd38d;
		color: #4a2c0a;
		border-radius: 999px;
		padding: 0.35rem 0.7rem;
		font-size: 0.8rem;
	}
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
	}
	.btn-primary:hover {
		background: #0b2f30;
		border-color: #0b2f30;
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
		.panel .card-body {
			padding: 1.5rem;
		}
	}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top border-bottom bg-white">
		<div class="container py-2">
			<span class="fw-semibold">Umlilo HealthTech</span>
			<div class="d-flex align-items-center gap-3">
				<span class="text-muted">Doctor Portal</span>
				<a href="profile.jsp" class="btn btn-sm btn-outline-primary">My Profile</a>
				<a href="login.jsp" class="btn btn-sm btn-outline-secondary">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="hero mb-4">
			<div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center">
				<div>
					<span class="badge-phase">Master Data - Phase 1</span>
					<h1 class="display-6 fw-semibold mt-2 mb-1">Welcome, Dr. Naidoo</h1>
					<p class="mb-0">Review nurse notes, patient history, and sign off appointments.</p>
				</div>
				<div class="mt-3 mt-lg-0">
					<a href="appointment.jsp" class="btn btn-light me-2">Open Current Appointment</a>
					<button class="btn btn-outline-light">View Queue</button>
				</div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-4">
				<div class="card panel h-100">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">Today Summary</h3>
						<ul class="list-unstyled mb-0">
							<li class="mb-2"><strong>Appointments:</strong> 9</li>
							<li class="mb-2"><strong>Pending Sign-offs:</strong> 4</li>
							<li class="mb-2"><strong>Priority Reviews:</strong> 2</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-lg-8">
				<div class="card panel mb-4">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">Current Patient Snapshot</h3>
						<div class="row g-3">
							<div class="col-md-6">
								<div class="border rounded-3 p-3">
									<div class="text-muted">Patient</div>
									<div class="fw-semibold">Lerato Mokoena</div>
									<div class="text-muted">ID: 900101 1234 567</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="border rounded-3 p-3">
									<div class="text-muted">Nurse Notes</div>
									<div class="fw-semibold">Vitals stable, flu-like symptoms.</div>
									<div class="text-muted">Prescription draft ready.</div>
								</div>
							</div>
						</div>
						<div class="d-flex flex-wrap gap-2 mt-3">
							<a href="appointment.jsp" class="btn btn-primary">Review & Sign Off</a>
							<button class="btn btn-outline-secondary">View History</button>
						</div>
					</div>
				</div>

				<div class="card panel">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">Appointment Queue</h3>
						<div class="table-responsive">
							<table class="table align-middle mb-0">
								<thead>
									<tr>
										<th>Patient</th>
										<th>Status</th>
										<th>Last Note</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Lerato Mokoena</td>
										<td><span class="badge bg-warning text-dark">Awaiting Sign-off</span></td>
										<td>Flu symptoms</td>
										<td><a href="appointment.jsp" class="btn btn-sm btn-outline-primary">Open</a></td>
									</tr>
									<tr>
										<td>Samuel Ndlovu</td>
										<td><span class="badge bg-success">Reviewed</span></td>
										<td>Blood pressure check</td>
										<td><button class="btn btn-sm btn-outline-secondary">View</button></td>
									</tr>
									<tr>
										<td>Nandi Khumalo</td>
										<td><span class="badge bg-info text-dark">In Review</span></td>
										<td>Asthma follow-up</td>
										<td><button class="btn btn-sm btn-outline-secondary">Open</button></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
