# 🏡 Sistema de Gestión de Residentes y Cuidadores de una Casa Hogar / Adultos Mayores

Este proyecto consiste en la creación y manipulación de una base de datos relacional utilizando SQLite para gestionar información de residentes y cuidadores en una institución.

---

## 📁 Estructura del Proyecto
bc-sql/
│
├── week-01-introduccion_bases_de_datos_relacionales
├──────starter
├─────────mi_dominio.db
├─────────proyecto.sql
├─────────sqlite3
└──────README.md # Documentación del proyecto

---

## 🛠️ Tecnologías Utilizadas

- SQLite3
- SQL (Structured Query Language)
- Terminal / Bash
- Visual Studio Code

---

## 🧱 Estructura de la Base de Datos

### Tabla: `residents`

Contiene la información de los residentes.

| Campo                  | Tipo    | Descripción                  |
|------------------------|--------|------------------------------|
| id_resident            | INTEGER | Identificador único          |
| name_resident          | TEXT    | Nombre del residente         |
| age_resident           | INTEGER | Edad                         |
| room_resident          | TEXT    | Número de habitación         |
| entry_date_resident    | DATE    | Fecha de ingreso             |

---

### Tabla: `caregivers`

Contiene la información de los cuidadores.

| Campo               | Tipo    | Descripción                  |
|---------------------|--------|------------------------------|
| id_caregiver        | INTEGER | Identificador único          |
| name_caregiver      | TEXT    | Nombre del cuidador          |
| turno_caregiver     | TEXT    | Turno (Día, Tarde, Noche)    |
| email_caregiver     | TEXT    | Correo electrónico           |
| phone_caregiver     | TEXT    | Teléfono                     |

---

## 📥 Inserción de Datos

El archivo `proyecto.sql` incluye datos de ejemplo para ambas tablas mediante sentencias `INSERT`.

### 1. INSERT tabla residents
INSERT INTO residents (name_resident, age_resident, room_resident, entry_date_resident) VALUES
('María López', 78, '101A', '2024-01-10'),
('Carlos Pérez', 82, '102B', '2023-11-05'),
('Ana Gómez', 75, '103A', '2024-02-20'),
('Luis Torres', 80, '104C', '2023-12-15'),
('Rosa Martínez', 77, '105B', '2024-03-01');

### 2. INSERT tabla caregivers
INSERT INTO caregivers (name_caregiver, turno_caregiver, email_caregiver, phone_caregiver) VALUES
('Juan Rodríguez', 'Día', 'juan.rodriguez@email.com', '3001234567'),
('Laura Sánchez', 'Noche', 'laura.sanchez@email.com', '3007654321'),
('Pedro Ramírez', 'Día', 'pedro.ramirez@email.com', '3011111111'),
('Sofía Herrera', 'Tarde', 'sofia.herrera@email.com', '3022222222'),
('Miguel Castro', 'Noche', 'miguel.castro@email.com', '3033333333');

---

## 🔍 Consultas Implementadas

```sql
### 1. Mostrar todos los residentes
SELECT * FROM residents;

## 2. Mostrar solo el nombre de los residentes ordenados alfabéticamente

SELECT name_resident, age_resident
FROM   residents
ORDER BY name_resident DESC;

## 3. Contar cuántos residentes tiene en total

SELECT COUNT(*) AS total_residents
FROM   residents;
