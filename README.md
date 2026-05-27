# Lmhung Fresher MB GetX - Flutter Project

A Flutter application built with **Clean Architecture** + **GetX** state management, following the **Feature-first** approach.

---

## 📁 Project Structure

```
lib/
├── main.dart                              # Entry point
│
├── core/                                  # Shared code used across all features
│   ├── common_widget/                     # Reusable UI components
│   │   ├── base_view/
│   │   ├── bottom_sheet/                  # (e.g. base_bottom_sheet.dart)
│   │   ├── button/                        # (e.g. rounded_button.dart)
│   │   ├── dialog/                        # (e.g. base_dialog.dart)
│   │   ├── input/                         # (e.g. text_input_field.dart, custom_search_field.dart)
│   │   ├── loading/
│   │   ├── navigation_bar/               # (e.g. custom_app_bar.dart, profile_app_bar.dart)
│   │   ├── obx_sliver/
│   │   └── pined_header/
│   ├── config/
│   │   └── app_config.dart
│   ├── constants/
│   │   ├── constants.dart
│   │   └── string_constant.dart
│   ├── enum/
│   │   └── soft_option_enums.dart
│   ├── localization/                     # Multi-language support
│   │   ├── app_translations.dart
│   │   ├── en.dart
│   │   └── vi.dart
│   ├── network/                          # Networking layer
│   │   ├── api_endpoint.dart
│   │   ├── dio_client.dart
│   │   ├── header_provider.dart
│   │   ├── data/                         # (e.g. data_state.freezed.dart, data_state.g.dart)
│   │   ├── error/                        # (e.g. failures.freezed.dart)
│   │   └── interceptor/
│   ├── storage/
│   │   ├── secure_storage_service.dart
│   │   └── token/
│   ├── text_style/
│   │   └── app_text_style.dart
│   └── utils/
│       └── app_theme.dart
│
├── feature/                              # Feature modules (self-contained)
│   ├── auth/                             # Authentication feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/                   # (e.g. login_model.freezed.dart, login_model.g.dart)
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/                 # (e.g. auth_token.freezed.dart)
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentaition/                # Note: typo kept as-is (should be "presentation")
│   │       ├── login/
│   │       ├── register/
│   │       └── widget/
│   │
│   ├── category/                         # Category feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   │   ├── category_add_models/
│   │   │   │   ├── category_delete_model/
│   │   │   │   ├── category_response/
│   │   │   │   └── update_category_model/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── controllers/
│   │   │   └── pages/
│   │   └── widget/
│   │
│   ├── dashboard/                        # Dashboard feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── home/                             # Home feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── product/                          # Product feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── model/                    # (e.g. product_model.freezed.dart, product_model.g.dart)
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entity/                   # (e.g. product_entity.freezed.dart)
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── controllers/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   ├── setting/                          # Setting feature
│   │   └── presentation/
│   │
│   └── splash/                           # Splash screen
│       ├── splash_binding.dart
│       ├── splash_controller.dart
│       └── splash_page.dart
│
├── dependencies_injection/               # Global DI setup
│   └── app_binding.dart
│
├── gen/                                  # Auto-generated assets
│   ├── assets.gen.dart
│   └── colors.gen.dart
│
└── navigation/                           # Route configuration
    ├── app_routers.dart
    └── routes.dart
```

### Architecture Overview

This project follows **Clean Architecture** with 3 layers:

| Layer | Responsibility | Location |
|-------|---------------|----------|
| **Data** | Network calls, local storage, DTOs/models, repository implementations | `feature/*/data/` |
| **Domain** | Business entities, repository interfaces, use cases | `feature/*/domain/` |
| **Presentation** | UI pages, GetX controllers, feature-specific widgets | `feature/*/presentation/` |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.10.3`
- Dart SDK (bundled with Flutter)
- An IDE (VS Code, Android Studio, or IntelliJ)

### 1. Clone the repository

```bash
git clone https://github.com/Hung2003s/lmhung_freshermb_getx_repo.git
cd lmhung_freshermb_getx_repo
```

### 2. Create environment file

This project uses `flutter_dotenv` for environment variables.  
Create a `.env` file in the **project root**:

```bash
# .env
BASE_URL=https://your-api-base-url.com
```

> **Note:** `.env` is already in `.gitignore` and will not be committed.

### 3. Get dependencies

```bash
flutter pub get
```

### 4. Generate code

This project uses code generation for:
- **Freezed** — immutable data classes (`*.freezed.dart`)
- **JSON Serializable** — JSON serialization (`*.g.dart`)
- **FlutterGen** — type-safe asset references (`lib/gen/*.dart`)

Run the following command to generate all required files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Or watch mode for continuous generation during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

> **Note:** Generated files (`.freezed.dart`, `.g.dart`, `gen/`) are in `.gitignore` and must be regenerated after cloning.

### 5. Run the app

```bash
# Debug mode
flutter run

# Or specify a device
flutter run -d chrome       # Web
flutter run -d windows      # Windows desktop
flutter run -d <device-id>  # Physical device / emulator
```

---

## 🧩 Key Packages

| Package | Purpose |
|---------|---------|
| `get` ^4.7.3 | State management, routing, DI |
| `dio` ^5.9.2 | HTTP client & networking |
| `freezed_annotation` ^3.1.0 | Immutable data classes |
| `json_serializable` ^6.9.0 | JSON serialization |
| `flutter_secure_storage` ^8.0.0 | Secure token storage |
| `flutter_dotenv` ^6.0.1 | Environment variables |
| `dartz` ^0.10.1 | Functional programming (Either, Option) |
| `flutter_svg` ^2.0.10 | SVG rendering |
| `flutter_slidable` ^4.0.3 | Slidable list tiles |
| `flutter_gen_runner` ^5.4.0 | Type-safe asset generation |

---

## 🛠 Code Generation Commands

```bash
# One-time build
dart run build_runner build

# Watch mode (auto-rebuild on changes)
dart run build_runner watch

# Clean & rebuild
dart run build_runner build --delete-conflicting-outputs
```

---

## 🌐 Multi-Language Support

Supported languages:
- **English** (`lib/core/localization/en.dart`)
- **Vietnamese** (`lib/core/localization/vi.dart`)

Language can be changed via the Setting screen.

---

## 🔐 Environment Variables

Create a `.env` file at the project root with the following variable:

| Variable | Description | Example |
|----------|-------------|---------|
| `BASE_URL` | Base URL for the API | `https://api.example.com/v1` |

---

## 📄 License

This project is for educational/practice purposes.