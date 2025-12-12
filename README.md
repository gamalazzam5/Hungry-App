# 🍔 Hungry App

**Hungry App** is a sophisticated food ordering and delivery application, engineered for scalability and performance. It is built with **Flutter**, adhering to a strict **Feature-First** and **Clean Architecture** methodology. This design ensures a highly maintainable codebase, testability, and a clear separation of concerns, making it a robust solution for modern mobile app development.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)


## 📖 Table of Contents

- [Features](#-features)
- [Architecture & Design](#-architecture--design)
- [Project Structure](#-project-structure)

## 📱 Features

The application is composed of several key functional modules:

* **🔐 Authentication**: Secure user onboarding with login, registration, and splash screen functionalities.
* **🏠 Home Dashboard**: A dynamic landing page showcasing featured foods, categories, and promotions.
* **🍔 Product Catalog**: Detailed product listings with high-quality images, descriptions, and ingredient information.
* **🛒 Shopping Cart**: A comprehensive cart management system for adding, removing, and adjusting item quantities.
* **💳 Checkout Process**: A streamlined and secure checkout flow for finalizing orders.
* **📜 Order History**: A section for users to view their past orders and track current delivery status.

## 🏛️ Architecture & Design

This project is structured around a **Feature-First** approach combined with **Clean Architecture** principles. This means the application is divided into distinct functionalities (features), and each feature is internally organized into layers that separate business logic from UI and data handling.

Each feature module (e.g., `cart`, `product`) contains its own isolated **Data** and **Presentation** layers:

### **Data Layer (`data/`)**
Responsible for data retrieval and management. It is further divided into:
* **`data_sources/`**: Contains the logic for making remote API calls.
* **`models/`**: Defines the data structures (Dart classes) used to model incoming data from sources. These are typically plain Dart objects (DTOs).
* **`repos/`**: Implementations of the repository interface. This layer acts as a single source of truth for the data, coordinating between different data sources and mapping data models to domain entities.

### **Presentation Layer (`presentation/`)**
Responsible for the UI and user interaction. It includes:
* **`manager/`**: Contains the state management logic ( BLoC). It handles user events, communicates with the repository, and emits new states for the UI to render.
* **`views/`**: The main screen files composed of widgets. These represent the full pages the user sees.
* **`widgets/`**: Reusable, smaller UI components specific to that feature.

This modular, layered approach ensures that changes in one part of the system (like switching a database or modifying a UI widget) have minimal impact on others, greatly enhancing maintainability and testability.

## 📂 Project Structure

The file structure is a direct reflection of the architectural design.

```text
lib/
├── core/                   # Shared resources across features
├── features/               # Feature-specific modules
│   ├── auth/               # Authentication feature
│   ├── cart/               # Shopping cart feature
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   ├── models/
│   │   │   └── repos/
│   │   └── presentation/
│   │       ├── manager/
│   │       ├── views/
│   │       └── widgets/
│   ├── checkout/           # Checkout process feature
│   │   ├── data/           # (Follows same structure as cart/data)
│   │   └── presentation/   # (Follows same structure as cart/presentation)
│   ├── home/               # Home screen feature
│   │   ├── data/
│   │   └── presentation/
│   ├── orderHistory/       # Order history feature
│   │   ├── data/
│   │   └── presentation/
│   ├── product/            # Product browsing feature
│   │   ├── data/
│   │   └── presentation/
│   └── splash/             # Splash screen feature
├── main.dart               # Application entry point
└── root.dart               # Root widget setting up app-wide providers/themes


## 🛠️ Tech Stack

* **Framework**: [Flutter](https://flutter.dev)
* **Language**: [Dart](https://dart.dev)
* **Architecture**: Feature-First, Clean Architecture
* **State Management**: (flutter_bloc)
* **Networking**: (DIO)
* **Service Locator**: (Specify your choice, e.g., get_it)

## 🚀 Getting Started

Follow these steps to set up the project locally.

### Prerequisites

* Make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
* An IDE like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio) with the Flutter and Dart plugins installed.
