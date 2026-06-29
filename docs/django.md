# CoverMe

> A smart teacher substitution management system designed to simplify daily timetable adjustments in schools.

---

## Overview

CoverMe is a mobile-first application built to assist the **Headmaster/Headmistress (HM)** in managing teacher substitutions efficiently.

The application allows the HM to:

- View today's timetable
- Mark teachers on leave
- Generate substitution tasks automatically
- Find available teachers
- Assign substitute teachers
- Search teachers and view their timetables

The long-term vision is to make CoverMe a complete school substitution management system.

---

# Current Architecture

```
Flutter App
      │
      │ REST API
      ▼
Django Backend
      │
SQLite Database
```

---

# Technology Stack

## Frontend

- Flutter
- Provider
- Dio
- Go Router
- Material 3

## Backend

- Django
- Django REST Framework
- SQLite

---

# Current Project Structure

```
CoverMe/

├── backend/
│
│   ├── core/
│   │
│   ├── models.py
│   ├── serializers.py
│   ├── views.py
│   ├── urls.py
│   │
│   ├── services/
│   │
│   │   dashboard_service.py
│   │   teacher_service.py
│   │   timetable_service.py
│   │   leave_service.py
│   │   task_service.py
│   │   availability_service.py
│   │
│   └── management/
│
└── frontend/
    │
    ├── lib/
    │
    ├── core/
    ├── providers/
    ├── services/
    ├── models/
    ├── screens/
    ├── widgets/
    └── theme/
```

---

# Backend Features Implemented

## Teacher Module

- Teacher Model
- HM identification
- Teacher listing
- Teacher search
- Teacher timetable retrieval

---

## Timetable Module

- Classroom
- Subject
- Teacher timetable

CSV Import Support

```
Teacher
Day
Period
Classroom
Subject
```

---

## Leave Module

- Add leave
- Prevent duplicate leave
- Leave processing workflow
- Process tracking

---

## Task Generation

Automatic generation of substitution tasks from teacher leaves.

Workflow

```
Teacher Leave

↓

Find Timetable

↓

Generate Tasks

↓

Pending Assignment
```

---

## Availability Engine

Current implementation

Preferred Teachers

- Teachers teaching the same class

Other Teachers

- Any teacher free during that period

---

## Dashboard

Implemented API

```
GET

/api/dashboard/
```

Provides

- HM timetable
- Pending task count
- Leave count

---

# Flutter Features Implemented

## Project Architecture

```
Provider

↓

Service Layer

↓

Models

↓

Widgets

↓

Screens
```

---

## Home Screen

Implemented

- Greeting Header
- Dashboard Cards
- Current Period Card (UI)
- Timetable Card
- Floating Action Button
- Bottom Navigation

---

## Navigation

```
Home

Tasks

Teachers
```

---

## Widgets

Reusable Widgets

- Greeting Header
- Dashboard Card
- Current Period Card
- Period Tile
- Timetable Card

---

## Theme

Material 3

Reusable color palette

Consistent spacing

---

# Database Design

Teacher

- id
- name
- department
- is_hm

---

Classroom

- id
- name

---

Subject

- id
- name

---

Timetable

- teacher
- classroom
- subject
- day
- period

---

Leave

- teacher
- date
- reason
- is_processed

---

SubstitutionTask

- leave
- timetable
- original_teacher
- classroom
- subject
- day
- period
- substitute_teacher
- status

---

# APIs Implemented

Teachers

```
GET /teachers/
```

Leaves

```
POST /leaves/
```

Dashboard

```
GET /dashboard/
```

Generate Tasks

```
POST /tasks/generate/
```

Pending Tasks

```
GET /tasks/pending/
```

Available Teachers

```
GET /tasks/<id>/available/
```

---

# Current Workflow

HM opens app

↓

Dashboard

↓

Add Leave

↓

Generate Tasks

↓

Pending Tasks

↓

Assign Teacher

↓

Done

---

# Planned Features (Not Yet Implemented)

## Flutter

- Dashboard API integration
- Teacher search screen
- Teacher timetable screen
- Pending task screen
- Assign teacher screen
- Add leave bottom sheet
- Loading animations
- Error handling

---

## Backend

- Assignment API
- Task completion
- Task history
- Teacher profile API
- Timetable API
- Search API improvements

---

## V2 Features

- Automatic current period calculation
- Full timetable with FREE periods
- Notifications
- Leave history
- Assignment history
- Teacher workload balancing
- Better recommendation engine
- Timetable editing
- Settings page

---

## Future Vision

Support multiple users

```
HM

Teachers

Vice Principal

HOD
```

---

Cloud Synchronization

```
Flutter

↓

REST API

↓

PostgreSQL
```

---

Teacher Login

Teachers can

- View timetable
- Accept substitutions
- View assigned classes

---

Web Dashboard

Administration Portal

---

Notifications

Push notifications

Substitution alerts

---

Analytics

Most substituted teachers

Monthly reports

Teacher workload

Leave statistics

---

# Future Offline Architecture

The current version uses Flutter + Django.

The planned Version 1 architecture will migrate to:

```
Flutter

↓

Repository Layer

↓

SQLite
```

The application will become completely offline.

The timetable will be imported from CSV on the first launch and stored locally.

No backend server will be required.

---

# Development Status

Backend

- Models
- APIs
- Services
- CSV Import

Status

**~75% Complete**

---

Frontend

- Project Structure
- Navigation
- Dashboard UI
- Reusable Widgets

Status

**~40% Complete**

---

Overall Project Progress

**~60% Complete**

---

# Author

Amal Mehabin

Integrated MSc Computer Science (AI & DS)

Cochin University of Science and Technology (CUSAT)

---

## License

This project is intended for educational and research purposes.