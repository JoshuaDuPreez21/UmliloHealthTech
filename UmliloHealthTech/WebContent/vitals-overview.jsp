<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Umlilo HealthTech | Vitals Overview</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
	:root { --ink: #061427; --muted: #64748b; --line: #d9e5ec; --page: #f6f8fb; --sidebar: #0d1b27; --sidebar-soft: #172a3d; --teal: #10bfa6; }
	* { box-sizing: border-box; }
	body { margin: 0; background: var(--page); min-height: 100vh; font-family: "Manrope", "Segoe UI", sans-serif; color: var(--ink); }
	.app-shell { min-height: 100vh; padding-right: 326px; }
	.main-content { padding: 4.5rem 2.2rem; }
	.page-title { font-size: 2rem; font-weight: 800; margin: 0 0 0.35rem; }
	.page-subtitle { color: var(--muted); font-weight: 700; margin: 0; }
	.sidebar { position: fixed; top: 0; right: 0; bottom: 0; width: 326px; background: var(--sidebar); color: #d7e4ee; display: flex; flex-direction: column; }
	.brand-block { height: 136px; display: flex; align-items: center; gap: 0.95rem; padding: 1.45rem 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.08); }
	.brand-mark { width: 46px; height: 46px; border-radius: 14px; background: #0879ad; overflow: hidden; }
	.brand-mark img { width: 100%; height: 100%; object-fit: cover; }
	.brand-title { font-weight: 800; font-size: 1.18rem; color: #fff; }
	.brand-subtitle { color: #95a8b8; font-size: 0.78rem; }
	.nav-menu { padding: 1.35rem 1.1rem; overflow-y: auto; flex: 1 1 auto; }
	.nav-item-link { display: flex; align-items: center; gap: 1rem; min-height: 50px; border-radius: 12px; color: #98a9b6; text-decoration: none; padding: 0 1rem; font-weight: 800; margin-bottom: 0.55rem; }
	.nav-item-link:hover, .nav-item-link.active { background: var(--sidebar-soft); color: #16d6bd; }
	.nav-item-link i { font-size: 1.25rem; width: 24px; text-align: center; }
	.sidebar-footer { padding: 1rem 1.1rem 1.35rem; border-top: 1px solid rgba(255,255,255,0.06); }
	.sign-out { color: #99aab8; text-decoration: none; font-weight: 800; display: flex; align-items: center; gap: 0.8rem; padding: 0.7rem 1rem; border-radius: 12px; }
	@media (max-width: 880px) { .app-shell { padding-right: 0; } .sidebar { display: none; } }
</style>
</head>
<body>
	<aside class="sidebar" aria-label="Nurse workspace menu">
		<div class="brand-block">
			<div class="brand-mark"><img src="img/uht_bg.png" alt="Umlilo HealthTech logo"></div>
			<div><div class="brand-title">Umlilo Health</div><div class="brand-subtitle">Technologies</div></div>
		</div>
		<nav class="nav-menu">
			<a href="home" class="nav-item-link"><i class="bi bi-grid"></i><span>Dashboard</span></a>
			<a href="appointment" class="nav-item-link"><i class="bi bi-people"></i><span>Patients</span></a>
			<a href="current-appointment" class="nav-item-link"><i class="bi bi-diagram-3"></i><span>Patient Flow</span></a>
			<a href="capture-appointment" class="nav-item-link"><i class="bi bi-stethoscope"></i><span>Nurse Workspace</span></a>
			<a href="visits-today" class="nav-item-link"><i class="bi bi-activity"></i><span>Visits Today</span></a>
			<a href="vitals-overview" class="nav-item-link active"><i class="bi bi-heart-pulse"></i><span>Vitals Overview</span></a>
			<a href="referrals" class="nav-item-link"><i class="bi bi-arrow-left-right"></i><span>Referrals</span></a>
			<a href="screening" class="nav-item-link"><i class="bi bi-clipboard2-pulse"></i><span>Screening</span></a>
			<a href="health-education" class="nav-item-link"><i class="bi bi-book"></i><span>Health Education</span></a>
		</nav>
		<div class="sidebar-footer"><a href="logout" class="sign-out"><i class="bi bi-box-arrow-right"></i><span>Sign Out</span></a></div>
	</aside>
	<div class="app-shell">
		<main class="main-content">
			<h1 class="page-title">Vitals Overview</h1>
			<p class="page-subtitle">This page is connected and ready for content.</p>
		</main>
	</div>
</body>
</html>
