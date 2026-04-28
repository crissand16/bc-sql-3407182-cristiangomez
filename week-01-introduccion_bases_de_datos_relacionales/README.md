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

---

## 🔍 Consultas Implementadas

### 1. Mostrar todos los residentes

```sql
SELECT * FROM residents;

## 2. Mostrar solo el nombre de los residentes ordenados alfabéticamente

SELECT name_resident, age_resident
FROM   residents
ORDER BY name_resident DESC;

## 3. Contar cuántos residentes tiene en total

SELECT COUNT(*) AS total_residents
FROM   residents;
