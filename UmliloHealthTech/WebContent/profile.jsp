<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | My Profile</title>
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
	.page-title {
		font-size: clamp(1.4rem, 1.1rem + 1.4vw, 2rem);
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
				<a href="login.jsp" class="btn btn-sm btn-outline-secondary">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
			<div>
				<h1 class="page-title fw-bold mb-1">My Profile</h1>
				<p class="text-muted mb-0">Update your personal details and contact information.</p>
			</div>
			<div class="badge bg-light text-dark border">Staff Profile</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-8">
				<div class="card panel">
					<div class="card-body p-4">
						<h2 class="h5 fw-semibold mb-3">Profile Details</h2>
						<form>
							<div class="row g-3">
								<div class="col-md-6">
									<label class="form-label">First Name</label>
									<input type="text" class="form-control" value="Thandi">
								</div>
								<div class="col-md-6">
									<label class="form-label">Surname</label>
									<input type="text" class="form-control" value="Mthembu">
								</div>
								<div class="col-md-6">
									<label class="form-label">Staff ID</label>
									<input type="text" class="form-control" value="NUR-1024" disabled>
								</div>
								<div class="col-md-6">
									<label class="form-label">Role</label>
									<input type="text" class="form-control" value="Nurse" disabled>
								</div>
								<div class="col-md-6">
									<label class="form-label">Cellphone</label>
									<input type="text" class="form-control" value="072 555 1234">
								</div>
								<div class="col-md-6">
									<label class="form-label">Email</label>
									<input type="email" class="form-control" value="thandi.mthembu@clinic.org">
								</div>
								<div class="col-12">
									<label class="form-label">Facility</label>
									<input type="text" class="form-control" value="Umlilo Community Clinic" disabled>
								</div>
							</div>
							<div class="d-flex flex-wrap gap-2 mt-4">
								<button type="button" class="btn btn-primary">Save Changes</button>
								<button type="button" class="btn btn-outline-secondary">Cancel</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="card panel h-100">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">Security</h3>
						<p class="text-muted">Update the cellphone used for OTP delivery.</p>
						<div class="mb-3">
							<label class="form-label">OTP Phone</label>
							<input type="text" class="form-control" value="072 555 1234">
						</div>
						<button type="button" class="btn btn-outline-primary w-100">Request OTP Update</button>
						<hr>
						<button type="button" class="btn btn-outline-secondary w-100">Change Password</button>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
