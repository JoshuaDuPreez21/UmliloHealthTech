<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Health Education</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
	:root {
		--ink: #061427;
		--muted: #64748b;
		--line: #d9e5ec;
		--page: #f6f8fb;
		--panel: #ffffff;
		--brand: #0879ad;
		--teal: #10bfa6;
		--orange: #f59e0b;
		--sidebar: #0d1b27;
		--sidebar-soft: #172a3d;
	}
	* { box-sizing: border-box; }
	body {
		margin: 0;
		background: var(--page);
		min-height: 100vh;
		font-family: "Manrope", "Segoe UI", sans-serif;
		color: var(--ink);
	}
	.app-shell {
		min-height: 100vh;
		padding-right: 326px;
		transition: padding-right 0.2s ease;
	}
	body.sidebar-collapsed .app-shell { padding-right: 92px; }
	.topbar {
		height: 130px;
		background: #fff;
		border-bottom: 1px solid var(--line);
		display: flex;
		align-items: center;
		justify-content: flex-end;
		padding: 0 2.35rem;
	}
	.notification {
		width: 42px;
		height: 42px;
		border: 0;
		border-radius: 50%;
		background: #f2f6fa;
		color: #52677d;
		position: relative;
		display: inline-flex;
		align-items: center;
		justify-content: center;
	}
	.notification-count {
		position: absolute;
		top: -5px;
		right: -2px;
		background: var(--orange);
		color: #fff;
		border-radius: 50%;
		min-width: 21px;
		height: 21px;
		font-size: 0.74rem;
		font-weight: 800;
		display: inline-flex;
		align-items: center;
		justify-content: center;
	}
	.main-content {
		padding: 2.7rem 2.35rem 3rem;
		max-width: 1120px;
	}
	.page-head {
		display: flex;
		align-items: flex-start;
		justify-content: space-between;
		gap: 1rem;
		margin-bottom: 2rem;
	}
	.page-title {
		font-size: clamp(1.65rem, 1.35rem + 1vw, 2rem);
		font-weight: 800;
		margin: 0 0 0.35rem;
	}
	.page-subtitle {
		color: var(--muted);
		font-weight: 700;
		margin: 0;
	}
	.btn-primary {
		background: var(--brand);
		border-color: var(--brand);
		border-radius: 9px;
		font-weight: 800;
		min-height: 45px;
		box-shadow: 0 5px 12px rgba(8, 121, 173, 0.22);
	}
	.btn-primary:hover,
	.btn-primary:focus {
		background: #075f88;
		border-color: #075f88;
	}
	.search-box {
		position: relative;
		margin-bottom: 1.85rem;
	}
	.search-box i {
		position: absolute;
		left: 1rem;
		top: 50%;
		transform: translateY(-50%);
		color: #60758b;
		font-size: 1.1rem;
		pointer-events: none;
	}
	.search-box .form-control {
		padding-left: 2.9rem;
	}
	.form-control,
	.form-select {
		border-color: var(--line);
		border-radius: 10px;
		min-height: 45px;
		box-shadow: 0 2px 8px rgba(15, 35, 55, 0.04);
		font-weight: 600;
	}
	textarea.form-control { min-height: 160px; }
	.form-label {
		font-weight: 800;
		margin-bottom: 0.65rem;
	}
	.category-tabs,
	.tag-list {
		display: flex;
		flex-wrap: wrap;
		gap: 0.35rem;
	}
	.category-tabs {
		margin-bottom: 2.2rem;
	}
	.category-tab,
	.content-tag {
		border: 1px solid var(--line);
		background: #fff;
		color: #536b83;
		border-radius: 999px;
		padding: 0.5rem 0.95rem;
		font-weight: 800;
		line-height: 1.2;
	}
	.category-tab.active {
		background: var(--brand);
		border-color: var(--brand);
		color: #fff;
	}
	.content-grid {
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 1rem;
	}
	.content-card {
		background: #fff;
		border: 1px solid var(--line);
		border-radius: 13px;
		box-shadow: 0 2px 7px rgba(15, 35, 55, 0.1);
		padding: 1.1rem;
		min-height: 220px;
		display: flex;
		flex-direction: column;
		gap: 0.85rem;
	}
	.content-top {
		display: flex;
		align-items: flex-start;
		justify-content: space-between;
		gap: 0.75rem;
	}
	.content-icon {
		width: 44px;
		height: 44px;
		border-radius: 12px;
		background: #e7f3f9;
		color: var(--brand);
		display: inline-flex;
		align-items: center;
		justify-content: center;
		font-size: 1.25rem;
		flex: 0 0 auto;
	}
	.content-title {
		font-weight: 800;
		font-size: 1rem;
		line-height: 1.25;
		margin: 0;
	}
	.content-summary {
		color: var(--muted);
		font-size: 0.9rem;
		line-height: 1.55;
		margin: 0;
	}
	.content-meta {
		color: #536b83;
		font-size: 0.78rem;
		font-weight: 800;
		display: flex;
		flex-wrap: wrap;
		gap: 0.35rem 0.8rem;
	}
	.content-tag {
		font-size: 0.72rem;
		padding: 0.32rem 0.65rem;
	}
	.open-link {
		margin-top: auto;
		border-radius: 9px;
		font-weight: 800;
		text-decoration: none;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		gap: 0.45rem;
		min-height: 41px;
	}
	.empty-state {
		grid-column: 1 / -1;
		text-align: center;
		color: #526985;
		font-weight: 600;
		padding: 5rem 1rem 2rem;
	}
	.empty-state i {
		display: block;
		color: #c7d1dc;
		font-size: 3rem;
		margin-bottom: 0.6rem;
	}
	.sidebar {
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		width: 326px;
		background: var(--sidebar);
		color: #d7e4ee;
		z-index: 1000;
		display: flex;
		flex-direction: column;
		transition: width 0.2s ease;
	}
	body.sidebar-collapsed .sidebar { width: 92px; }
	.sidebar-toggle {
		position: absolute;
		left: -17px;
		top: 161px;
		width: 34px;
		height: 34px;
		border: 1px solid var(--line);
		border-radius: 50%;
		background: #fff;
		color: #102033;
		box-shadow: 0 8px 18px rgba(15, 35, 55, 0.16);
		display: inline-flex;
		align-items: center;
		justify-content: center;
	}
	.brand-block {
		height: 150px;
		display: flex;
		align-items: center;
		gap: 0.95rem;
		padding: 1.45rem 1.5rem;
		border-bottom: 1px solid rgba(255, 255, 255, 0.08);
	}
	.brand-mark {
		width: 46px;
		height: 46px;
		border-radius: 14px;
		background: #0879ad;
		overflow: hidden;
		flex: 0 0 auto;
	}
	.brand-mark img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	.brand-title {
		font-weight: 800;
		font-size: 1.18rem;
		line-height: 1.1;
		color: #fff;
		white-space: nowrap;
	}
	.brand-subtitle {
		color: #95a8b8;
		font-size: 0.78rem;
		margin-top: 0.15rem;
	}
	.nav-menu {
		padding: 1.25rem 1.1rem;
		overflow-y: auto;
		flex: 1 1 auto;
	}
	.nav-item-link {
		display: flex;
		align-items: center;
		gap: 1rem;
		min-height: 50px;
		border-radius: 12px;
		color: #98a9b6;
		text-decoration: none;
		padding: 0 1rem;
		font-weight: 800;
		margin-bottom: 0.55rem;
	}
	.nav-item-link:hover,
	.nav-item-link.active {
		background: var(--sidebar-soft);
		color: #16d6bd;
	}
	.nav-item-link i {
		font-size: 1.25rem;
		width: 24px;
		text-align: center;
		flex: 0 0 auto;
	}
	.sidebar-footer {
		padding: 1rem 1.1rem 1.35rem;
		border-top: 1px solid rgba(255, 255, 255, 0.06);
	}
	.role-switch {
		background: #142536;
		border-radius: 12px;
		padding: 0.35rem;
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 0.35rem;
		margin-bottom: 0.85rem;
	}
	.role-switch a {
		border-radius: 9px;
		text-align: center;
		padding: 0.55rem 0.35rem;
		color: #99aab8;
		text-decoration: none;
		font-weight: 800;
		font-size: 0.86rem;
	}
	.role-switch a.active {
		background: var(--teal);
		color: #fff;
	}
	.sign-out {
		color: #99aab8;
		text-decoration: none;
		font-weight: 800;
		display: flex;
		align-items: center;
		gap: 0.8rem;
		padding: 0.7rem 1rem;
		border-radius: 12px;
	}
	.sign-out:hover {
		background: var(--sidebar-soft);
		color: #fff;
	}
	body.sidebar-collapsed .brand-copy,
	body.sidebar-collapsed .nav-label,
	body.sidebar-collapsed .role-switch,
	body.sidebar-collapsed .sign-out span {
		display: none;
	}
	body.sidebar-collapsed .brand-block,
	body.sidebar-collapsed .nav-item-link,
	body.sidebar-collapsed .sign-out {
		justify-content: center;
		padding-left: 0;
		padding-right: 0;
	}
	body.sidebar-collapsed .nav-menu,
	body.sidebar-collapsed .sidebar-footer {
		padding-left: 0.85rem;
		padding-right: 0.85rem;
	}
	.modal-backdrop.show { opacity: 0.78; }
	.modal-dialog { max-width: 840px; }
	.modal-content {
		border: 1px solid #b8c4d0;
		border-radius: 12px;
		box-shadow: 0 24px 60px rgba(0, 0, 0, 0.28);
	}
	.modal-header {
		border-bottom: 0;
		padding: 1.45rem 1.9rem 0.5rem;
	}
	.modal-title {
		font-size: 1.25rem;
		font-weight: 800;
	}
	.modal-body {
		padding: 1rem 1.9rem;
		max-height: 72vh;
		overflow-y: auto;
	}
	.modal-footer {
		border-top: 0;
		padding: 1rem 1.9rem 1.45rem;
	}
	.file-note {
		color: var(--muted);
		font-size: 0.82rem;
		margin-top: 0.4rem;
	}
	@media (max-width: 1180px) {
		.content-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
	}
	@media (max-width: 880px) {
		.app-shell,
		body.sidebar-collapsed .app-shell { padding-right: 0; }
		.sidebar,
		body.sidebar-collapsed .sidebar {
			width: min(86vw, 326px);
			transform: translateX(100%);
		}
		body.sidebar-open .sidebar { transform: translateX(0); }
		.sidebar-toggle {
			left: -44px;
			top: 18px;
			width: 38px;
			height: 38px;
		}
		.topbar {
			height: 72px;
			padding: 0 1rem;
		}
		.main-content { padding: 1.5rem 1rem 2rem; }
		.page-head {
			flex-direction: column;
			margin-bottom: 1.5rem;
		}
		.content-grid { grid-template-columns: 1fr; }
		.modal-dialog { margin: 0.5rem; }
	}
</style>
</head>
<body>
	<aside class="sidebar" aria-label="Nurse workspace menu">
		<button class="sidebar-toggle" id="sidebarToggle" type="button" aria-label="Toggle menu">
			<i class="bi bi-chevron-right"></i>
		</button>
		<div class="brand-block">
			<div class="brand-mark"><img src="img/uht_bg.png" alt="Umlilo HealthTech logo"></div>
			<div class="brand-copy">
				<div class="brand-title">Umlilo Health</div>
				<div class="brand-subtitle">Technologies</div>
			</div>
		</div>
		<nav class="nav-menu">
			<a href="home" class="nav-item-link"><i class="bi bi-grid"></i><span class="nav-label">Dashboard</span></a>
			<a href="appointment" class="nav-item-link"><i class="bi bi-people"></i><span class="nav-label">Patients</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-diagram-3"></i><span class="nav-label">Patient Flow</span></a>
			<a href="capture-appointment" class="nav-item-link"><i class="bi bi-stethoscope"></i><span class="nav-label">Nurse Workspace</span></a>
			<a href="visits-today" class="nav-item-link"><i class="bi bi-activity"></i><span class="nav-label">Visits Today</span></a>
			<a href="vitals-overview" class="nav-item-link"><i class="bi bi-heart-pulse"></i><span class="nav-label">Vitals Overview</span></a>
			<a href="referrals" class="nav-item-link"><i class="bi bi-arrow-left-right"></i><span class="nav-label">Referrals</span></a>
			<a href="screening" class="nav-item-link"><i class="bi bi-clipboard2-pulse"></i><span class="nav-label">Screening</span></a>
			<a href="health-education" class="nav-item-link active"><i class="bi bi-book"></i><span class="nav-label">Health Education</span></a>
		</nav>
		<div class="sidebar-footer">
			<div class="role-switch">
				<a href="home"><i class="bi bi-stethoscope"></i> Nurse</a>
				<a href="doctor" class="active"><i class="bi bi-person-gear"></i> Doctor</a>
			</div>
			<a href="logout" class="sign-out"><i class="bi bi-box-arrow-right"></i><span>Sign Out</span></a>
		</div>
	</aside>

	<div class="app-shell">
		<header class="topbar">
			<button class="notification" type="button" aria-label="Notifications">
				<i class="bi bi-bell"></i>
				<span class="notification-count">4</span>
			</button>
		</header>

		<main class="main-content">
			<div class="page-head">
				<div>
					<h1 class="page-title">Health Education</h1>
					<p class="page-subtitle">Patient information and health resources</p>
				</div>
				<button class="btn btn-primary px-4" type="button" data-bs-toggle="modal" data-bs-target="#educationModal">
					<i class="bi bi-plus-lg me-2"></i> Add Content
				</button>
			</div>

			<div class="search-box">
				<i class="bi bi-search"></i>
				<input type="text" class="form-control" id="contentSearch" placeholder="Search articles...">
			</div>

			<div class="category-tabs" role="tablist" aria-label="Health education categories">
				<button class="category-tab active" type="button" data-category="">All</button>
				<button class="category-tab" type="button" data-category="HIV/AIDS">HIV/AIDS</button>
				<button class="category-tab" type="button" data-category="TB">TB</button>
				<button class="category-tab" type="button" data-category="Maternal Health">Maternal Health</button>
				<button class="category-tab" type="button" data-category="Child Health">Child Health</button>
				<button class="category-tab" type="button" data-category="Nutrition">Nutrition</button>
				<button class="category-tab" type="button" data-category="Mental Health">Mental Health</button>
				<button class="category-tab" type="button" data-category="Chronic Disease">Chronic Disease</button>
				<button class="category-tab" type="button" data-category="Hygiene & Prevention">Hygiene & Prevention</button>
				<button class="category-tab" type="button" data-category="Medication Adherence">Medication Adherence</button>
				<button class="category-tab" type="button" data-category="COVID-19">COVID-19</button>
				<button class="category-tab" type="button" data-category="General Wellness">General Wellness</button>
			</div>

			<section class="content-grid" id="contentGrid" aria-live="polite"></section>
		</main>
	</div>

	<div class="modal fade" id="educationModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="modal-title">Add Health Content</h2>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row g-4">
						<div class="col-12">
							<label class="form-label" for="contentTitle">Title *</label>
							<input type="text" class="form-control" id="contentTitle" placeholder="e.g. Understanding HIV Treatment">
						</div>
						<div class="col-md-6">
							<label class="form-label" for="contentCategory">Category *</label>
							<select class="form-select" id="contentCategory">
								<option value="">Select</option>
								<option>HIV/AIDS</option>
								<option>TB</option>
								<option>Maternal Health</option>
								<option>Child Health</option>
								<option>Nutrition</option>
								<option>Mental Health</option>
								<option>Chronic Disease</option>
								<option>Hygiene & Prevention</option>
								<option>Medication Adherence</option>
								<option>COVID-19</option>
								<option>General Wellness</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="contentType">Content Type</label>
							<select class="form-select" id="contentType">
								<option>Article</option>
								<option>PDF</option>
								<option>Checklist</option>
								<option>Patient Handout</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="contentLanguage">Language</label>
							<select class="form-select" id="contentLanguage">
								<option>English</option>
								<option>isiZulu</option>
								<option>isiXhosa</option>
								<option>Afrikaans</option>
								<option>Sesotho</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label" for="targetAudience">Target Audience</label>
							<select class="form-select" id="targetAudience">
								<option>All Patients</option>
								<option>Adults</option>
								<option>Children and Caregivers</option>
								<option>Pregnant Patients</option>
								<option>Chronic Care Patients</option>
								<option>Healthcare Workers</option>
							</select>
						</div>
						<div class="col-12">
							<label class="form-label" for="contentTags">Tags</label>
							<input type="text" class="form-control" id="contentTags" placeholder="Comma-separated tags, e.g. ART, adherence, side effects">
						</div>
						<div class="col-12">
							<label class="form-label" for="contentSummary">Summary</label>
							<input type="text" class="form-control" id="contentSummary" placeholder="Short description shown in list view">
						</div>
						<div class="col-12">
							<label class="form-label" for="pdfFile">PDF Upload</label>
							<input type="file" class="form-control" id="pdfFile" accept="application/pdf,.pdf">
							<div class="file-note">PDF resources open in a new tab from the grid.</div>
						</div>
						<div class="col-12">
							<label class="form-label" for="fullContent">Full Content *</label>
							<textarea class="form-control" id="fullContent" placeholder="Write the full article, tip, or checklist here..."></textarea>
						</div>
						<div class="col-12">
							<div id="contentAlert" class="alert alert-warning d-none mb-0"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary px-4" id="saveContentBtn">Save Content</button>
				</div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/session-timeout.js"></script>
<script>
	var contentItems = [];
	var activeCategory = "";

	function escapeHtml(value) {
		return String(value == null ? "" : value)
			.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#039;");
	}

	function splitTags(value) {
		return String(value || "")
			.split(",")
			.map(function (tag) { return tag.trim(); })
			.filter(Boolean);
	}

	function showAlert(message) {
		var alertEl = document.getElementById("contentAlert");
		alertEl.textContent = message;
		alertEl.classList.remove("d-none");
	}

	function clearAlert() {
		document.getElementById("contentAlert").classList.add("d-none");
	}

	function resetForm() {
		document.getElementById("contentTitle").value = "";
		document.getElementById("contentCategory").value = "";
		document.getElementById("contentType").value = "Article";
		document.getElementById("contentLanguage").value = "English";
		document.getElementById("targetAudience").value = "All Patients";
		document.getElementById("contentTags").value = "";
		document.getElementById("contentSummary").value = "";
		document.getElementById("pdfFile").value = "";
		document.getElementById("fullContent").value = "";
		clearAlert();
	}

	function openContent(item) {
		if (item.hasPdf) {
			var pdfWindow = window.open("rest/health-education/file?id=" + encodeURIComponent(item.id), "_blank");
			if (!pdfWindow) {
				showAlert("Please allow pop-ups to open the PDF in a new tab.");
			}
			return;
		}

		var doc = "<!DOCTYPE html><html><head><title>" + escapeHtml(item.title) + "</title>" +
			"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">" +
			"<style>body{font-family:Arial,sans-serif;max-width:860px;margin:40px auto;padding:0 20px;line-height:1.65;color:#102033}h1{line-height:1.2}.meta{color:#64748b;font-weight:700;margin-bottom:24px}.content{white-space:pre-wrap}</style>" +
			"</head><body><h1>" + escapeHtml(item.title) + "</h1>" +
			"<div class=\"meta\">" + escapeHtml(item.category) + " | " + escapeHtml(item.language) + " | " + escapeHtml(item.audience) + "</div>" +
			"<div class=\"content\">" + escapeHtml(item.fullContent || item.summary || "No content recorded.") + "</div></body></html>";
		var articleWindow = window.open("", "_blank");
		if (articleWindow) {
			articleWindow.document.open();
			articleWindow.document.write(doc);
			articleWindow.document.close();
		}
	}

	function setLoadingState(message) {
		document.getElementById("contentGrid").innerHTML =
			"<div class=\"empty-state\"><i class=\"bi bi-book\"></i>" + escapeHtml(message) + "</div>";
	}

	function normalizeTags(tags) {
		if (Array.isArray(tags)) return tags;
		return splitTags(tags);
	}

	function renderContent() {
		var grid = document.getElementById("contentGrid");
		var query = document.getElementById("contentSearch").value.trim().toLowerCase();
		var filtered = contentItems.filter(function (item) {
			var haystack = [
				item.title,
				item.category,
				item.summary,
				item.fullContent,
				normalizeTags(item.tags).join(" ")
			].join(" ").toLowerCase();
			return (!activeCategory || item.category === activeCategory) &&
				(!query || haystack.indexOf(query) >= 0);
		});

		grid.innerHTML = "";
		if (!filtered.length) {
			grid.innerHTML = "<div class=\"empty-state\"><i class=\"bi bi-book\"></i>No health content yet</div>";
			return;
		}

		filtered.forEach(function (item) {
			var card = document.createElement("article");
			card.className = "content-card";
			var tags = normalizeTags(item.tags).map(function (tag) {
				return "<span class=\"content-tag\">" + escapeHtml(tag) + "</span>";
			}).join("");
			card.innerHTML =
				"<div class=\"content-top\">" +
					"<div>" +
						"<h2 class=\"content-title\">" + escapeHtml(item.title) + "</h2>" +
						"<div class=\"content-meta mt-2\"><span>" + escapeHtml(item.category) + "</span><span>" + escapeHtml(item.contentType) + "</span></div>" +
					"</div>" +
					"<span class=\"content-icon\"><i class=\"bi " + (item.hasPdf ? "bi-file-earmark-pdf" : "bi-journal-text") + "\"></i></span>" +
				"</div>" +
				"<p class=\"content-summary\">" + escapeHtml(item.summary || "No summary recorded.") + "</p>" +
				"<div class=\"content-meta\"><span>" + escapeHtml(item.language) + "</span><span>" + escapeHtml(item.audience) + "</span></div>" +
				"<div class=\"tag-list\">" + tags + "</div>" +
				"<button class=\"btn btn-outline-primary open-link\" type=\"button\"><i class=\"bi bi-box-arrow-up-right\"></i> " + (item.hasPdf ? "Open PDF" : "Read") + "</button>";
			card.querySelector(".open-link").addEventListener("click", function () {
				openContent(item);
			});
			grid.appendChild(card);
		});
	}

	function fetchContent() {
		setLoadingState("Loading health content...");
		fetch("rest/health-education/list")
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
					contentItems = result.data.content || [];
				} else {
					contentItems = [];
				}
				renderContent();
			})
			.catch(function () {
				contentItems = [];
				renderContent();
			});
	}

	document.getElementById("sidebarToggle").addEventListener("click", function () {
		if (window.matchMedia("(max-width: 880px)").matches) {
			document.body.classList.toggle("sidebar-open");
		} else {
			document.body.classList.toggle("sidebar-collapsed");
		}
	});

	document.getElementById("contentSearch").addEventListener("input", renderContent);
	document.querySelectorAll(".category-tab").forEach(function (tab) {
		tab.addEventListener("click", function () {
			activeCategory = tab.getAttribute("data-category") || "";
			document.querySelectorAll(".category-tab").forEach(function (item) { item.classList.remove("active"); });
			tab.classList.add("active");
			renderContent();
		});
	});

	document.getElementById("saveContentBtn").addEventListener("click", function () {
		clearAlert();
		var title = document.getElementById("contentTitle").value.trim();
		var category = document.getElementById("contentCategory").value;
		var contentType = document.getElementById("contentType").value;
		var fullContent = document.getElementById("fullContent").value.trim();
		var file = document.getElementById("pdfFile").files[0];
		if (!title || !category) {
			showAlert("Title and category are required.");
			return;
		}
		if (!file && !fullContent) {
			showAlert("Add full content or upload a PDF.");
			return;
		}
		if (file && file.type !== "application/pdf" && !/\.pdf$/i.test(file.name)) {
			showAlert("Please upload a PDF file.");
			return;
		}

		var formData = new FormData();
		formData.append("title", title);
		formData.append("category", category);
		formData.append("contentType", contentType);
		formData.append("language", document.getElementById("contentLanguage").value);
		formData.append("audience", document.getElementById("targetAudience").value);
		formData.append("tags", document.getElementById("contentTags").value.trim());
		formData.append("summary", document.getElementById("contentSummary").value.trim());
		formData.append("fullContent", fullContent);
		if (file) formData.append("pdf", file);

		fetch("rest/health-education/save", {
			method: "POST",
			body: formData
		})
			.then(function (response) {
				return response.json().then(function (data) { return { status: response.status, data: data }; });
			})
			.then(function (result) {
				if (result.status === 200 && result.data.success) {
				bootstrap.Modal.getOrCreateInstance(document.getElementById("educationModal")).hide();
				resetForm();
					fetchContent();
				} else {
					showAlert((result.data && result.data.message) || "Unable to save content.");
				}
			})
			.catch(function () {
				showAlert("Unable to reach server.");
			});
	});

	fetchContent();
</script>
</body>
</html>
