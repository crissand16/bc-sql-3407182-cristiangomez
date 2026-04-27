--Crea Tabla Residentes.
CREATE TABLE residents (
    id_resident         INTEGER PRIMARY KEY,
    name_resident       TEXT NOT NULL,
    age_resident        INTEGER,
    room_resident       TEXT,
    entry_date_resident DATE
);

--Crea Tabla Cuidadores
CREATE TABLE caregivers (
    id_caregiver         INTEGER PRIMARY KEY,
    name_caregiver       TEXT    NOT NULL,
    turno_caregiver      TEXT,
    email_caregiver      TEXT,
    phone_caregiver      TEXT
);

--Insertamos datos en la tabla residentes
INSERT INTO residents (id_resident, name_resident, age_resident, room_resident, entry_date_resident) VALUES
(1, 'María López', 78, '101A', '2024-01-10'),
(2, 'Carlos Pérez', 82, '102B', '2023-11-05'),
(3, 'Ana Gómez', 75, '103A', '2024-02-20'),
(4, 'Luis Torres', 80, '104C', '2023-12-15'),
(5, 'Rosa Martínez', 77, '105B', '2024-03-01');

--Insertamos datos en la tabla Cuidadores
INSERT INTO carevigers (id_caregiver, name_caregiver, turno_caregiver, email_caregiver, phone_caregiver) VALUES
(1, 'Juan Rodríguez', 'Día', 'juan.rodriguez@email.com', '3001234567'),
(2, 'Laura Sánchez', 'Noche', 'laura.sanchez@email.com', '3007654321'),
(3, 'Pedro Ramírez', 'Día', 'pedro.ramirez@email.com', '3011111111'),
(4, 'Sofía Herrera', 'Tarde', 'sofia.herrera@email.com', '3022222222'),
(5, 'Miguel Castro', 'Noche', 'miguel.castro@email.com', '3033333333');

--Mostrar todos los residentes con todas sus columnas
SELECT *
FROM   residents;

--Mostrar solo el nombre de los residentes ordenados alfabéticamente
SELECT ...
FROM   residents
ORDER BY ...;

--Contar cuántos items tienes en total
SELECT COUNT(*) AS total_residents
FROM   residents;