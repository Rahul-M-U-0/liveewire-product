# 🌌 Livewire Products - E-Commerce Client

A production-grade, premium Flutter application designed for seamless product discovery and shopping cart management, engineered with a meticulous focus on **Clean Architecture**, **State Management**, and modern **Material 3 Design Guidelines**.

---

## 🚀 Key Architectural Strengths

Livewire Products is built as an enterprise-ready mobile client. It showcases modern engineering practices including:

- **Clean Architecture:** Strict boundaries separating data, domain logic, and presentation interfaces.
- **Reactive State Management:** BLoC and Cubits managing precise state flows.
- **Offline Persistence:** Local storage implementation for caching and persisting shopping cart items between sessions.
- **Robust Networking:** Advanced HTTP client configuration for secure REST API communication.
- **Environment Architecture:** Runtime configuration using environment JSON maps containing target URLs (`ENV=dev`, `staging`, `prod`).

---

## 🛠️ Tech Stack & Key Libraries

| Category                 | Technology / Package                   | Purpose                                 |
| :----------------------- | :------------------------------------- | :-------------------------------------- |
| **Framework**            | Flutter SDK (`^3.11.5`)                | Core framework                          |
| **State Management**     | `flutter_bloc` (`^9.1.1`), `equatable` | Reactive UI state and event flows       |
| **Dependency Injection** | `get_it` (`^9.2.1`), `injectable`      | Service locator and compile-time DI     |
| **Navigation**           | `go_router` (`^17.2.3`)                | Declarative, deep-linkable routing      |
| **Networking**           | `dio` (`^5.9.2`), `pretty_dio_logger`  | Robust REST API communication           |
| **Local Storage**        | `shared_preferences` / `drift`         | Persistent cart storage                 |
| **Code Generation**      | `freezed`, `json_serializable`         | Type-safe data models and state schemas |

---

## 📂 Project Navigation Hub

Livewire Products includes detailed architectural and operational documents. Please refer to them based on your current objectives:

> [!TIP]
>
> ### 📐 Architecture Guidelines
>
> Understand our architectural philosophy, directory patterns, error handling conventions, and state paradigms in [gemini.md](file:///e:/project/flutter%20projects/liveewire_products/gemini.md).

> [!IMPORTANT]
>
> ### ⚙️ Environment Setup & Operations
>
> Discover how to configure local `.json` environments, install tools, run code generators, and launch local builds in [instructions.md](file:///e:/project/flutter%20projects/liveewire_products/instructions.md).

---

## ⚡ Quick Start Checklist

To get the application up and running on your local machine:

### 1. Configure the Environment

Ensure your local environment configuration is in place. By default, Livewire Products looks for configuration under `env/dev.json`.

```json
{
  "baseUrl": "https://dummyjson.com/"
}
```

### 2. Run the Initialization Pipeline

Get all package dependencies and trigger code generators (for BLoCs, Models, and DI bindings):

```bash
# Fetch flutter packages
flutter pub get

# Generate type-safe serialization, DI bindings, and database classes
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Launch the Application

Run the app in your emulator/simulator under the target environment:

```bash
# Start in Dev mode
flutter run --dart-define-from-file=env/dev.json
```

---

## 🤝 Coding Standards & Contributions

When making additions or refactoring the Livewire Products codebase, please adhere to:

1. **Clean Code:** Write small, single-responsibility functions. Keep business logic strictly out of views.
2. **SOLID Principles:** Interfaces first, dependency inversion, and strong type safety.
3. **Tests:** Implement unit tests for domain usecases and widget tests for key interactive components under `/test`.
