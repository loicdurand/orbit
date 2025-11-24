# Research & Decision Log

**Feature**: Initial Project Setup for Orbit

This document records the decisions made for the technical stack. All choices were provided directly in the planning phase, so no exploratory research was required.

---

### Decision: Database
- **Choice**: Isar
- **Rationale**: The user specified Isar for its high performance, strong typing, and suitability for object-oriented models in a Flutter environment.
- **Alternatives Considered**: None, the choice was mandated.

---

### Decision: State Management
- **Choice**: Riverpod (with Code Generation)
- **Rationale**: The user specified Riverpod as the modern standard for Flutter, citing its clean dependency injection and async support.
- **Alternatives Considered**: None, the choice was mandated.

---

### Decision: HTTP Client
- **Choice**: Dio
- **Rationale**: The user specified Dio for its robustness in handling timeouts and retries, which is critical for communicating with potentially slow AI APIs.
- **Alternatives Considered**: None, the choice was mandated.

---

### Decision: Navigation
- **Choice**: GoRouter
- **Rationale**: The user specified GoRouter as the official, standard solution for navigation in Flutter.
- **Alternatives Considered**: None, the choice was mandated.
