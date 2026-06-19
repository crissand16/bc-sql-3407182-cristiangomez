# 🏡 Sistema de Gestión para Casa Hogar de Adultos Mayores

## Proyecto Semana 09 — JOINs Aplicados al Dominio

Este proyecto consiste en el diseño e implementación de una base de datos relacional en SQLite para la administración de una casa hogar para adultos mayores.

El sistema permite gestionar la información de:

* Residentes
* Cuidadores
* Historiales médicos
* Actividades

Además, implementa relaciones entre tablas mediante claves foráneas y utiliza consultas SQL con **INNER JOIN**, **LEFT JOIN**, **GROUP BY** y **COUNT** para generar reportes relacionales.

---

# 📂 Estructura del Proyecto

```bash
bc-sql/
│
├── casa_hogar.db
├── proyecto.sql
└── README.md
```

---

# 🛠️ Tecnologías Utilizadas

* SQLite3
* SQL
* Visual Studio Code
* Git Bash / Terminal

---

# 🎯 Objetivos del Proyecto

* Diseñar una base de datos relacional.
* Implementar claves primarias y foráneas.
* Aplicar restricciones de integridad.
* Generar datos de prueba masivos.
* Realizar consultas utilizando JOINs.
* Detectar registros huérfanos.
* Generar reportes agregados.

---

# 📋 Funcionalidades Implementadas

✅ Creación de tablas relacionales

✅ Uso de PRIMARY KEY

✅ Uso de FOREIGN KEY

✅ Restricciones NOT NULL

✅ Restricciones UNIQUE

✅ Restricciones CHECK

✅ Valores DEFAULT

✅ Generación automática de datos de prueba

✅ INNER JOIN

✅ LEFT JOIN

✅ GROUP BY

✅ COUNT

✅ Reportes relacionales

---

# 🧱 Modelo de Base de Datos

## Tabla: residents

Almacena la información de los residentes.

| Campo                   | Tipo    | Restricciones        |
| ----------------------- | ------- | -------------------- |
| id_resident             | INTEGER | PRIMARY KEY          |
| name_resident           | TEXT    | NOT NULL             |
| document_id_resident    | TEXT    | UNIQUE               |
| birth_date_resident     | DATE    | NOT NULL             |
| gender_resident         | TEXT    | CHECK                |
| admission_date_resident | DATE    | DEFAULT CURRENT_DATE |
| is_active               | INTEGER | DEFAULT 1            |

---

## Tabla: caregivers

Almacena información de los cuidadores.

| Campo               | Tipo    | Restricciones        |
| ------------------- | ------- | -------------------- |
| id_caregiver        | INTEGER | PRIMARY KEY          |
| name_caregiver      | TEXT    | NOT NULL             |
| email_caregiver     | TEXT    | UNIQUE               |
| phone_caregiver     | TEXT    | NULL permitido       |
| turno_caregiver     | TEXT    | CHECK                |
| hire_date_caregiver | DATE    | DEFAULT CURRENT_DATE |
| is_active           | INTEGER | CHECK                |

---

## Tabla: health_records

Almacena los historiales médicos.

| Campo        | Tipo    | Restricciones        |
| ------------ | ------- | -------------------- |
| id           | INTEGER | PRIMARY KEY          |
| resident_id  | INTEGER | FOREIGN KEY          |
| record_date  | DATE    | DEFAULT CURRENT_DATE |
| diagnosis    | TEXT    | NOT NULL             |
| treatment    | TEXT    | NULL permitido       |
| notes        | TEXT    | NULL permitido       |
| vital_status | TEXT    | CHECK                |
| is_active    | INTEGER | CHECK                |

---

## Tabla: activities

Almacena las actividades realizadas por los residentes.

| Campo           | Tipo    | Restricciones        |
| --------------- | ------- | -------------------- |
| id_activity     | INTEGER | PRIMARY KEY          |
| resident_id     | INTEGER | FOREIGN KEY          |
| activity_name   | TEXT    | NOT NULL             |
| activity_date   | DATE    | DEFAULT CURRENT_DATE |
| activity_type   | TEXT    | CHECK                |
| activity_status | TEXT    | CHECK                |
| observations    | TEXT    | NULL permitido       |

---

# 🔗 Relaciones del Sistema

## residents ↔ health_records

Un residente puede tener múltiples historiales médicos.

```sql
FOREIGN KEY (resident_id)
REFERENCES residents(id_resident)
```

---

## residents ↔ activities

Un residente puede participar en múltiples actividades.

```sql
FOREIGN KEY (resident_id)
REFERENCES residents(id_resident)
```

---

# 📥 Generación de Datos

Para cumplir con los requisitos del proyecto se generaron datos automáticamente mediante consultas recursivas.

Cantidad de registros creados:

| Tabla          | Registros |
| -------------- | --------- |
| residents      | 80        |
| caregivers     | 20        |
| health_records | 60        |
| activities     | 50        |

Esto permite realizar pruebas reales con JOINs y detectar registros sin relación.

---

# 🔍 Consultas Implementadas

## Consulta 1 — INNER JOIN Principal

Muestra los residentes que poseen historial médico.

```sql
SELECT
    r.id_resident,
    r.name_resident,
    hr.diagnosis,
    hr.vital_status
FROM residents r
INNER JOIN health_records hr
ON r.id_resident = hr.resident_id;
```

---

## Consulta 2 — JOIN con Tres Tablas

Relaciona residentes, historiales médicos y actividades.

```sql
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
```

---

## Consulta 3 — LEFT JOIN

Muestra todos los residentes, tengan o no actividades registradas.

```sql
SELECT
    r.id_resident,
    r.name_resident,
    a.activity_name
FROM residents r
LEFT JOIN activities a
ON r.id_resident = a.resident_id;
```

---

## Consulta 4 — Detección de Huérfanos

Muestra residentes sin actividades registradas.

```sql
SELECT
    r.id_resident,
    r.name_resident
FROM residents r
LEFT JOIN activities a
ON r.id_resident = a.resident_id
WHERE a.id_activity IS NULL;
```

---

## Consulta 5 — Reporte Agregado

Cantidad de actividades realizadas por cada residente.

```sql
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
```

---

# ▶️ Cómo Ejecutar el Proyecto

## 1. Abrir una terminal en la carpeta del proyecto

```bash
cd bc-sql
```

---

## 2. Ejecutar el script SQL

```bash
sqlite3 casa_hogar.db < proyecto.sql
```

---

## 3. Abrir SQLite

```bash
sqlite3 casa_hogar.db
```

---

## 4. Verificar tablas creadas

```sql
.tables
```

---

## 5. Consultar datos

```sql
SELECT * FROM residents;
```

---

# 📊 Resultados Esperados

El sistema debe permitir:

* Consultar residentes con historial médico.
* Consultar actividades realizadas.
* Identificar residentes sin actividades.
* Generar reportes estadísticos mediante JOINs.
* Analizar relaciones entre entidades.


