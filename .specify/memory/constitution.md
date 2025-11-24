# Orbit Constitution

## Core Principles

### I. Local-First & Privacy-Centric
All user data is stored on the device by default. The application is designed to function entirely offline. User privacy is paramount; data sent to external services must be anonymized, or processed locally if the device permits.

### II. Cross-Platform Native Performance
The application is built with Flutter (Dart) to deliver a consistent, high-performance native experience on both iOS and Android from a single codebase.

### III. Serene & Efficient User Experience
The user interface must be calm, clean, and minimalist ("Néomorphisme léger ou Minimaliste 'Clean'"). Interactions, especially data capture, must be optimized for speed (under 3 seconds to open and note). Avoid aggressive or distracting notifications.

## Technology Stack

- **Framework**: Flutter (Dart)
- **Architecture**: Local-First
- **Database**: SQLite (via Drift) or Isar for on-device storage.
- **AI Processing**: Integration with external APIs (like OpenAI or Claude) for text analysis, with a strong emphasis on data anonymization before transmission.

## Monetization Model

The code structure must support a Freemium model. The core application is free, with a paywall planned for users with more than 15 contacts and for access to advanced AI-powered features.

## Governance

All development must adhere to these core principles. Any deviation requires justification and formal approval. The 'Local-First' and 'Privacy-Centric' directives are the highest priority and must guide all architectural decisions.

**Version**: 1.0 | **Ratified**: 2025-11-23 | **Last Amended**: 2025-11-23