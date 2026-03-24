<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Secure Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
	:root {
		--ink: #0f172a;
		--brand: #1b7a6d;
		--brand-soft: #e7f3f1;
		--surface: #ffffff;
		--muted: #667085;
		--border: #e5edf2;
	}
	body {
		background: var(--brand);
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	.brand-panel {
		background: #ffffff;
		color: var(--ink);
		color: #fff;
		border-radius: 26px;
		padding: 2.5rem;
		box-shadow: 0 18px 45px rgba(15, 61, 62, 0.08);
		height: 100%;
		position: relative;
		overflow: hidden;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.brand-panel::after {
		content: "";
		position: absolute;
		inset: 0;
		background: radial-gradient(circle at top left, rgba(27, 122, 109, 0.08), transparent 55%);
		opacity: 1;
		z-index: 0;
	}
	.brand-panel-content {
		position: relative;
		z-index: 1;
		text-align: center;
	}
	.auth-card {
		border: none;
		box-shadow: 0 20px 50px rgba(15, 61, 62, 0.12);
		border-radius: 20px;
	}
	.form-control, .form-select {
		border-radius: 12px;
		border-color: var(--border);
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
	.loading-overlay {
		position: fixed;
		inset: 0;
		background: rgba(15, 23, 42, 0.55);
		display: flex;
		align-items: center;
		justify-content: center;
		opacity: 0;
		visibility: hidden;
		transition: opacity 0.2s ease, visibility 0.2s ease;
		z-index: 2000;
	}
	.loading-overlay.show {
		opacity: 1;
		visibility: visible;
	}
	.loading-card {
		background: rgba(255, 255, 255, 0.14);
		border: 1px solid rgba(255, 255, 255, 0.25);
		backdrop-filter: blur(8px);
		border-radius: 18px;
		padding: 1.5rem;
		width: min(70vw, 260px);
		text-align: center;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: #fff;
		box-shadow: 0 18px 35px rgba(15, 23, 42, 0.28);
	}
	.loading-logo {
		width: 230px;
		max-width: 100%;
		height: auto;
		margin: 0 auto 0.75rem;
		filter: drop-shadow(0 6px 12px rgba(15, 23, 42, 0.35));
	}
	.loading-text {
		margin-top: 0.6rem;
		font-weight: 700;
		font-size: 1.2rem;
		letter-spacing: 0.04em;
	}
	.brand-logo {
		width: min(70vw, 380px);
		height: auto;
	}
	.login-title {
		font-size: clamp(1.5rem, 1.2rem + 1vw, 2rem);
		font-weight: 700;
	}
	.login-subtitle {
		font-size: clamp(0.95rem, 0.9rem + 0.4vw, 1.1rem);
	}
	.auth-card {
		min-height: 520px;
	}
	@media (max-width: 992px) {
		.auth-card {
			min-height: auto;
		}
		.brand-panel {
			padding: 2rem;
		}
	}
	@media (max-width: 768px) {
		.brand-panel {
			padding: 1.75rem;
		}
		.auth-card {
			padding: 1.75rem;
		}
	}
</style>
</head>
<body>
	<div class="container min-vh-100 d-flex align-items-center py-4 py-lg-5">
		<div class="row g-4 align-items-stretch">
			<div class="col-lg-5">
				<div class="brand-panel">
					<div class="brand-panel-content">
						<img src="img/uht_bg.png" alt="Umlilo HealthTech logo" class="brand-logo mb-3">
					</div>
				</div>
			</div>

			<div class="col-lg-7">
				<div class="card auth-card p-4 p-lg-5 h-100">
					<h2 class="login-title mb-2">Sign in</h2>
					<p class="text-muted login-subtitle mb-4">Use your staff ID and password to continue.</p>

					<ul class="nav nav-pills mb-4" id="roleTabs" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="nurse-tab" data-bs-toggle="pill" data-bs-target="#nurse-login" type="button" role="tab">Nurse</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="doctor-tab" data-bs-toggle="pill" data-bs-target="#doctor-login" type="button" role="tab">Doctor</button>
						</li>
					</ul>

					<div class="tab-content">
						<div class="tab-pane fade show active" id="nurse-login" role="tabpanel">
							<form class="login-form" data-role="nurse">
								<div class="row g-3">
									<div class="col-md-6">
										<label class="form-label">Nurse ID</label>
										<input type="text" class="form-control" name="staffId" placeholder="e.g. NUR-1024">
									</div>
									<div class="col-md-6">
										<label class="form-label">Password</label>
										<input type="password" class="form-control" name="password" placeholder="********">
									</div>
									<div class="col-12">
										<label class="form-label">OTP (SMS)</label>
										<div class="input-group">
											<input type="text" class="form-control" name="otp" placeholder="6-digit OTP">
											<button class="btn btn-outline-secondary" type="button">Send OTP</button>
										</div>
										<div class="form-text">OTP is sent to your registered cellphone.</div>
									</div>
								</div>
								<div class="d-flex flex-wrap gap-2 mt-4">
									<button type="submit" class="btn btn-primary px-4">Sign in</button>
									<button type="button" class="btn btn-outline-primary">Forgot password</button>
								</div>
							</form>
						</div>

						<div class="tab-pane fade" id="doctor-login" role="tabpanel">
							<form class="login-form" data-role="doctor">
								<div class="row g-3">
									<div class="col-md-6">
										<label class="form-label">Doctor ID</label>
										<input type="text" class="form-control" name="staffId" placeholder="e.g. DR-2048">
									</div>
									<div class="col-md-6">
										<label class="form-label">Password</label>
										<input type="password" class="form-control" name="password" placeholder="********">
									</div>
									<div class="col-12">
										<label class="form-label">OTP (SMS)</label>
										<div class="input-group">
											<input type="text" class="form-control" name="otp" placeholder="6-digit OTP">
											<button class="btn btn-outline-secondary" type="button">Send OTP</button>
										</div>
										<div class="form-text">OTP is required for sign-in.</div>
									</div>
								</div>
								<div class="d-flex flex-wrap gap-2 mt-4">
									<button type="submit" class="btn btn-primary px-4">Sign in</button>
									<button type="button" class="btn btn-outline-primary">Forgot password</button>
								</div>
							</form>
						</div>
					</div>
					<div id="loginAlert" class="alert alert-info mt-4 d-none"></div>
					<div class="d-flex flex-wrap align-items-center justify-content-between mt-4">
						<small class="text-muted">By signing in, you agree to the facility access policy.</small>
						<a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#privacyModal">Privacy & terms</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="privacyModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Privacy & Terms</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<p>This system stores patient and staff activity data for clinical care and auditability.</p>
					<ul>
						<li>Access is restricted to authorized personnel only.</li>
						<li>All logins and actions are logged for compliance.</li>
						<li>Do not share credentials or OTPs.</li>
						<li>Patients may request corrections to their records.</li>
						<li>Data is used for clinical care, reporting, and service improvement.</li>
					</ul>
					<p class="mb-0">By continuing, you acknowledge these terms and agree to comply with facility policies.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" data-bs-dismiss="modal">Acknowledge</button>
				</div>
			</div>
		</div>
	</div>

	<div class="loading-overlay" id="loadingOverlay">
		<div class="loading-card">
			<img src="img/uht_bg.png" alt="Umlilo HealthTech logo" class="loading-logo">
			<div class="spinner-border text-light" role="status"></div>
			<div class="loading-text">Loading...</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	var loadingCount = 0;
	var loadingStart = 0;
	var loadingMinMs = 500;
	function showLoading() {
		loadingCount += 1;
		if (loadingCount === 1) {
			loadingStart = Date.now();
		}
		document.getElementById("loadingOverlay").classList.add("show");
	}
	function hideLoading() {
		loadingCount = Math.max(0, loadingCount - 1);
		if (loadingCount === 0) {
			var elapsed = Date.now() - loadingStart;
			var remaining = Math.max(0, loadingMinMs - elapsed);
			setTimeout(function () {
				if (loadingCount === 0) {
					document.getElementById("loadingOverlay").classList.remove("show");
				}
			}, remaining);
		}
	}

	function showAlert(message, type) {
		var alertEl = document.getElementById("loginAlert");
		alertEl.className = "alert alert-" + type + " mt-4";
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	document.querySelectorAll(".login-form").forEach(function (form) {
		form.addEventListener("submit", function (event) {
			event.preventDefault();
			var role = form.getAttribute("data-role");
			var payload = {
				staffId: form.querySelector("[name='staffId']").value.trim(),
				password: form.querySelector("[name='password']").value.trim(),
				otp: form.querySelector("[name='otp']").value.trim(),
				role: role
			};

			showLoading();
			fetch("rest/auth/login", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(payload)
			})
			.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					var serverRole = result.data.role ? result.data.role.toLowerCase() : "";
					if (role !== serverRole) {
						showAlert("Role mismatch. Please use the " + (serverRole || "correct") + " login tab.", "warning");
						return;
					}
					showAlert("Login successful. Redirecting...", "success");
					if (serverRole === "doctor") {
						window.location.href = "doctor.jsp";
					} else {
						window.location.href = "home.jsp";
					}
				} else {
					var message = result.data && result.data.message ? result.data.message : "Login failed.";
					showAlert(message, "warning");
				}
			})
			.catch(function () {
				showAlert("Unable to reach server. Please try again.", "danger");
			})
			.finally(function () {
				hideLoading();
			});
		});
	});
</script>
</body>
</html>
