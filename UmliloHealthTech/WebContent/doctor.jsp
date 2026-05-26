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
				<a href="profile" class="btn btn-sm btn-outline-primary">My Profile</a>
				<a href="logout" class="btn btn-sm btn-outline-secondary">Logout</a>
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
					<a href="#appointmentQueue" class="btn btn-light me-2">Open Current Appointment</a>
					<a href="#appointmentQueue" class="btn btn-outline-light">View Queue</a>
				</div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-4">
				<div class="card panel h-100">
					<div class="card-body p-4">
						<h3 class="h5 fw-semibold">Today Summary</h3>
						<ul class="list-unstyled mb-0">
							<li class="mb-2"><strong>Pending Sign-offs:</strong> <span id="pendingCount">0</span></li>
							<li class="mb-2"><strong>Current Queue:</strong> <span id="queueCount">0</span></li>
							<li class="mb-2"><strong>Status:</strong> <span id="queueStatus">Loading</span></li>
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
									<div class="fw-semibold" id="snapshotPatient">No current patient</div>
									<div class="text-muted" id="snapshotPatientId">ID: -</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="border rounded-3 p-3">
									<div class="text-muted">Nurse Notes</div>
									<div class="fw-semibold" id="snapshotNurseNotes">No notes loaded.</div>
									<div class="text-muted" id="snapshotNurse">Nurse: -</div>
								</div>
							</div>
						</div>
						<div class="d-flex flex-wrap gap-2 mt-3">
							<a href="#appointmentQueue" class="btn btn-primary" id="snapshotOpenBtn">Review & Sign Off</a>
							<a href="#appointmentQueue" class="btn btn-outline-secondary">View Queue</a>
						</div>
					</div>
				</div>

				<div class="card panel" id="appointmentQueue">
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
								<tbody id="doctorQueueBody"></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	function shortText(value, maxLength) {
		if (!value) return "-";
		return value.length > maxLength ? value.substring(0, maxLength - 3) + "..." : value;
	}

	function renderQueue(rows) {
		var body = document.getElementById("doctorQueueBody");
		body.innerHTML = "";
		document.getElementById("pendingCount").textContent = rows.length;
		document.getElementById("queueCount").textContent = rows.length;
		document.getElementById("queueStatus").textContent = rows.length ? "Ready for review" : "No pending sign-offs";

		if (!rows.length) {
			body.innerHTML = "<tr><td colspan=\"4\" class=\"text-muted\">No appointments waiting for doctor sign-off.</td></tr>";
			document.getElementById("snapshotPatient").textContent = "No current patient";
			document.getElementById("snapshotPatientId").textContent = "ID: -";
			document.getElementById("snapshotNurseNotes").textContent = "No notes loaded.";
			document.getElementById("snapshotNurse").textContent = "Nurse: -";
			document.getElementById("snapshotOpenBtn").href = "#appointmentQueue";
			return;
		}

		var first = rows[0];
		document.getElementById("snapshotPatient").textContent = first.patientName || "-";
		document.getElementById("snapshotPatientId").textContent = "ID: " + (first.patientIdNumber || "-");
		document.getElementById("snapshotNurseNotes").textContent = shortText(first.nurseNotes, 80);
		document.getElementById("snapshotNurse").textContent = "Nurse: " + (first.nurseName || "-");
		document.getElementById("snapshotOpenBtn").href = "doctor-appointment?appointmentId=" + first.id;

		rows.forEach(function (item) {
			var tr = document.createElement("tr");
			tr.innerHTML =
				"<td>" + (item.patientName || "-") + "<div class=\"small text-muted\">" + (item.patientIdNumber || "-") + "</div></td>" +
				"<td><span class=\"badge bg-warning text-dark\">Awaiting Sign-off</span></td>" +
				"<td>" + shortText(item.nurseNotes, 70) + "</td>" +
				"<td><a href=\"doctor-appointment?appointmentId=" + item.id + "\" class=\"btn btn-sm btn-outline-primary\">Open</a></td>";
			body.appendChild(tr);
		});
	}

	fetch("rest/appointments/doctor-queue")
		.then(function (response) {
			return response.json().then(function (data) { return { status: response.status, data: data }; });
		})
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				renderQueue(result.data.appointments || []);
			} else {
				renderQueue([]);
				document.getElementById("queueStatus").textContent = "Unable to load queue";
			}
		})
		.catch(function () {
			renderQueue([]);
			document.getElementById("queueStatus").textContent = "Unable to reach server";
		});
</script>
</body>
</html>
