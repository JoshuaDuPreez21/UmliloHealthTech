<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | New Patient</title>
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
	.section-card {
		border: none;
		border-radius: 18px;
		box-shadow: 0 14px 35px rgba(20, 35, 60, 0.08);
	}
	.section-title {
		font-weight: 600;
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
				<h1 class="h3 fw-bold mb-1">New Patient Health Profile</h1>
				<p class="text-muted mb-0">Capture personal information and illness history for first-time visits.</p>
			</div>
			<div class="badge bg-light text-dark border">Step 1 of 2</div>
		</div>

		<div class="alert alert-info">
			<strong>Consent required:</strong> Patient must agree to the privacy policy and digital record usage before saving.
			<button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#consentModal">View policy</button>
		</div>

		<div class="row g-4">
			<div class="col-lg-8">
				<div class="card section-card mb-4">
					<div class="card-body p-4">
						<h2 class="h5 section-title mb-3">Personal Information</h2>
						<form>
							<div class="row g-3">
								<div class="col-md-6">
									<label class="form-label">First Name</label>
									<input type="text" class="form-control" placeholder="Enter first name">
								</div>
								<div class="col-md-6">
									<label class="form-label">Surname</label>
									<input type="text" class="form-control" placeholder="Enter surname">
								</div>
								<div class="col-md-6">
									<label class="form-label">South African ID Number</label>
									<input type="text" class="form-control" placeholder="13-digit ID">
									<div class="form-text">Age and date of birth will be derived from the ID.</div>
								</div>
								<div class="col-md-6">
									<label class="form-label">Cellphone</label>
									<input type="text" class="form-control" placeholder="e.g. 072 123 4567">
								</div>
								<div class="col-md-6">
									<label class="form-label">Gender</label>
									<select class="form-select">
										<option selected>Choose...</option>
										<option>Female</option>
										<option>Male</option>
										<option>Other</option>
									</select>
								</div>
								<div class="col-md-6">
									<label class="form-label">Email</label>
									<input type="email" class="form-control" placeholder="name@email.com">
								</div>
								<div class="col-12">
									<label class="form-label">Residential Address</label>
									<input type="text" class="form-control" placeholder="Street, suburb, city">
								</div>
								<div class="col-md-6">
									<label class="form-label">Employment Status</label>
									<select class="form-select">
										<option selected>Select status</option>
										<option>Employed</option>
										<option>Unemployed</option>
										<option>Student</option>
										<option>Pensioner</option>
									</select>
								</div>
								<div class="col-md-6">
									<label class="form-label">Job Title</label>
									<input type="text" class="form-control" placeholder="Optional">
								</div>
								<div class="col-md-6">
									<label class="form-label">Next of Kin</label>
									<input type="text" class="form-control" placeholder="Name and relationship">
								</div>
								<div class="col-md-6">
									<label class="form-label">Emergency Contact</label>
									<input type="text" class="form-control" placeholder="Contact number">
								</div>
								<div class="col-12">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="citizenCheck">
										<label class="form-check-label" for="citizenCheck">Patient is not South African</label>
									</div>
								</div>
								<div class="col-md-6">
									<label class="form-label">Nationality</label>
									<input type="text" class="form-control" placeholder="Enter nationality">
								</div>
								<div class="col-md-6">
									<label class="form-label">Citizen ID / Passport</label>
									<input type="text" class="form-control" placeholder="Enter ID or passport number">
								</div>
							</div>
						</form>
					</div>
				</div>

				<div class="card section-card">
					<div class="card-body p-4">
						<h2 class="h5 section-title mb-3">Illness History</h2>
						<p class="text-muted">Select current and historical illnesses (multi-select).</p>
						<select class="form-select" multiple size="6">
							<option>Diabetes</option>
							<option>Hypertension</option>
							<option>Asthma</option>
							<option>HIV / AIDS</option>
							<option>Tuberculosis</option>
							<option>Heart Disease</option>
							<option>Kidney Disease</option>
							<option>Other (specify)</option>
						</select>
						<div class="mt-3">
							<label class="form-label">Additional Notes</label>
							<textarea class="form-control" rows="3" placeholder="Optional details"></textarea>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="card section-card mb-4">
					<div class="card-body p-4">
						<h3 class="h5 section-title">Patient Summary</h3>
						<p class="text-muted">Auto-filled from ID and form inputs.</p>
						<ul class="list-unstyled">
							<li><strong>Age:</strong> 34</li>
							<li><strong>Date of Birth:</strong> 1989-07-05</li>
							<li><strong>Gender:</strong> Female</li>
							<li><strong>Contact:</strong> 072 123 4567</li>
						</ul>
						<div class="alert alert-warning">
							Confirm consent before saving.
						</div>
						<button class="btn btn-primary w-100">Save Patient Profile</button>
					</div>
				</div>
				<div class="card section-card">
					<div class="card-body p-4">
						<h3 class="h5 section-title">Consent & Privacy</h3>
						<p class="text-muted">Digital record usage consent required.</p>
						<div class="form-check mb-3">
							<input class="form-check-input" type="checkbox" id="consentCheck">
							<label class="form-check-label" for="consentCheck">Patient consent captured</label>
						</div>
						<button class="btn btn-outline-secondary w-100" data-bs-toggle="modal" data-bs-target="#consentModal">Open Consent Form</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="consentModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Privacy Policy & Digital Records Consent</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<p>This facility collects and stores patient health data digitally for continuity of care.</p>
					<ul>
						<li>Only authorized staff may access records.</li>
						<li>Information is used for clinical care and reporting.</li>
						<li>Patients can request corrections to their records.</li>
					</ul>
					<p class="mb-0">By proceeding, the patient agrees to the digital record policy.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" data-bs-dismiss="modal">Confirm Consent</button>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", function () {
		var consentModal = new bootstrap.Modal(document.getElementById("consentModal"));
		consentModal.show();
	});
</script>
</body>
</html>
