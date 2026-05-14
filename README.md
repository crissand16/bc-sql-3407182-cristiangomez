# 🏡 Sistema de Gestión para Casa Hogar de Adultos Mayores

## 📖 Descripción

Este proyecto consiste en una base de datos desarrollada en **SQL** para la administración y gestión de una **Casa Hogar para Adultos Mayores** 👵👴.

El sistema permite almacenar, organizar y consultar información importante relacionada con:

- 🧓 Residentes
- 👨‍⚕️ Cuidadores
- 🩺 Historial médico
- 🎯 Actividades 

El objetivo principal es mejorar la organización de la información y facilitar el seguimiento integral de los residentes.

---

# 🛠️ Tecnologías Utilizadas

- 💾 SQL
- 🗄️ SQLite

---

# 🧩 Estructura de la Base de Datos

La base de datos está compuesta por las siguientes tablas:

---

## 👵 Tabla: `residents`

Almacena la información de los adultos mayores residentes.

### 📌 Campos principales:
- `id_resident`
- `name_resident`
- `document_id_resident`
- `birth_date_resident`
- `gender_resident`
- `admission_date_resident`
- `is_active`

---

## 👨‍⚕️ Tabla: `caregivers`

Contiene la información de los cuidadores de la casa hogar.

### 📌 Campos principales:
- `id_caregiver`
- `name_caregiver`
- `email_caregiver`
- `phone_caregiver`
- `turno_caregiver`
- `hire_date_caregiver`
- `is_active`

---

## 🩺 Tabla: `health_records`

Registra el historial médico y estado de salud de los residentes.

### 📌 Campos principales:
- `id`
- `resident_id`
- `record_date`
- `diagnosis`
- `treatment`
- `notes`
- `vital_status`
- `is_active`

---

## 🎯 Tabla: `activities`

Guarda las actividades realizadas por los residentes.

### 📌 Campos principales:
- `id_activity`
- `resident_id`
- `activity_name`
- `activity_date`
- `activity_type`
- `activity_status`
- `observations`

---

# 📊 Reportes SQL Implementados

## 📌 Reporte 1: Totales Globales
- Total de residentes
- Residentes activos
- Promedio de edad

---

## 📌 Reporte 2: Extremos
- Edad mínima
- Edad máxima

---

## 📌 Reporte 3: Agrupación por Categorías
- Cantidad de actividades por tipo

---

## 📌 Reporte 4: Filtro con `HAVING`
- Estados médicos con más de un registro

---

# 🚀 Ejecución del Proyecto

## 1️⃣ Crear la Base de Datos
Crear una base de datos en SQLite.

## 2️⃣ Ejecutar el Script SQL
Ejecutar el archivo con la creación de tablas.

## 3️⃣ Insertar Datos
Ejecutar los `INSERT INTO` para cargar los datos de prueba.

## 4️⃣ Consultar Reportes
Ejecutar las consultas SQL de reportes.

---

# 🎓 Objetivo Académico

Este proyecto fue desarrollado con fines académicos para practicar:

- 📚 Diseño de bases de datos
- 🔑 Relaciones entre tablas
- 🧠 Consultas SQL
- 📊 Reportes y análisis de datos

---
