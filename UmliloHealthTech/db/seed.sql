INSERT INTO users (staff_id, full_name, role, password_hash, active)
VALUES
('NUR-1024', 'Thandi Mthembu', 'nurse', 'oAYC1dR81YRVWeUc0e9D0g==:KI8f7GaU+OVJXinsvDI0AQ+gjxTbbvH1c4r6FC7zE7U=', 1),
('DR-2048', 'Dr. Naidoo', 'doctor', 'oAYC1dR81YRVWeUc0e9D0g==:KI8f7GaU+OVJXinsvDI0AQ+gjxTbbvH1c4r6FC7zE7U=', 1);

INSERT INTO patients (first_name, surname, id_number, cell, gender, address, email, employment_status, job_title,
next_of_kin_name, next_of_kin_relation, emergency_contact, is_south_african, nationality, foreign_id, illnesses, illness_notes, consent)
VALUES
('Lerato', 'Mokoena', '9001011234567', '0715559876', 'Female', '12 Main Street, Johannesburg', 'lerato.mokoena@example.com',
'Employed', 'Administrator', 'K. Mokoena', 'Parent', '0723334444', 1, 'South Africa', NULL, 'Hypertension', 'Monitoring BP', 1);

INSERT INTO appointments (patient_id, appointment_time, status, nurse_name, doctor_name, visit_summary)
VALUES
(1, '2026-03-24 09:30:00', 'NEW', 'Thandi Mthembu', NULL, 'Initial intake notes.'),
(1, '2026-03-24 11:00:00', 'WAITING', 'Thandi Mthembu', NULL, 'Vitals captured.'),
(1, '2026-03-24 14:15:00', 'COMPLETED', 'Thandi Mthembu', 'Dr. Naidoo', 'Follow-up completed.');
