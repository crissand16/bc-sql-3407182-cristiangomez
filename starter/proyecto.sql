-- ============================================
-- PROYECTO SEMANAL: NULL y Constraints
-- Dominio: Casa Hogar / Adultos Mayores
-- ============================================

PRAGMA foreign_keys = ON;

-- ============================================
-- ELIMINAR TABLAS SI EXISTEN
-- ============================================

DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS health_records;
DROP TABLE IF EXISTS caregivers;
DROP TABLE IF EXISTS residents;

-- ============================================
-- TABLA RESIDENTS
-- ============================================

CREATE TABLE IF NOT EXISTS residents (
    id_resident              INTEGER PRIMARY KEY,
    name_resident            TEXT    NOT NULL,
    document_id_resident     TEXT    NOT NULL UNIQUE,
    birth_date_resident      DATE    NOT NULL,

    gender_resident          TEXT CHECK (
        gender_resident IN ('M', 'F', 'Other')
    ),

    admission_date_resident  DATE NOT NULL DEFAULT CURRENT_DATE,

    is_active                INTEGER NOT NULL DEFAULT 1
);

-- ============================================
-- TABLA CAREGIVERS
-- ============================================

CREATE TABLE IF NOT EXISTS caregivers (
    id_caregiver         INTEGER PRIMARY KEY,

    name_caregiver       TEXT    NOT NULL,

    email_caregiver      TEXT UNIQUE,

    phone_caregiver      TEXT,

    turno_caregiver      TEXT NOT NULL CHECK (
        turno_caregiver IN ('morning', 'afternoon', 'night')
    ),

    hire_date_caregiver  DATE NOT NULL DEFAULT CURRENT_DATE,

    is_active            INTEGER NOT NULL DEFAULT 1 CHECK (
        is_active IN (0,1)
    )
);

-- ============================================
-- TABLA HEALTH_RECORDS
-- ============================================

CREATE TABLE IF NOT EXISTS health_records (
    id              INTEGER PRIMARY KEY,

    resident_id     INTEGER NOT NULL,

    record_date     DATE NOT NULL DEFAULT CURRENT_DATE,

    diagnosis       TEXT NOT NULL,

    treatment       TEXT,

    notes           TEXT,

    vital_status    TEXT CHECK (
        vital_status IN (
            'stable',
            'critical',
            'under observation'
        )
    ),

    is_active       INTEGER NOT NULL DEFAULT 1 CHECK (
        is_active IN (0,1)
    ),

    FOREIGN KEY (resident_id)
        REFERENCES residents(id_resident)
);

-- ============================================
-- TABLA ACTIVITIES
-- ============================================

CREATE TABLE IF NOT EXISTS activities (
    id_activity         INTEGER PRIMARY KEY,

    resident_id         INTEGER NOT NULL,

    activity_name       TEXT NOT NULL,

    activity_date       DATE NOT NULL DEFAULT CURRENT_DATE,

    activity_type       TEXT CHECK (
        activity_type IN (
            'physical',
            'recreational',
            'medical',
            'social'
        )
    ),

    activity_status     TEXT CHECK (
        activity_status IN (
            'completed',
            'pending',
            'cancelled'
        )
    ),

    observations        TEXT,

    FOREIGN KEY (resident_id)
        REFERENCES residents(id_resident)
);

-- ============================================
-- INSERTAR DATOS DE PRUEBA
-- ============================================

-- Residents
INSERT INTO residents
(name_resident, document_id_resident, birth_date_resident, gender_resident)
VALUES
('María López', '1001', '1946-05-10', 'F'),
('Carlos Pérez', '1002', '1942-09-15', 'M'),
('Ana Gómez', '1003', '1949-12-20', 'F');

-- Caregivers
INSERT INTO caregivers
(name_caregiver, email_caregiver, phone_caregiver, turno_caregiver)
VALUES
('Juan Rodríguez', 'juan@email.com', '3001234567', 'morning'),
('Laura Sánchez', NULL, '3007654321', 'night'),
('Pedro Ramírez', NULL, '3011111111', 'afternoon');

-- Health Records
INSERT INTO health_records
(resident_id, diagnosis, treatment, notes, vital_status)
VALUES
(1, 'Hipertensión', 'Medicamentos diarios', NULL, 'stable'),
(2, 'Artritis', NULL, 'Dolor moderado', 'under observation'),
(3, 'Diabetes', NULL, NULL, 'critical');

-- Activities
INSERT INTO activities
(resident_id, activity_name, activity_type, activity_status, observations)
VALUES
(1, 'Yoga', 'physical', 'completed', NULL),
(2, 'Lectura', 'recreational', 'pending', NULL),
(3, 'Terapia', 'medical', 'completed', 'Buena participación');

-- ============================================
-- CONSULTAS CON NULL
-- ============================================

-- Mostrar cuidadores sin correo
SELECT
    id_caregiver,
    name_caregiver
FROM caregivers
WHERE email_caregiver IS NULL;

-- Mostrar historiales médicos sin tratamiento
SELECT
    diagnosis,
    treatment
FROM health_records
WHERE treatment IS NULL;

-- Mostrar actividades sin observaciones
SELECT
    activity_name,
    observations
FROM activities
WHERE observations IS NULL;

-- ============================================
-- CONSULTAS CON COALESCE
-- ============================================

-- Reemplazar NULL en email
SELECT
    name_caregiver,
    COALESCE(email_caregiver, 'Sin correo') AS email
FROM caregivers;

-- Reemplazar NULL en tratamiento
SELECT
    diagnosis,
    COALESCE(treatment, 'Sin tratamiento asignado') AS treatment
FROM health_records;

-- Reemplazar NULL en observaciones
SELECT
    activity_name,
    COALESCE(observations, 'Sin observaciones') AS observations
FROM activities;

-- ============================================
-- CONSULTAS EXTRA
-- ============================================

-- Contar residentes
SELECT COUNT(*) AS total_residents
FROM residents;

-- Mostrar residentes activos
SELECT
    name_resident,
    is_active
FROM residents
WHERE is_active = 1;


