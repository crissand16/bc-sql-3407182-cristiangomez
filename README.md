# 🏡 Sistema de Gestión Casa Hogar/Adultos Mayores

Este proyecto consiste en la creación y manipulación de una base de datos en **SQLite3** para la administración.

La base de datos permite gestionar:

- Residentes
- Cuidadores
- Historiales médicos
- Actividades realizadas por los residentes

---

# 📂 Tecnologías utilizadas

- SQLite3
- SQL

---

# 🗄️ Estructura de la Base de Datos

El sistema está compuesto por 4 tablas principales:

## 1. residents

Almacena la información de los residentes del geriátrico.

| Campo                   | Tipo    | Descripción            |
|-------------------------|---------|------------------------|
| id_resident             | INTEGER | Identificador único    |
| name_resident           | TEXT    | Nombre del residente   |
| document_id_resident    | TEXT    | Documento de identidad |
| birth_date_resident     | DATE    | Fecha de nacimiento    |
| gender_resident         | TEXT    | Género                 |
| admission_date_resident | DATE    | Fecha de ingreso       |
| is_active               | INTEGER | Estado activo          |

---

## 2. caregivers

Contiene la información de los cuidadores.

| Campo               | Tipo    | Descripción           |
|---------------------|---------|-----------------------|  
| id_caregiver        | INTEGER | Identificador único   |
| name_caregiver      | TEXT    | Nombre del cuidador   |
| email_caregiver     | TEXT    | Correo electrónico    |
| phone_caregiver     | TEXT    | Teléfono              |
| turno_caregiver     | TEXT    | Turno laboral         |
| hire_date_caregiver | DATE    | Fecha de contratación |
| is_active           | INTEGER | Estado activo         |

---

## 3. health_records

Guarda los registros médicos de los residentes.

| Campo        | Tipo    | Descripción                |
|--------------|---------|----------------------------|
| id           | INTEGER | Identificador del registro |
| resident_id  | INTEGER | ID del residente           |
| record_date  | DATE    | Fecha del registro         |
| diagnosis    | TEXT    | Diagnóstico                |
| treatment    | TEXT    | Tratamiento                |
| notes        | TEXT    | Notas adicionales          |
| vital_status | TEXT    | Estado del residente       |
| is_active    | INTEGER | Estado activo              |


---

## 4. activities

Registra las actividades realizadas por los residentes.

| Campo           | Tipo    | Descripción            |
|-----------------|---------|------------------------|
| id_activity     | INTEGER | Identificador          |
| resident_id     | INTEGER | ID del residente       |
| activity_name   | TEXT    | Nombre de la actividad |
| activity_date   | DATE    | Fecha                  |
| activity_type   | TEXT    | Tipo de actividad      |
| activity_status | TEXT    | Estado                 |
| observations    | TEXT    | Observaciones          |


---

# 📥 Datos Insertados

Se agregaron datos de prueba para:

- 5 residentes
- 5 cuidadores
- 5 registros médicos
- 5 actividades

---

# 🔎 Consultas SQL Implementadas

## 1. Uso de BETWEEN

Consulta de residentes con IDs entre 2 y 4.

```sql
SELECT *
FROM residents
WHERE id_resident BETWEEN 2 AND 4;
```

---

## 2. Uso de IN

Consulta de cuidadores con turno de mañana o tarde.

```sql
SELECT *
FROM caregivers
WHERE turno_caregiver IN ('morning', 'afternoon');
```

---

## 3. Uso de LIKE

Búsqueda de diagnósticos que contienen la palabra `"card"`.

```sql
SELECT *
FROM health_records
WHERE diagnosis LIKE '%card%';
```

---

## 4. Consulta combinada

Actividades médicas o físicas completadas para residentes entre ID 1 y 4.

```sql
SELECT *
FROM activities
WHERE resident_id BETWEEN 1 AND 4
  AND activity_type IN ('medical', 'physical')
  AND activity_status LIKE '%mplet%'
ORDER BY activity_date;
```

---

# ▶️ Ejecución en SQLite3

## Abrir SQLite

```bash
sqlite3 casa_hogar.db
```

## Ejecutar el script SQL

```sql
.read proyecto.sql
```

---

# 📌 Características implementadas

- Uso de claves primarias (`PRIMARY KEY`)
- Restricciones (`CHECK`)
- Claves foráneas (`FOREIGN KEY`)
- Valores únicos (`UNIQUE`)
- Valores por defecto (`DEFAULT`)
- Consultas con:
  - `BETWEEN`
  - `IN`
  - `LIKE`
  - `ORDER BY`

---