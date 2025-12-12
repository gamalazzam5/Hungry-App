# 🍔 Hungry App

**Hungry App** is a modern food ordering and delivery application built with **Flutter**. It follows a **Feature-First / Clean Architecture** approach to ensure scalability, testability, and code maintainability.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## 📱 Features

* **Browse Food**: View a dynamic list of available food items with high-quality images and details.
* **Product Details**: comprehensive view for each food item including ingredients, price, and description.
* **Shopping Cart**: Add items to your cart, manage quantities, and prepare for checkout.
* **Clean Architecture**: Separation of concerns between Data, Domain, and Presentation layers.
* **Network Layer**: robust API handling with custom error management and endpoints.

## 🛠️ Tech Stack & Architecture

This project is built using **Flutter** and **Dart**, structured around a feature-driven design:

* **Core**: Contains shared utilities, constants, and network logic (`api_service`, `app_colors`, etc.).
* **Features**: Independent modules for each business capability (e.g., `food`, `carts`).
    * **Data**: Models and Repositories.
    * **View**: UI Screens and Pages.
    * **Widgets**: Reusable UI components specific to the feature.

## 📂 Project Structure

A high-level overview of the file structure:

```text
lib/
├── core/
│   ├── constants/
│   │   ├── api_endpoints.dart    # API URL definitions
│   │   ├── app_colors.dart       # App-wide color palette
│   │   └── app_strings.dart      # String constants & localization
│   ├── network/
│   │   ├── api_service.dart      # HTTP client & request handling
│   │   └── api_exceptions.dart   # Custom exception handlers
│   └── utils/
│       ├── helpers.dart          # Helper functions
│       └── validators.dart       # Input validation logic
├── features/
│   ├── food/
│   │   ├── data/                 # Food models & repositories
│   │   ├── view/                 # FoodList & FoodDetails screens
│   │   └── widgets/              # FoodCard and other specific widgets
│   └── carts/
│       ├── data/
│       ├── view/
│       └── widgets/
├── root.dart                     # Root application wrapper
└── main.dart                     # Entry point
