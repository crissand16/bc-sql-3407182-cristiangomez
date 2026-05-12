--Eliminamos las tablas para evitar errores de duplicacion de datos
DROP TABLE IF EXISTS residents;
DROP TABLE IF EXISTS caregivers;


--Crea Tabla Residentes.
CREATE TABLE IF NOT EXISTS residents (
    id_resident         INTEGER PRIMARY KEY,
    name_resident       TEXT NOT NULL,
    age_resident        INTEGER,
    room_resident       TEXT,
    entry_date_resident DATE
);

--Crea Tabla Cuidadores
CREATE TABLE IF NOT EXISTS caregivers (
    id_caregiver         INTEGER PRIMARY KEY,
    name_caregiver       TEXT    NOT NULL,
    turno_caregiver      TEXT,
    email_caregiver      TEXT,
    phone_caregiver      TEXT
);

--Insertamos datos en la tabla residentes
INSERT INTO residents (name_resident, age_resident, room_resident, entry_date_resident) VALUES
('María López', 78, '101A', '2024-01-10'),
('Carlos Pérez', 82, '102B', '2023-11-05'),
('Ana Gómez', 75, '103A', '2024-02-20'),
('Luis Torres', 80, '104C', '2023-12-15'),
('Rosa Martínez', 77, '105B', '2024-03-01');

--Insertamos datos en la tabla Cuidadores
INSERT INTO caregivers (name_caregiver, turno_caregiver, email_caregiver, phone_caregiver) VALUES
('Juan Rodríguez', 'Día', 'juan.rodriguez@email.com', '3001234567'),
('Laura Sánchez', 'Noche', 'laura.sanchez@email.com', '3007654321'),
('Pedro Ramírez', 'Día', 'pedro.ramirez@email.com', '3011111111'),
('Sofía Herrera', 'Tarde', 'sofia.herrera@email.com', '3022222222'),
('Miguel Castro', 'Noche', 'miguel.castro@email.com', '3033333333');

--Mostrar todos los residentes con todas sus columnas
SELECT *
FROM   residents;

--Mostrar solo el nombre de los residentes ordenados alfabéticamente
SELECT name_resident, age_resident
FROM   residents
ORDER BY name_resident DESC;

--Contar cuántos residentes tiene en total
SELECT COUNT(*) AS total_residents
FROM   residents;