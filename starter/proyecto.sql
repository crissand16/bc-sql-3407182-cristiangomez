DROP TABLE IF EXISTS residents;
DROP TABLE IF EXISTS caregivers;
DROP TABLE IF EXISTS health_records;
DROP TABLE IF EXISTS activities;



-- CREACION DE TABLAS

CREATE TABLE IF NOT EXISTS residents (
    id_resident              INTEGER PRIMARY KEY,
    name_resident            TEXT    NOT NULL,
    document_id_resident     TEXT    NOT NULL UNIQUE,
    birth_date_resident      DATE    NOT NULL,
    gender_resident          TEXT CHECK (gender_resident IN ('M', 'F', 'Other')),
    admission_date_resident  DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active                INTEGER NOT NULL DEFAULT 1
);


CREATE TABLE IF NOT EXISTS caregivers (
    id_caregiver         INTEGER PRIMARY KEY,
    name_caregiver       TEXT    NOT NULL,
    email_caregiver      TEXT    UNIQUE,
    phone_caregiver      TEXT,
    turno_caregiver      TEXT NOT NULL CHECK (
        turno_caregiver IN ('morning', 'afternoon', 'night')
    ),
    hire_date_caregiver  DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active            INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1))
);


CREATE TABLE IF NOT EXISTS health_records (
    id              INTEGER PRIMARY KEY,
    resident_id     INTEGER NOT NULL,
    record_date     DATE NOT NULL DEFAULT CURRENT_DATE,
    diagnosis       TEXT NOT NULL,
    treatment       TEXT,
    notes           TEXT,
    vital_status    TEXT CHECK (
        vital_status IN ('stable', 'critical', 'under observation')
    ),
    is_active       INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1)),

    FOREIGN KEY (resident_id)
        REFERENCES residents(id_resident)
);


CREATE TABLE IF NOT EXISTS activities (
    id_activity         INTEGER PRIMARY KEY,
    resident_id         INTEGER NOT NULL,
    activity_name       TEXT NOT NULL,
    activity_date       DATE NOT NULL DEFAULT CURRENT_DATE,
    activity_type       TEXT CHECK (
        activity_type IN ('physical', 'recreational', 'medical', 'social')
    ),
    activity_status     TEXT CHECK (
        activity_status IN ('completed', 'pending', 'cancelled')
    ),
    observations        TEXT,

    FOREIGN KEY (resident_id)
        REFERENCES residents(id_resident)
);


-- INSERTAR DATOS 

INSERT INTO residents (
    id_resident,
    name_resident,
    document_id_resident,
    birth_date_resident,
    gender_resident
)
VALUES
    (1, 'Carlos Pérez', 'CC1001', '1945-03-12', 'M'),
    (2, 'María Gómez', 'CC1002', '1950-07-25', 'F'),
    (3, 'Luis Rodríguez', 'CC1003', '1938-11-02', 'M'),
    (4, 'Ana Martínez', 'CC1004', '1948-05-19', 'F'),
    (5, 'Jorge Ramírez', 'CC1005', '1942-09-30', 'M');



INSERT INTO caregivers (
    id_caregiver,
    name_caregiver,
    email_caregiver,
    phone_caregiver,
    turno_caregiver
)
VALUES
    (1, 'Laura Torres', 'laura@email.com', '3001111111', 'morning'),
    (2, 'Pedro Sánchez', 'pedro@email.com', '3002222222', 'afternoon'),
    (3, 'Camila Díaz', 'camila@email.com', '3003333333', 'night'),
    (4, 'Andrés López', 'andres@email.com', '3004444444', 'morning'),
    (5, 'Sofía Herrera', 'sofia@email.com', '3005555555', 'afternoon');


INSERT INTO health_records (
    id,
    resident_id,
    diagnosis,
    treatment,
    vital_status
)
VALUES
    (1, 1, 'Hipertensión', 'Medicamentos antihipertensivos', 'stable'),
    (2, 2, 'Diabetes', 'Insulina diaria', 'under observation'),
    (3, 3, 'Artritis', 'Terapia física', 'stable'),
    (4, 4, 'Neumonía', 'Antibióticos', 'critical'),
    (5, 5, 'Problemas cardíacos', 'Control médico constante', 'under observation');


INSERT INTO activities (
    id_activity,
    resident_id,
    activity_name,
    activity_date,
    activity_type,
    activity_status,
    observations
)
VALUES
    (1, 1, 'Caminata matutina', '2026-05-01', 'physical', 'completed',
     'Participó activamente'),

    (2, 2, 'Terapia ocupacional', '2026-05-02', 'medical', 'completed',
     'Mostró mejoría'),

    (3, 3, 'Juego de mesa grupal', '2026-05-03', 'recreational', 'pending',
     'Pendiente por lluvia'),

    (4, 4, 'Chequeo médico', '2026-05-04', 'medical', 'completed',
     'Sin novedades'),

    (5, 5, 'Actividad social', '2026-05-05', 'social', 'cancelled',
     'Cancelada por mantenimiento');



-- REPORTE 1: Totales globales
SELECT
    COUNT(*) AS total_registros,
    SUM(is_active) AS residentes_activos,
    AVG(
        CAST(
            (julianday('now') - julianday(birth_date_resident)) / 365
            AS INTEGER
        )
    ) AS promedio_edad
FROM residents;


-- REPORTE 2: Extremos
SELECT
    MIN(
        CAST(
            (julianday('now') - julianday(birth_date_resident)) / 365
            AS INTEGER
        )
    ) AS edad_minima,
    
    MAX(
        CAST(
            (julianday('now') - julianday(birth_date_resident)) / 365
            AS INTEGER
        )
    ) AS edad_maxima
FROM residents;


-- REPORTE 3: Subtotales por categoría (GROUP BY)
SELECT
    activity_type,
    COUNT(*) AS total,
    AVG(resident_id) AS promedio_residentes
FROM activities
GROUP BY activity_type
ORDER BY total DESC;


-- REPORTE 4: Filtro de grupos (HAVING)  
SELECT
    vital_status,
    COUNT(*) AS total
FROM health_records
GROUP BY vital_status
HAVING COUNT(*) > 1;
