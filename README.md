# 🏡 Sistema de Gestión - Casa Hogar para Adultos Mayores

Este proyecto consiste en el diseño e implementación de una base de datos en SQLite para la gestión de una casa hogar enfocada en el cuidado de adultos mayores.

---

## 📌 Descripción

El sistema permite administrar información clave sobre:

👴 Residentes (adultos mayores)
🧑‍⚕️ Cuidadores
🩺 Registros de salud

El objetivo es centralizar y estructurar la información para facilitar el seguimiento médico, la asignación de personal y la gestión general del hogar.

---

## 🛠️ Tecnologías Utilizadas

- SQLite3
- SQL (Structured Query Language)
- Terminal / Bash
- Visual Studio Code

---

## 🗂️ Estructura de la Base de Datos

## 🧍‍♂️ Tabla: residents

Almacena la información de los adultos mayores.

```sql
CREATE TABLE IF NOT EXISTS residents (
    id                      INTEGER PRIMARY KEY,
    full_name               TEXT    NOT NULL,
    document_id             TEXT    NOT NULL UNIQUE,
    birth_date              DATE    NOT NULL,
    gender_resident         TEXT    CHECK (gender_resident IN ('M', 'F', 'Other')),
    admission_date_resident DATE    NOT NULL DEFAULT CURRENT_DATE,
    is_active               INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1))
);
```

## 🧑‍⚕️ Tabla: caregivers

Información del personal encargado del cuidado.

```sql
CREATE TABLE IF NOT EXISTS caregivers (
    id              INTEGER PRIMARY KEY,
    full_name       TEXT    NOT NULL,
    email           TEXT    UNIQUE,
    phone           TEXT,
    shift           TEXT    NOT NULL CHECK (shift IN ('morning', 'afternoon', 'night')),
    hire_date       DATE    NOT NULL DEFAULT CURRENT_DATE,
    is_active       INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1))
);
```

## 🩺 Tabla: health_records

Registro médico de los residentes.

```sql
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
```

---

## ⚙️ Cómo ejecutar el proyecto

1. Asegúrate de tener instalado SQLite:
    sqlite3 --version

2. Ejecuta el script SQL:
    sqlite3 mi_dominio.db < starter/proyecto.sql

3. Ejecuta:
    sqlite3 mi_dominio.db

4. Ver tablas:
    .tables

5. Mostrar tablas:
    PRAGMA table_info(nombre_tabla);

---

## 🧠 Buenas prácticas aplicadas
- Uso de PRIMARY KEY para identificación única
- Restricciones UNIQUE para evitar duplicados
- Validaciones con CHECK
- Valores por defecto con DEFAULT
