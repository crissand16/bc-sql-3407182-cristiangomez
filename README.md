# 🏡 Proyecto Semana 04 — Consultas SELECT en SQLite3

## 📖 Descripción

Este proyecto corresponde a la práctica de consultas SQL utilizando **SQLite3** en el dominio de una **Casa Hogar para Adultos Mayores** 👴👵.

El sistema administra información relacionada con:

- 🧓 Residentes
- 👩‍⚕️ Cuidadores
- 🩺 Historiales médicos

Durante el desarrollo se aplicaron consultas usando:

- ✅ `SELECT`
- ✅ `WHERE`
- ✅ `ORDER BY`
- ✅ `LIMIT`
- ✅ `OFFSET`

---

# 🛠️ Tecnologías utilizadas

- 💾 SQLite3
- 📜 SQL

---

# 🗂️ Estructura de la Base de Datos

## 👴 Tabla: `residents`

Almacena la información de los residentes.

| Campo | Tipo |
|---|---|
| `id_resident` | INTEGER |
| `name_resident` | TEXT |
| `document_id_resident` | TEXT |
| `birth_date_resident` | DATE |
| `gender_resident` | TEXT |
| `admission_date_resident` | DATE |
| `is_active` | INTEGER |

---

## 👩‍⚕️ Tabla: `caregivers`

Almacena información de los cuidadores.

| Campo | Tipo |
|---|---|
| `id_caregiver` | INTEGER |
| `name_caregiver` | TEXT |
| `email_caregiver` | TEXT |
| `phone_caregiver` | TEXT |
| `turno_caregiver` | TEXT |
| `hire_date_caregiver` | DATE |
| `is_active` | INTEGER |

---

## 🩺 Tabla: `health_records`

Almacena historiales médicos de los residentes.

| Campo | Tipo |
|---|---|
| `id_health_record` | INTEGER |
| `resident_id` | INTEGER |
| `record_date` | DATE |
| `diagnosis` | TEXT |
| `treatment` | TEXT |
| `notes` | TEXT |
| `vital_status` | TEXT |
| `is_active` | INTEGER |

---

# 🚀 Cómo ejecutar el proyecto

## 1️⃣ Abrir SQLite3

```bash
sqlite3 casa_hogar.db
```

---

## 2️⃣ Ejecutar el script SQL

Copiar y pegar el contenido del archivo `.sql` dentro de SQLite3.

---

## 3️⃣ Verificar tablas creadas

```sql
.tables
```

---

## 4️⃣ Ver estructura de tablas

```sql
.schema residents
```

---

# 🔎 Consultas implementadas

## 📋 Consulta 1 — Listado general

```sql
SELECT
    id_resident AS id_residente,
    name_resident AS nombre_residente,
    document_id_resident AS documento,
    birth_date_resident AS fecha_nacimiento,
    gender_resident AS genero
FROM residents;
```

---

## 🔍 Consulta 2 — Filtro simple

```sql
SELECT
    id_health_record,
    resident_id,
    diagnosis,
    vital_status
FROM health_records
WHERE diagnosis = 'Diabetes';
```

---

## 🧠 Consulta 3 — Filtro combinado

```sql
SELECT
    id_health_record,
    resident_id,
    diagnosis,
    vital_status
FROM health_records
WHERE vital_status = 'stable'
  AND is_active = 1;
```

---

## 📈 Consulta 4 — ORDER BY + LIMIT

```sql
SELECT
    id_resident,
    name_resident,
    admission_date_resident
FROM residents
ORDER BY admission_date_resident DESC
LIMIT 5;
```

📌 Esta consulta muestra los 5 residentes más recientes.

---

## 📄 Consulta 5 — Paginación

### 🥇 Página 1

```sql
SELECT
    id_resident,
    name_resident,
    gender_resident
FROM residents
ORDER BY name_resident ASC
LIMIT 3 OFFSET 0;
```

### 🥈 Página 2

```sql
SELECT
    id_resident,
    name_resident,
    gender_resident
FROM residents
ORDER BY name_resident ASC
LIMIT 3 OFFSET 3;
```

---

# 🧰 Comandos útiles en SQLite3

## 📌 Mostrar tablas

```sql
.tables
```

---

## 📌 Mostrar estructura de una tabla

```sql
.schema nombre_tabla
```


# 🎯 Objetivo del proyecto

Practicar consultas SQL básicas aplicando:

- Selección de datos
- Filtrado de registros
- Ordenamiento
- Límites de resultados
- Paginación

en un contexto real relacionado con el cuidado de adultos mayores 🏡❤️.

---
