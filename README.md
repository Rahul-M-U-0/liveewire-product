# Livewire Products - E-Commerce Client

A production-grade, premium Flutter application designed for seamless product discovery and shopping cart management, engineered with a meticulous focus on **Clean Architecture**, **State Management**, and modern **Material 3 Design Guidelines**.

---

## Key Architectural Strengths

Livewire Products is built as an enterprise-ready mobile client. It showcases modern engineering practices including:

- **Clean Architecture:** Strict boundaries separating data, domain logic, and presentation interfaces.
- **Reactive State Management:** BLoC and Cubits managing precise state flows.
- **Offline Persistence:** Local storage implementation for caching and persisting shopping cart items between sessions.
- **Robust Networking:** Advanced HTTP client configuration for secure REST API communication.
- **Environment Architecture:** Runtime configuration using environment JSON maps containing target URLs (`ENV=dev`, `staging`, `prod`).

---

## Tech Stack & Key Libraries

| Category                 | Technology / Package                   | Purpose                             |
| :----------------------- | :------------------------------------- | :---------------------------------- |
| **Framework**            | Flutter SDK (`^3.41.9`)                | Core framework                      |
| **State Management**     | `flutter_bloc` (`^9.1.1`), `equatable` | Reactive UI state and event flows   |
| **Dependency Injection** | `get_it` (`^9.2.1`),                   | Service locator and compile-time DI |
| **Navigation**           | `go_router` (`^17.3.0`)                | Declarative, deep-linkable routing  |
| **Networking**           | `dio` (`^5.5.0`), `pretty_dio_logger`  | Robust REST API communication       |
| **Local Storage**        | `shared_preferences`                   | Persistent cart storage             |

---

## Quick Start Checklist

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

````bash
# Fetch flutter packages
flutter pub get


### 3. Launch the Application

Run the app in your emulator/simulator under the target environment:

```bash
# Start in Dev mode
flutter run --dart-define-from-file=env/dev.json
````

---

## Coding Standards & Contributions

When making additions or refactoring the Livewire Products codebase, please adhere to:

1. **Clean Code:** Write small, single-responsibility functions. Keep business logic strictly out of views.
2. **SOLID Principles:** Interfaces first, dependency inversion, and strong type safety.
