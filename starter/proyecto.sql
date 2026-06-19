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

WITH RECURSIVE numeros(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM numeros
    WHERE n < 80
)

INSERT INTO residents (
    name_resident,
    document_id_resident,
    birth_date_resident,
    gender_resident
)
SELECT
    'Residente ' || n,
    'DOC' || printf('%04d', n),
    date('1950-01-01', '+' || n || ' day'),
    CASE
        WHEN n % 2 = 0 THEN 'M'
        ELSE 'F'
    END
FROM numeros;


----------------------------- 20 CUIDADORES ----------------------------------------
WITH RECURSIVE numeros(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM numeros
    WHERE n < 20
)

INSERT INTO caregivers (
    name_caregiver,
    email_caregiver,
    phone_caregiver,
    turno_caregiver
)
SELECT
    'Cuidador ' || n,

    CASE
        WHEN n % 4 = 0 THEN NULL
        ELSE 'cuidador' || n || '@hogar.com'
    END,

    '300' || printf('%07d', n),

    CASE
        WHEN n % 3 = 0 THEN 'night'
        WHEN n % 2 = 0 THEN 'afternoon'
        ELSE 'morning'
    END
FROM numeros;


-- 60 HISTORIALES MEDICOS 
WITH RECURSIVE numeros(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM numeros
    WHERE n < 60
)

INSERT INTO health_records (
    resident_id,
    diagnosis,
    treatment,
    notes,
    vital_status
)
SELECT
    n,

    CASE
        WHEN n % 3 = 0 THEN 'Diabetes'
        WHEN n % 2 = 0 THEN 'Hipertension'
        ELSE 'Artritis'
    END,

    CASE
        WHEN n % 5 = 0 THEN NULL
        ELSE 'Tratamiento estandar'
    END,

    CASE
        WHEN n % 4 = 0 THEN NULL
        ELSE 'Seguimiento mensual'
    END,

    CASE
        WHEN n % 3 = 0 THEN 'critical'
        WHEN n % 2 = 0 THEN 'under observation'
        ELSE 'stable'
    END

FROM numeros;


-- 50 ACTIVIDADES 
WITH RECURSIVE numeros(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM numeros
    WHERE n < 50
)

INSERT INTO activities (
    resident_id,
    activity_name,
    activity_type,
    activity_status,
    observations
)
SELECT
    n,

    CASE
        WHEN n % 4 = 0 THEN 'Yoga'
        WHEN n % 3 = 0 THEN 'Terapia'
        WHEN n % 2 = 0 THEN 'Lectura'
        ELSE 'Caminata'
    END,

    CASE
        WHEN n % 4 = 0 THEN 'physical'
        WHEN n % 3 = 0 THEN 'medical'
        WHEN n % 2 = 0 THEN 'recreational'
        ELSE 'social'
    END,

    CASE
        WHEN n % 3 = 0 THEN 'completed'
        WHEN n % 2 = 0 THEN 'pending'
        ELSE 'cancelled'
    END,

    CASE
        WHEN n % 5 = 0 THEN NULL
        ELSE 'Actividad realizada correctamente'
    END

FROM numeros;


-- ================================================================
-- CONSULTAS
-- ================================================================

--Consulta 1- INNER JOIN
SELECT
    r.id_resident,
    r.name_resident,
    hr.diagnosis,
    hr.vital_status
FROM residents r
INNER JOIN health_records hr
ON r.id_resident = hr.resident_id;


--Consulta 2- JOIN DE TRES TABLAS
SELECT
    r.name_resident,
    hr.diagnosis,
    a.activity_name,
    a.activity_status
FROM residents r
INNER JOIN health_records hr
    ON r.id_resident = hr.resident_id
INNER JOIN activities a
    ON r.id_resident = a.resident_id;


--Consulta 3- LEFT JOIN
SELECT
    r.id_resident,
    r.name_resident,
    a.activity_name
FROM residents r
LEFT JOIN activities a
ON r.id_resident = a.resident_id;


--Consulta 4- HUERFANOS
SELECT
    r.id_resident,
    r.name_resident
FROM residents r
LEFT JOIN activities a
ON r.id_resident = a.resident_id
WHERE a.id_activity IS NULL;


--Consulta 5- REPORTE AGREGADO
SELECT
    r.id_resident,
    r.name_resident,
    COUNT(a.id_activity) AS total_actividades
FROM residents r
LEFT JOIN activities a
ON r.id_resident = a.resident_id
GROUP BY
    r.id_resident,
    r.name_resident
ORDER BY total_actividades DESC;


