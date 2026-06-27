DROP TABLE IF EXISTS residents;
DROP TABLE IF EXISTS caregivers;

CREATE TABLE IF NOT EXISTS residents (
    id_resident            INTEGER PRIMARY KEY,
    name_resident       TEXT    NOT NULL,
    document_id_resident     TEXT    NOT NULL UNIQUE, -- identificación única
    birth_date_resident      DATE    NOT NULL,
    gender_resident        TEXT CHECK (gender_resident IN ('M', 'F', 'Other')),
    admission_date_resident DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active       INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS caregivers (
    id_caregiver           INTEGER PRIMARY KEY,
    name_caregiver      TEXT    NOT NULL,
    email_caregiver           TEXT    UNIQUE,
    phone_caregiver           TEXT,
    turno_caregiver          TEXT    NOT NULL CHECK (turno_caregiver IN ('morning', 'afternoon', 'night')),
    hire_date_caregiver       DATE    NOT NULL DEFAULT CURRENT_DATE,
    is_active       INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1))
);

CREATE TABLE IF NOT EXISTS health_records (
    id_health_record            INTEGER PRIMARY KEY,
    resident_id     INTEGER NOT NULL,
    record_date     DATE    NOT NULL DEFAULT CURRENT_DATE,
    diagnosis       TEXT    NOT NULL,
    treatment       TEXT,
    notes           TEXT,
    vital_status    TEXT    CHECK (vital_status IN ('stable', 'critical', 'under observation')),
    is_active       INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1)),
    FOREIGN KEY (resident_id) REFERENCES residents(id)
);


-- INSERTAR EN TABLA PADRE: residents
INSERT INTO residents (id_resident, name_resident, document_id_resident, birth_date_resident, gender_resident)
VALUES
    (1, 'Carlos Pérez', 'CC1001', '1945-03-12', 'M'),
    (2, 'María Gómez', 'CC1002', '1950-07-25', 'F'),
    (3, 'Luis Rodríguez', 'CC1003', '1938-11-02', 'M'),
    (4, 'Ana Martínez', 'CC1004', '1948-05-19', 'F'),
    (5, 'Jorge Ramírez', 'CC1005', '1942-09-30', 'M');


-- INSERTAR EN OTRA TABLA PADRE: caregivers
INSERT INTO caregivers (id_caregiver, name_caregiver, email_caregiver, phone_caregiver, turno_caregiver)
VALUES
    (1, 'Laura Torres', 'laura@email.com', '3001111111', 'morning'),
    (2, 'Pedro Sánchez', 'pedro@email.com', '3002222222', 'afternoon'),
    (3, 'Camila Díaz', 'camila@email.com', '3003333333', 'night'),
    (4, 'Andrés López', 'andres@email.com', '3004444444', 'morning'),
    (5, 'Sofía Herrera', 'sofia@email.com', '3005555555', 'afternoon');


-- INSERTAR EN TABLA HIJO: health_records (respeta FK con residents)
INSERT INTO health_records (id_health_record, resident_id, diagnosis, treatment, vital_status)
VALUES
    (1, 1, 'Hipertensión', 'Medicamentos antihipertensivos', 'stable'),
    (2, 2, 'Diabetes', 'Insulina diaria', 'under observation'),
    (3, 3, 'Artritis', 'Terapia física', 'stable'),
    (4, 4, 'Neumonía', 'Antibióticos', 'critical'),
    (5, 5, 'Problemas cardíacos', 'Control médico constante', 'under observation');

-- ============================================
-- CONSULTA 1: Listado general con columnas explícitas

SELECT
    id_resident AS id_residente,
    name_resident AS nombre_residente,
    document_id_resident AS documento,
    birth_date_resident AS fecha_nacimiento,
    gender_resident AS genero
FROM residents;


-- ============================================
-- CONSULTA 2: Filtro por condición simple

SELECT
    id_health_record,
    resident_id,
    diagnosis,
    vital_status
FROM health_records
WHERE diagnosis = 'Diabetes';


-- ============================================
-- CONSULTA 3: Filtro combinado (AND / OR)

SELECT
    id_health_record,
    resident_id,
    diagnosis,
    vital_status
FROM health_records
WHERE vital_status = 'stable'
  AND is_active = 1;


-- ============================================
-- CONSULTA 4: Top-N con ORDER BY + LIMIT

SELECT
    id_resident,
    name_resident,
    admission_date_resident
FROM residents
ORDER BY admission_date_resident DESC
LIMIT 5;


-- ============================================
-- CONSULTA 5: Paginación (página 1 y página 2)

-- Página 1
SELECT
    id_resident,
    name_resident,
    gender_resident
FROM residents
ORDER BY name_resident ASC
LIMIT 3 OFFSET 0;


-- Página 2
SELECT
    id_resident,
    name_resident,
    gender_resident
FROM residents
ORDER BY name_resident ASC
LIMIT 3 OFFSET 3;
