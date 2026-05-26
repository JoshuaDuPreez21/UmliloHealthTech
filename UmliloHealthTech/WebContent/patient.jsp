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
	.page-title {
		font-size: clamp(1.4rem, 1.1rem + 1.4vw, 2rem);
	}
	@media (max-width: 768px) {
		.section-card .card-body {
			padding: 1.5rem;
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
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top border-bottom bg-white">
		<div class="container py-2">
			<span class="fw-semibold">Umlilo HealthTech</span>
			<div class="d-flex align-items-center gap-3">
				<a href="home" class="btn btn-sm btn-outline-secondary">Back to Dashboard</a>
			</div>
		</div>
	</nav>

	<div class="container py-4 py-lg-5">
		<div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
			<div>
				<h1 class="page-title fw-bold mb-1">New Patient Health Profile</h1>
				<p class="text-muted mb-0">Capture personal information and illness history for first-time visits.</p>
			</div>
			
		</div>

		<div class="alert alert-info" id="consentBanner">
			<strong>Consent required:</strong> Patient must agree to the privacy policy and digital record usage before saving.
		</div>

		<div class="row g-4">
			<div class="col-lg-8">
				<div class="card section-card mb-4">
					<div class="card-body p-4">
						<h2 class="h5 section-title mb-3">Personal Information</h2>
						<form id="patientForm">
							<div class="row g-3">
								<div class="col-md-6">
									<label class="form-label">First Name</label>
									<input type="text" class="form-control" name="firstName" placeholder="Enter first name">
								</div>
								<div class="col-md-6">
									<label class="form-label">Surname</label>
									<input type="text" class="form-control" name="surname" placeholder="Enter surname">
								</div>
								<div class="col-md-6">
									<label class="form-label">South African ID Number</label>
									<input type="text" class="form-control" name="idNumber" placeholder="13-digit ID">
									<div class="form-text">Age and date of birth will be derived from the ID.</div>
								</div>
								<div class="col-md-6">
									<label class="form-label">Cellphone</label>
									<input type="text" class="form-control" name="cell" placeholder="e.g. 072 123 4567">
								</div>
								<div class="col-md-6">
									<label class="form-label">Gender</label>
									<select class="form-select" name="gender">
										<option selected>Choose...</option>
										<option>Female</option>
										<option>Male</option>
										<option>Other</option>
									</select>
								</div>
								<div class="col-md-6">
									<label class="form-label">Email</label>
									<input type="email" class="form-control" name="email" placeholder="name@email.com">
								</div>
								<div class="col-12">
									<label class="form-label">Residential Address</label>
									<input type="text" class="form-control" name="address" placeholder="Street, suburb, city">
								</div>
								<div class="col-md-6">
									<label class="form-label">Employment Status</label>
									<select class="form-select" name="employmentStatus">
										<option selected>Select status</option>
										<option>Employed</option>
										<option>Unemployed</option>
										<option>Student</option>
										<option>Pensioner</option>
									</select>
								</div>
								<div class="col-md-6">
									<label class="form-label">Job Title</label>
									<input type="text" class="form-control" name="jobTitle" placeholder="Optional">
								</div>
								<div class="col-md-3">
									<label class="form-label">Next of Kin Name</label>
									<input type="text" class="form-control" name="nextOfKinName" placeholder="Full name">
								</div>
								<div class="col-md-3">
									<label class="form-label">Relationship</label>
									<input type="text" class="form-control" name="nextOfKinRelation" placeholder="e.g. Parent">
								</div>
								<div class="col-md-6">
									<label class="form-label">Emergency Contact</label>
									<input type="text" class="form-control" name="emergencyContact" placeholder="Contact number">
								</div>
								<div class="col-12">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="citizenCheck" name="notSouthAfrican">
										<label class="form-check-label" for="citizenCheck">Patient is not South African</label>
									</div>
								</div>
								<div class="col-md-6">
									<label class="form-label">Nationality</label>
									<select class="form-select" name="nationality">
										<option selected>Select nationality</option>
										<option>South Africa</option>
										<option>Angola</option>
										<option>Botswana</option>
										<option>Eswatini</option>
										<option>Kenya</option>
										<option>Lesotho</option>
										<option>Malawi</option>
										<option>Mozambique</option>
										<option>Namibia</option>
										<option>Nigeria</option>
										<option>Rwanda</option>
										<option>Tanzania</option>
										<option>Uganda</option>
										<option>Zambia</option>
										<option>Zimbabwe</option>
										<option>China</option>
										<option>India</option>
										<option>Pakistan</option>
										<option>United Kingdom</option>
										<option>United States</option>
										<option>Other</option>
									</select>
								</div>
								<div class="col-md-6">
									<label class="form-label">Citizen ID / Passport</label>
									<input type="text" class="form-control" name="foreignId" placeholder="Enter ID or passport number">
								</div>
							</div>
							
						</div>
					</div>

					<div class="card section-card" id="illnessSection">
					<div class="card-body p-4">
						<h2 class="h5 section-title mb-3">Illness History</h2>
						<p class="text-muted">Select current and historical illnesses.</p>
						<div class="row g-2">
							<div class="col-sm-6">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessDiabetes" name="illnesses" value="Diabetes">
									<label class="form-check-label" for="illnessDiabetes">Diabetes</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessHypertension" name="illnesses" value="Hypertension">
									<label class="form-check-label" for="illnessHypertension">Hypertension</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessAsthma" name="illnesses" value="Asthma">
									<label class="form-check-label" for="illnessAsthma">Asthma</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessHiv" name="illnesses" value="HIV / AIDS">
									<label class="form-check-label" for="illnessHiv">HIV / AIDS</label>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessTb" name="illnesses" value="Tuberculosis">
									<label class="form-check-label" for="illnessTb">Tuberculosis</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessHeart" name="illnesses" value="Heart Disease">
									<label class="form-check-label" for="illnessHeart">Heart Disease</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessKidney" name="illnesses" value="Kidney Disease">
									<label class="form-check-label" for="illnessKidney">Kidney Disease</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="illnessOther" name="illnesses" value="Other">
									<label class="form-check-label" for="illnessOther">Other (specify)</label>
								</div>
							</div>
						</div>
							<div class="mt-3">
								<label class="form-label">Additional Notes</label>
								<textarea class="form-control" name="illnessNotes" rows="3" placeholder="Optional details"></textarea>
							</div>
						</div>
					</div>
					</form>
				</div>

			<div class="col-lg-4">
				<div class="card section-card mb-4">
					<div class="card-body p-4">
						<h3 class="h5 section-title">Patient Summary</h3>
						<p class="text-muted">Auto-filled from ID and form inputs.</p>
						<ul class="list-unstyled">
							<li><strong>Age:</strong> <span id="summaryAge">-</span></li>
							<li><strong>Date of Birth:</strong> <span id="summaryDob">-</span></li>
							<li><strong>Gender:</strong> <span id="summaryGender">-</span></li>
							<li><strong>Contact:</strong> <span id="summaryContact">-</span></li>
						</ul>
						<div class="alert alert-warning" id="consentWarning">
							Confirm consent before saving.
						</div>
						<button class="btn btn-primary w-100" id="savePatientBtn" type="button">Save Patient Profile</button>
						<div id="patientAlert" class="alert alert-info mt-3 d-none"></div>
					</div>
				</div>
				<div class="card section-card">
					<div class="card-body p-4">
						<h3 class="h5 section-title">Consent & Privacy</h3>
						<p class="text-muted">Digital record usage consent required.</p>
						<div class="form-check mb-3">
							<input class="form-check-input" type="checkbox" id="consentCheck" name="consent">
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
<script src="js/session-timeout.js"></script>
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

	document.addEventListener("DOMContentLoaded", function () {
		var consentModal = new bootstrap.Modal(document.getElementById("consentModal"));
		consentModal.show();
	});

	function showPatientAlert(message, type) {
		var alertEl = document.getElementById("patientAlert");
		alertEl.className = "alert alert-" + type + " mt-3";
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function parseSouthAfricanDob(idNumber) {
		if (!idNumber || idNumber.length < 6) {
			return null;
		}
		var yy = parseInt(idNumber.substring(0, 2), 10);
		var mm = parseInt(idNumber.substring(2, 4), 10);
		var dd = parseInt(idNumber.substring(4, 6), 10);
		if (isNaN(yy) || isNaN(mm) || isNaN(dd) || mm < 1 || mm > 12 || dd < 1 || dd > 31) {
			return null;
		}
		var now = new Date();
		var currentYear = now.getFullYear();
		var fullYear = (yy + 2000) <= currentYear ? (yy + 2000) : (yy + 1900);
		var dob = new Date(fullYear, mm - 1, dd);
		if (isNaN(dob.getTime())) {
			return null;
		}
		return dob;
	}

	function formatDate(dateObj) {
		if (!dateObj) return "-";
		var yyyy = dateObj.getFullYear();
		var mm = String(dateObj.getMonth() + 1).padStart(2, "0");
		var dd = String(dateObj.getDate()).padStart(2, "0");
		return yyyy + "-" + mm + "-" + dd;
	}

	function calculateAge(dateObj) {
		if (!dateObj) return "-";
		var today = new Date();
		var age = today.getFullYear() - dateObj.getFullYear();
		var m = today.getMonth() - dateObj.getMonth();
		if (m < 0 || (m === 0 && today.getDate() < dateObj.getDate())) {
			age--;
		}
		return age >= 0 ? age : "-";
	}

	function updateSummary() {
		var idNumber = document.querySelector("[name='idNumber']").value.trim();
		var dob = parseSouthAfricanDob(idNumber);
		var gender = document.querySelector("[name='gender']").value;
		var contact = document.querySelector("[name='cell']").value.trim();

		document.getElementById("summaryDob").textContent = dob ? formatDate(dob) : "-";
		document.getElementById("summaryAge").textContent = dob ? calculateAge(dob) : "-";
		document.getElementById("summaryGender").textContent = gender && gender !== "Choose..." ? gender : "-";
		document.getElementById("summaryContact").textContent = contact || "-";
	}

	function validateRequiredField(value) {
		return value && value.trim().length > 0;
	}

	function normalizePhone(value) {
		if (!value) return "";
		var cleaned = value.replace(/[^0-9+]/g, "");
		if (cleaned.indexOf("+27") === 0) {
			cleaned = "0" + cleaned.substring(3);
		} else if (cleaned.indexOf("27") === 0 && cleaned.length === 11) {
			cleaned = "0" + cleaned.substring(2);
		}
		cleaned = cleaned.replace(/[^0-9]/g, "");
		return cleaned;
	}

	function isValidSouthAfricanPhone(value) {
		var normalized = normalizePhone(value);
		return /^0\d{9}$/.test(normalized);
	}

	function isValidSouthAfricanId(idNumber) {
		if (!/^\d{13}$/.test(idNumber)) {
			return false;
		}
		var dob = parseSouthAfricanDob(idNumber);
		if (!dob) {
			return false;
		}
		var sum = 0;
		var alternate = false;
		for (var i = idNumber.length - 1; i >= 0; i--) {
			var digit = parseInt(idNumber.charAt(i), 10);
			if (alternate) {
				digit *= 2;
				if (digit > 9) digit -= 9;
			}
			sum += digit;
			alternate = !alternate;
		}
		return sum % 10 === 0;
	}

	function clearValidation() {
		Array.prototype.slice.call(document.querySelectorAll(".is-invalid")).forEach(function (el) {
			el.classList.remove("is-invalid");
		});
		var illnessSection = document.getElementById("illnessSection");
		if (illnessSection) {
			illnessSection.classList.remove("border", "border-danger");
		}
		var consentWarning = document.getElementById("consentWarning");
		if (consentWarning) {
			consentWarning.classList.remove("border", "border-danger");
		}
	}

	function markInvalid(el) {
		if (el) {
			el.classList.add("is-invalid");
		}
	}

	function markInvalidGroup(el) {
		if (el) {
			el.classList.add("border", "border-danger");
		}
	}

	function scrollToInvalid(el) {
		if (el && typeof el.scrollIntoView === "function") {
			el.scrollIntoView({ behavior: "smooth", block: "center" });
		}
	}

	document.getElementById("savePatientBtn").addEventListener("click", function () {
		var form = document.getElementById("patientForm");
		clearValidation();
		var illnesses = Array.prototype.slice.call(document.querySelectorAll("input[name='illnesses']:checked"))
			.map(function (el) { return el.value; })
			.join(", ");
		var notSouthAfrican = document.getElementById("citizenCheck").checked;
		var otherIllnessSelected = document.getElementById("illnessOther").checked;
		var illnessNotesField = document.querySelector("[name='illnessNotes']");
		var illnessNotesValue = illnessNotesField ? illnessNotesField.value.trim() : "";

		var payload = {
			firstName: form.querySelector("[name='firstName']").value.trim(),
			surname: form.querySelector("[name='surname']").value.trim(),
			idNumber: form.querySelector("[name='idNumber']").value.trim(),
			cell: form.querySelector("[name='cell']").value.trim(),
			gender: form.querySelector("[name='gender']").value,
			email: form.querySelector("[name='email']").value.trim(),
			address: form.querySelector("[name='address']").value.trim(),
			employmentStatus: form.querySelector("[name='employmentStatus']").value,
			jobTitle: form.querySelector("[name='jobTitle']").value.trim(),
			nextOfKinName: form.querySelector("[name='nextOfKinName']").value.trim(),
			nextOfKinRelation: form.querySelector("[name='nextOfKinRelation']").value.trim(),
			emergencyContact: form.querySelector("[name='emergencyContact']").value.trim(),
			isSouthAfrican: !notSouthAfrican,
			nationality: form.querySelector("[name='nationality']").value.trim(),
			foreignId: form.querySelector("[name='foreignId']").value.trim(),
			illnesses: illnesses,
			illnessNotes: illnessNotesValue,
			consent: document.getElementById("consentCheck").checked
		};

		var firstInvalid = null;
		var missingRequired = false;

		function flagInvalid(el) {
			markInvalid(el);
			if (!firstInvalid) firstInvalid = el;
			missingRequired = true;
		}

		if (!validateRequiredField(payload.firstName)) flagInvalid(form.querySelector("[name='firstName']"));
		if (!validateRequiredField(payload.surname)) flagInvalid(form.querySelector("[name='surname']"));
		if (!validateRequiredField(payload.idNumber)) flagInvalid(form.querySelector("[name='idNumber']"));
		if (!validateRequiredField(payload.cell)) flagInvalid(form.querySelector("[name='cell']"));
		if (!validateRequiredField(payload.gender) || payload.gender === "Choose...") flagInvalid(form.querySelector("[name='gender']"));
		if (!validateRequiredField(payload.email)) flagInvalid(form.querySelector("[name='email']"));
		if (!validateRequiredField(payload.address)) flagInvalid(form.querySelector("[name='address']"));
		if (!validateRequiredField(payload.employmentStatus) || payload.employmentStatus === "Select status") flagInvalid(form.querySelector("[name='employmentStatus']"));
		if (!validateRequiredField(payload.jobTitle)) flagInvalid(form.querySelector("[name='jobTitle']"));
		if (!validateRequiredField(payload.nextOfKinName)) flagInvalid(form.querySelector("[name='nextOfKinName']"));
		if (!validateRequiredField(payload.nextOfKinRelation)) flagInvalid(form.querySelector("[name='nextOfKinRelation']"));
		if (!validateRequiredField(payload.emergencyContact)) flagInvalid(form.querySelector("[name='emergencyContact']"));

		if (missingRequired) {
			showPatientAlert("Please complete all required fields.", "warning");
			scrollToInvalid(firstInvalid);
			return;
		}

		if (!isValidSouthAfricanId(payload.idNumber)) {
			var idField = form.querySelector("[name='idNumber']");
			markInvalid(idField);
			showPatientAlert("Enter a valid South African ID number (13 digits).", "warning");
			scrollToInvalid(idField);
			return;
		}

		if (!isValidSouthAfricanPhone(payload.cell)) {
			var cellField = form.querySelector("[name='cell']");
			markInvalid(cellField);
			showPatientAlert("Enter a valid South African cellphone number.", "warning");
			scrollToInvalid(cellField);
			return;
		}

		if (!isValidSouthAfricanPhone(payload.emergencyContact)) {
			var emergencyField = form.querySelector("[name='emergencyContact']");
			markInvalid(emergencyField);
			showPatientAlert("Enter a valid South African emergency contact number.", "warning");
			scrollToInvalid(emergencyField);
			return;
		}

		if (notSouthAfrican) {
			var nationalityField = form.querySelector("[name='nationality']");
			var foreignIdField = form.querySelector("[name='foreignId']");
			if (!validateRequiredField(payload.nationality) || payload.nationality === "Select nationality") {
				markInvalid(nationalityField);
			}
			if (!validateRequiredField(payload.foreignId)) {
				markInvalid(foreignIdField);
			}
			if (!validateRequiredField(payload.nationality) || payload.nationality === "Select nationality" || !validateRequiredField(payload.foreignId)) {
				showPatientAlert("Nationality and passport/foreign ID are required for non-South African patients.", "warning");
				scrollToInvalid(firstInvalid || nationalityField || foreignIdField);
				return;
			}
		}

		if (!payload.illnesses) {
			var illnessSection = document.getElementById("illnessSection");
			markInvalidGroup(illnessSection);
			showPatientAlert("Please select at least one illness.", "warning");
			scrollToInvalid(illnessSection);
			return;
		}

		if (otherIllnessSelected && !validateRequiredField(illnessNotesValue)) {
			markInvalid(illnessNotesField);
			showPatientAlert("Please add notes for Other illness.", "warning");
			scrollToInvalid(illnessNotesField);
			return;
		}

		if (!payload.consent) {
			var consentCheck = document.getElementById("consentCheck");
			var consentWarning = document.getElementById("consentWarning");
			markInvalid(consentCheck);
			markInvalidGroup(consentWarning);
			showPatientAlert("Patient consent is required.", "warning");
			scrollToInvalid(consentCheck);
			return;
		}

		showLoading();
		fetch("rest/patients/save", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(payload)
		})
		.then(function (response) { return response.json().then(function (data) { return { status: response.status, data: data }; }); })
		.then(function (result) {
			if (result.status === 200 && result.data.success) {
				showPatientAlert("Patient saved successfully. ID: " + result.data.patientId, "success");
				var consentWarning = document.getElementById("consentWarning");
				if (consentWarning) {
					consentWarning.classList.add("d-none");
				}
				form.reset();
				document.getElementById("consentCheck").checked = false;
				clearValidation();
				updateSummary();
				setTimeout(function () {
					window.location.href = "home";
				}, 3000);
			} else {
				var message = result.data && result.data.message ? result.data.message : "Unable to save patient.";
				showPatientAlert(message, "warning");
			}
		})
		.catch(function () {
			showPatientAlert("Unable to reach server. Please try again.", "danger");
		})
		.finally(function () {
			hideLoading();
		});
	});

	["firstName", "surname", "idNumber", "cell", "gender", "email", "address", "employmentStatus", "jobTitle", "nextOfKinName", "nextOfKinRelation", "emergencyContact"]
		.forEach(function (name) {
			var field = document.querySelector("[name='" + name + "']");
			if (field) {
				field.addEventListener("input", updateSummary);
				field.addEventListener("change", updateSummary);
				field.addEventListener("input", function () {
					field.classList.remove("is-invalid");
				});
				field.addEventListener("change", function () {
					field.classList.remove("is-invalid");
				});
			}
		});
	["nationality", "foreignId", "illnessNotes"].forEach(function (name) {
		var field = document.querySelector("[name='" + name + "']");
		if (field) {
			field.addEventListener("input", function () {
				field.classList.remove("is-invalid");
			});
			field.addEventListener("change", function () {
				field.classList.remove("is-invalid");
			});
		}
	});
	Array.prototype.slice.call(document.querySelectorAll("input[name='illnesses']")).forEach(function (box) {
		box.addEventListener("change", function () {
			var illnessSection = document.getElementById("illnessSection");
			if (illnessSection) {
				illnessSection.classList.remove("border", "border-danger");
			}
		});
	});
	var consentCheck = document.getElementById("consentCheck");
	if (consentCheck) {
		consentCheck.addEventListener("change", function () {
			consentCheck.classList.remove("is-invalid");
			var consentWarning = document.getElementById("consentWarning");
			if (consentWarning) {
				consentWarning.classList.remove("border", "border-danger");
			}
		});
	}
	updateSummary();
</script>
</body>
</html>
