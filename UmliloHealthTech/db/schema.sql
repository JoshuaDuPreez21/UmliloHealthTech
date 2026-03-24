CREATE TABLE IF NOT EXISTS users (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	staff_id VARCHAR(50) NOT NULL UNIQUE,
	full_name VARCHAR(120) NOT NULL,
	role VARCHAR(30) NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS otp_bypass (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	staff_id VARCHAR(50) NOT NULL,
	active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	UNIQUE KEY uk_otp_bypass_staff (staff_id)
);

CREATE TABLE IF NOT EXISTS otp_tokens (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	staff_id VARCHAR(50) NOT NULL,
	otp_code VARCHAR(10) NOT NULL,
	used TINYINT(1) NOT NULL DEFAULT 0,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	expires_at TIMESTAMP NOT NULL,
	INDEX idx_otp_staff (staff_id),
	INDEX idx_otp_expires (expires_at)
);

CREATE TABLE IF NOT EXISTS patients (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(80) NOT NULL,
	surname VARCHAR(80) NOT NULL,
	id_number VARCHAR(20),
	cell VARCHAR(30) NOT NULL,
	gender VARCHAR(20),
	address VARCHAR(255),
	email VARCHAR(120),
	employment_status VARCHAR(40),
	job_title VARCHAR(80),
	next_of_kin_name VARCHAR(120),
	next_of_kin_relation VARCHAR(60),
	emergency_contact VARCHAR(30),
	is_south_african TINYINT(1) NOT NULL DEFAULT 1,
	nationality VARCHAR(80),
	foreign_id VARCHAR(40),
	illnesses TEXT,
	illness_notes TEXT,
	consent TINYINT(1) NOT NULL DEFAULT 0,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS appointments (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	patient_id BIGINT NOT NULL,
	appointment_time DATETIME NOT NULL,
	status VARCHAR(30) NOT NULL,
	nurse_name VARCHAR(120),
	doctor_name VARCHAR(120),
	visit_summary TEXT,
	nurse_notes TEXT,
	prescription TEXT,
	doctor_summary TEXT,
	additional_notes TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_appt_patient (patient_id),
	CONSTRAINT fk_appt_patient FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE IF NOT EXISTS appointment_attachments (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	appointment_id BIGINT NOT NULL,
	original_name VARCHAR(255) NOT NULL,
	stored_name VARCHAR(255) NOT NULL,
	content_type VARCHAR(120),
	file_size BIGINT,
	uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_appt_attach (appointment_id),
	CONSTRAINT fk_attachment_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);
