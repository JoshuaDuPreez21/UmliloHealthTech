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
		--ink: #102027;
		--brand: #18786f;
		--brand-dark: #0f4f4a;
		--brand-soft: #e7f3f1;
		--accent: #f4b400;
		--surface: #ffffff;
		--muted: #687782;
		--border: #dfe9ed;
	}
	body {
		background:
			linear-gradient(145deg, rgba(24, 120, 111, 0.92), rgba(16, 32, 39, 0.76)),
			url("img/uht_bg.png");
		background-position: center;
		background-size: cover;
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	.login-shell {
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 1.5rem;
	}
	.auth-card {
		width: min(100%, 430px);
		background: rgba(255, 255, 255, 0.96);
		border: 1px solid rgba(255, 255, 255, 0.72);
		border-radius: 18px;
		box-shadow: 0 24px 70px rgba(7, 34, 35, 0.28);
		padding: clamp(1.5rem, 1.1rem + 1.8vw, 2.35rem);
	}
	.logo-wrap {
		display: flex;
		justify-content: center;
		margin-bottom: 1.35rem;
	}
	.brand-logo {
		width: min(70vw, 240px);
		height: auto;
		display: block;
	}
	.login-title {
		font-size: 1.35rem;
		font-weight: 800;
		text-align: center;
		margin-bottom: 0.35rem;
	}
	.login-subtitle {
		color: var(--muted);
		text-align: center;
		margin-bottom: 1.35rem;
		font-size: 0.95rem;
	}
	.role-toggle {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 0.35rem;
		background: #edf5f4;
		border: 1px solid var(--border);
		border-radius: 14px;
		padding: 0.35rem;
		margin-bottom: 1.25rem;
	}
	.role-option {
		position: relative;
	}
	.role-option input {
		position: absolute;
		opacity: 0;
		pointer-events: none;
	}
	.role-option label {
		width: 100%;
		min-height: 42px;
		border-radius: 10px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-weight: 800;
		color: var(--muted);
		cursor: pointer;
		transition: background 0.18s ease, color 0.18s ease, box-shadow 0.18s ease;
	}
	.role-option input:checked + label {
		background: var(--surface);
		color: var(--brand-dark);
		box-shadow: 0 8px 18px rgba(12, 67, 64, 0.13);
	}
	.form-label {
		font-weight: 800;
		color: #1d3037;
	}
	.form-control {
		border-radius: 12px;
		border-color: var(--border);
		min-height: 48px;
	}
	.form-control:focus {
		border-color: var(--brand);
		box-shadow: 0 0 0 0.22rem rgba(24, 120, 111, 0.16);
	}
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
		border-radius: 12px;
		min-height: 48px;
		font-weight: 800;
	}
	.btn-primary:hover {
		background: var(--brand-dark);
		border-color: var(--brand-dark);
	}
	.meta-row {
		display: flex;
		justify-content: center;
		margin-top: 1rem;
	}
	.meta-row a {
		color: var(--brand-dark);
		font-weight: 700;
		text-decoration: none;
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
		width: 210px;
		max-width: 100%;
		height: auto;
		margin: 0 auto 0.75rem;
		filter: drop-shadow(0 6px 12px rgba(15, 23, 42, 0.35));
	}
	.loading-text {
		margin-top: 0.6rem;
		font-weight: 700;
		font-size: 1.05rem;
	}
	@media (max-width: 480px) {
		.login-shell {
			padding: 1rem;
		}
		.auth-card {
			border-radius: 16px;
		}
	}
</style>
</head>
<body>
	<main class="login-shell">
		<section class="auth-card" aria-label="Secure login">
			<div class="logo-wrap">
				<img src="img/uht_bg.png" alt="Umlilo HealthTech logo" class="brand-logo">
			</div>
			<h1 class="login-title">Secure Login</h1>
			<p class="login-subtitle">Choose your role and enter your credentials.</p>

			<form id="loginForm">
				<div class="role-toggle" aria-label="Select role">
					<div class="role-option">
						<input type="radio" id="roleNurse" name="role" value="nurse" checked>
						<label for="roleNurse">Nurse</label>
					</div>
					<div class="role-option">
						<input type="radio" id="roleDoctor" name="role" value="doctor">
						<label for="roleDoctor">Doctor</label>
					</div>
				</div>

				<div class="mb-3">
					<label class="form-label" for="staffIdInput" id="staffIdLabel">Nurse ID</label>
					<input type="text" class="form-control" id="staffIdInput" name="staffId" placeholder="e.g. NUR-1024" autocomplete="username">
				</div>
				<div class="mb-3">
					<label class="form-label" for="passwordInput">Password</label>
					<input type="password" class="form-control" id="passwordInput" name="password" placeholder="Enter password" autocomplete="current-password">
				</div>

				<button type="submit" class="btn btn-primary w-100 mt-2">Sign in</button>
			</form>

			<div id="loginAlert" class="alert alert-info mt-4 d-none"></div>
			<div class="meta-row">
				<a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">Privacy & terms</a>
			</div>
		</section>
	</main>

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
						<li>Do not share credentials.</li>
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
	var staffIdLabel = document.getElementById("staffIdLabel");
	var staffIdInput = document.getElementById("staffIdInput");

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

	function getSelectedRole() {
		return document.querySelector("input[name='role']:checked").value;
	}

	function updateRoleFields() {
		var role = getSelectedRole();
		var isDoctor = role === "doctor";
		staffIdLabel.textContent = isDoctor ? "Doctor ID" : "Nurse ID";
		staffIdInput.placeholder = isDoctor ? "e.g. DR-2048" : "e.g. NUR-1024";
	}

	document.querySelectorAll("input[name='role']").forEach(function (input) {
		input.addEventListener("change", updateRoleFields);
	});

	document.getElementById("loginForm").addEventListener("submit", function (event) {
		event.preventDefault();
		var role = getSelectedRole();
		var payload = {
			staffId: staffIdInput.value.trim(),
			password: document.getElementById("passwordInput").value.trim(),
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
					showAlert("Role mismatch. Please use the " + (serverRole || "correct") + " role.", "warning");
					return;
				}
				showAlert("Login successful. Redirecting...", "success");
				if (serverRole === "doctor") {
					window.location.href = "doctor";
				} else {
					window.location.href = "home";
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

	updateRoleFields();
</script>
</body>
</html>
