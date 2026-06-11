# 🏡 Sistema de Gestión para Casa Hogar de Adultos Mayores

Este proyecto consiste en el diseño e implementación de una base de datos relacional en SQLite para la administración de una casa hogar de adultos mayores.

El sistema permite gestionar:

* Residentes
* Cuidadores
* Actividades
* Historiales médicos

Además, implementa restricciones (`constraints`) y manejo de valores `NULL` utilizando SQL.

---

# 📂 Estructura del Proyecto

```bash
bc-sql/
│
├── mi_dominio.db
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

# 📋 Funcionalidades Implementadas

✅ Creación de tablas relacionales
✅ Uso de PRIMARY KEY
✅ Uso de FOREIGN KEY
✅ Restricciones NOT NULL
✅ Restricciones UNIQUE
✅ Restricciones CHECK
✅ Valores DEFAULT
✅ Manejo de NULL
✅ Uso de COALESCE
✅ Inserción de datos de prueba
✅ Consultas SQL

---

# 🧱 Modelo de Base de Datos

## Tabla: residents

Almacena la información de los residentes de la casa hogar.

| Campo                   | Tipo    | Restricciones        |
| ----------------------- | ------- | -------------------- |
| id_resident             | INTEGER | PRIMARY KEY          |
| name_resident           | TEXT    | NOT NULL             |
| document_id_resident    | TEXT    | NOT NULL, UNIQUE     |
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

Almacena historiales médicos de los residentes.

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

# 🔐 Constraints Utilizados

## NOT NULL

Evita que un campo obligatorio quede vacío.

```sql
name_resident TEXT NOT NULL
```

---

## UNIQUE

Evita datos duplicados.

```sql
document_id_resident TEXT UNIQUE
```

---

## CHECK

Valida valores permitidos.

```sql
CHECK (gender_resident IN ('M', 'F', 'Other'))
```

---

## DEFAULT

Asigna valores automáticos.

```sql
admission_date_resident DATE DEFAULT CURRENT_DATE
```

---

## FOREIGN KEY

Relaciona tablas entre sí.

```sql
FOREIGN KEY (resident_id)
REFERENCES residents(id_resident)
```

---

# 📥 Inserción de Datos

El proyecto incluye registros de prueba para:

* Residentes
* Cuidadores
* Actividades
* Historiales médicos

---

# 🔍 Consultas Implementadas

## Mostrar cuidadores sin correo

```sql
SELECT
    id_caregiver,
    name_caregiver
FROM caregivers
WHERE email_caregiver IS NULL;
```

---

## Mostrar actividades sin observaciones

```sql
SELECT
    activity_name,
    observations
FROM activities
WHERE observations IS NULL;
```

---

## Uso de COALESCE

Reemplaza valores NULL por texto personalizado.

```sql
SELECT
    name_caregiver,
    COALESCE(email_caregiver, 'Sin correo') AS email
FROM caregivers;
```

---

# ▶️ Cómo Ejecutar el Proyecto

## 1. Abrir terminal en la carpeta del proyecto

## 2. Ejecutar el script SQL

```bash
sqlite3 mi_dominio.db < proyecto.sql
```

---

## 3. Abrir SQLite manualmente

```bash
sqlite3 mi_dominio.db
```

---

## 4. Ver tablas

```sql
.tables
```

---

## 5. Consultar datos

```sql
SELECT * FROM residents;
```

---

# ⚠️ Problema Común

Si ejecutas varias veces:

```bash
sqlite3 casa_hogar.db < proyecto.sql
```

Los datos pueden duplicarse.

---

# ✅ Solución

Agregar al inicio del archivo:

```sql
DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS health_records;
DROP TABLE IF EXISTS caregivers;
DROP TABLE IF EXISTS residents;
```


