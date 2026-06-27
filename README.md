# 🏡 Sistema de Gestión de Residentes y Cuidadores de una Casa Hogar / Adultos Mayores

Este proyecto consiste en la creación y manipulación de una base de datos relacional utilizando SQLite para gestionar información de residentes y cuidadores en una institución.

## 📌 Semana 03: INSERT INTO, UPDATE, DELETE

Este proyecto implementa operaciones básicas de manipulación de datos (**DML**) utilizando SQLite.
El dominio trabajado corresponde a un sistema de gestión para residentes y cuidadores.

---

## 🧱 Estructura de la Base de Datos

Se crean tres tablas principales:

* **residents** → Información de los residentes
* **caregivers** → Información de los cuidadores
* **health_records** → Historial médico (tabla hija con clave foránea)

### 🔗 Relaciones

* `health_records.resident_id` → referencia a `residents.id_resident`

---

## 🧪 PARTE 1: INSERT INTO

Se insertan datos iniciales en las tablas principales.

### 👤 Tabla: residents

Se insertan 5 residentes con datos básicos como nombre, documento, fecha de nacimiento y género.

### 🧑‍⚕️ Tabla: caregivers

Se insertan 5 cuidadores con información de contacto y turno:

* morning
* afternoon
* night

### 🏥 Tabla: health_records

Se insertan registros médicos asociados a los residentes, respetando la clave foránea.

---

## ✏️ PARTE 2: UPDATE

Se aplican diferentes tipos de actualización:

### ✅ Actualización por clave primaria

Se cambia el nombre de un residente específico:

* ID: 1 → "Carlos Rodriguez"

### ✅ Actualización de múltiples columnas

Se modifica el teléfono y turno de un cuidador:

* ID: 2 → turno cambia a "night"

### ✅ Actualización de múltiples filas (regla de negocio)

Se desactivan residentes nacidos antes de 1945:

* `is_active = 0`

---

## 🗑️ PARTE 3: DELETE SEGURO

### 🔍 Verificación previa

Se identifican los registros críticos:

```sql
SELECT id, resident_id, diagnosis
FROM health_records
WHERE vital_status = 'critical';
```

### ❌ Eliminación

Se eliminan los registros con estado crítico:

```sql
DELETE FROM health_records
WHERE vital_status = 'critical';
```

---

## 📊 VERIFICACIÓN FINAL

Se consultan los datos finales de cada tabla:

```sql
SELECT * FROM residents ORDER BY id_resident;
SELECT * FROM caregivers ORDER BY id_caregiver;
SELECT * FROM health_records ORDER BY id;
```

---

## ⚙️ Tecnologías utilizadas

* SQLite3
* SQL (DDL + DML)

---

## 🧠 Aprendizajes clave

* Uso de `INSERT INTO` para poblar tablas
* Uso de `UPDATE` para modificar datos específicos y masivos
* Uso de `DELETE` con validación previa
* Manejo de claves foráneas
* Aplicación de reglas de negocio en consultas SQL

---

## 🚀 Cómo ejecutar

1. Abrir SQLite:

```bash
sqlite3 mi_dominio.db
```

2. Ejecutar el script:

```sql
.read proyecto.sql
```

---

## ✅ Resultado esperado

* Tablas correctamente creadas
* Datos insertados
* Actualizaciones aplicadas
* Registros críticos eliminados
* Consultas finales mostrando el estado actual

---
