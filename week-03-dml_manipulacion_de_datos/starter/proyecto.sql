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
    id              INTEGER PRIMARY KEY,
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
INSERT INTO health_records (id, resident_id, diagnosis, treatment, vital_status)
VALUES
    (1, 1, 'Hipertensión', 'Medicamentos antihipertensivos', 'stable'),
    (2, 2, 'Diabetes', 'Insulina diaria', 'under observation'),
    (3, 3, 'Artritis', 'Terapia física', 'stable'),
    (4, 4, 'Neumonía', 'Antibióticos', 'critical'),
    (5, 5, 'Problemas cardíacos', 'Control médico constante', 'under observation');



-- Actualizar una columna por PK
UPDATE residents
SET name_resident = 'Carlos Rodriguez'
WHERE id_resident = 1;

-- Actualizar múltiples columnas de una fila
UPDATE caregivers
SET phone_caregiver = '3009999999',
    turno_caregiver = 'night'
WHERE id_caregiver = 2;

-- Actualizar múltiples filas (regla de negocio)
UPDATE residents
SET is_active = 0
WHERE birth_date_resident < '1945-01-01';

-- Verificar qué registros se eliminarán
SELECT id, resident_id, diagnosis
FROM health_records
WHERE vital_status = 'critical';

-- Eliminar esos registros
DELETE FROM health_records
WHERE vital_status = 'critical';


SELECT id_resident, name_resident, document_id_resident, birth_date_resident, gender_resident, admission_date_resident FROM residents ORDER BY id_resident;
SELECT id_caregiver, name_caregiver, email_caregiver, phone_caregiver, turno_caregiver, hire_date_caregiver FROM caregivers ORDER BY id_caregiver;
SELECT resident_id, record_date, diagnosis, treatment, notes, vital_status FROM health_records ORDER BY id;