
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


--PARA VER TABLAS

--PRAGMA table_info(residents);
--PRAGMA table_info(caregivers);
--PRAGMA table_info(health_records);

