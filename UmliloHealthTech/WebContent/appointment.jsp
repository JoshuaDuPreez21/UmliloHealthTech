<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Appointment Record</title>
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
				<h1 class="h3 fw-bold mb-1">Appointment & Clinical Notes</h1>
				<p class="text-muted mb-0">Capture nurse notes, prescriptions, and doctor sign-off.</p>
			</div>
			<div class="badge bg-light text-dark border">Current Appointment</div>
		</div>

		<div class="card panel mb-4">
			<div class="card-body p-4">
				<h2 class="h5 section-label mb-3">Lookup Existing Patient</h2>
				<div class="row g-3 align-items-end">
					<div class="col-md-6">
						<label class="form-label">Patient ID Number</label>
						<input type="text" class="form-control" placeholder="Enter ID to search">
					</div>
					<div class="col-md-3">
						<label class="form-label">Appointment Date</label>
						<input type="date" class="form-control">
					</div>
					<div class="col-md-3">
						<button class="btn btn-primary w-100">Search</button>
					</div>
				</div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-4">
				<div class="card panel h-100">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Patient Overview</h3>
						<ul class="list-unstyled mb-3">
							<li><strong>Name:</strong> Lerato Mokoena</li>
							<li><strong>ID:</strong> 900101 1234 567</li>
							<li><strong>Cell:</strong> 071 555 9876</li>
							<li><strong>Next of Kin:</strong> K. Mokoena</li>
						</ul>
						<div class="alert alert-info">
							Current appointment: 13 Mar 2026
						</div>
						<button class="btn btn-outline-secondary w-100">View Full Profile</button>
					</div>
				</div>
			</div>

			<div class="col-lg-8">
				<div class="card panel mb-4">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Nurse Notes & Prescription</h3>
						<div class="row g-3">
							<div class="col-md-6">
								<label class="form-label">Nurse Notes</label>
								<textarea class="form-control" rows="4" placeholder="Record vitals, symptoms, observations"></textarea>
							</div>
							<div class="col-md-6">
								<label class="form-label">Prescription</label>
								<textarea class="form-control" rows="4" placeholder="Medication details"></textarea>
							</div>
							<div class="col-12">
								<label class="form-label">Additional Notes</label>
								<textarea class="form-control" rows="2" placeholder="Optional"></textarea>
							</div>
						</div>
						<div class="d-flex flex-wrap gap-2 mt-3">
							<button class="btn btn-primary">Save Nurse Notes</button>
							<button class="btn btn-outline-primary">Attach Files</button>
						</div>
					</div>
				</div>

				<div class="card panel mb-4">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Doctor Sign-Off</h3>
						<p class="text-muted">Doctor reviews nurse notes, patient info, and previous prescriptions before signing off.</p>
						<div class="row g-3">
							<div class="col-12">
								<label class="form-label">Doctor Notes</label>
								<textarea class="form-control" rows="3" placeholder="Clinical assessment and plan"></textarea>
							</div>
							<div class="col-md-6">
								<label class="form-label">Doctor ID</label>
								<input type="text" class="form-control" placeholder="Verified doctor ID">
							</div>
							<div class="col-md-6">
								<label class="form-label">OTP Verification</label>
								<div class="input-group">
									<input type="text" class="form-control" placeholder="6-digit OTP">
									<button class="btn btn-outline-secondary">Send OTP</button>
								</div>
							</div>
						</div>
						<div class="d-flex flex-wrap gap-2 mt-3">
							<button class="btn btn-success">Save & Sign Off</button>
							<button class="btn btn-outline-secondary">Return to Menu</button>
						</div>
					</div>
				</div>

				<div class="card panel">
					<div class="card-body p-4">
						<h3 class="h5 section-label">Existing Digital Records</h3>
						<div class="timeline-item">
							<p class="mb-1"><strong>12 Feb 2026</strong> - Flu symptoms, paracetamol prescription.</p>
							<small class="text-muted">Nurse: K. Dlamini | Doctor: Dr. Naidoo</small>
						</div>
						<div class="timeline-item">
							<p class="mb-1"><strong>18 Jan 2026</strong> - Follow-up, blood pressure reviewed.</p>
							<small class="text-muted">Nurse: S. Maseko | Doctor: Dr. Patel</small>
						</div>
						<button class="btn btn-outline-primary mt-2">View All Records</button>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
