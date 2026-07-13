CREATE TABLE IF NOT EXISTS users (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	staff_id VARCHAR(50) NOT NULL UNIQUE,
	full_name VARCHAR(120) NOT NULL,
	role VARCHAR(30) NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

CREATE TABLE IF NOT EXISTS patient_lab_results (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	patient_id BIGINT NOT NULL,
	result_date DATETIME NOT NULL,
	test_name VARCHAR(160) NOT NULL,
	result_value VARCHAR(255),
	status VARCHAR(40),
	ordered_by VARCHAR(120),
	notes TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_lab_patient (patient_id),
	CONSTRAINT fk_lab_patient FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE IF NOT EXISTS patient_screenings (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	patient_id BIGINT NOT NULL,
	form_type VARCHAR(120) NOT NULL,
	screening_date DATE NOT NULL,
	result VARCHAR(40),
	screened_by VARCHAR(120),
	action_taken VARCHAR(255),
	followup_required TINYINT(1) NOT NULL DEFAULT 0,
	notes TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_screening_patient (patient_id),
	INDEX idx_screening_type (form_type),
	CONSTRAINT fk_screening_patient FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE IF NOT EXISTS health_education_content (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(180) NOT NULL,
	category VARCHAR(80) NOT NULL,
	content_type VARCHAR(40) NOT NULL,
	language VARCHAR(40),
	target_audience VARCHAR(80),
	tags VARCHAR(255),
	summary TEXT,
	full_content TEXT,
	original_file_name VARCHAR(255),
	stored_file_name VARCHAR(255),
	content_type_file VARCHAR(120),
	file_size BIGINT,
	created_by VARCHAR(120),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_health_category (category),
	INDEX idx_health_title (title)
);
