Item Price Tracker

A simple Flutter application for tracking items and their prices.
The app allows users to add items, view them in a list, edit or delete entries, and automatically calculate totals. Data is stored locally using SQLite so that the item history persists even after the app is closed.

This project demonstrates a clean Flutter architecture using BLoC state management, repository pattern, and dependency injection.

  **Features**

Add items with price

View list of saved items

Edit existing items

Delete items

Automatic total price calculation

Automatic total item count

Number formatting with comma separators

Local data persistence using SQLite

Sorted item display (ascending price)

 **Architecture**

The application follows a Clean Architecture structure to keep the code modular and maintainable.

UI (Presentation)
↓
BLoC (State Management)
↓
Repository
↓
Datasource
↓
SQLite Database
 
 **Layers**

Presentation

UI widgets

BLoC for state management

 **Domain**

Entities

Repository interfaces

  **Data**

Repository implementation

SQLite datasource

 **Project Structure**
lib
│
├── core
│   └── di
│       └── service_locator.dart
│
├── data
│   ├── datasources
│   ├── models
│   └── repositories
│
├── domain
│   ├── entities
│   └── repositories
│
├── presentation
│   ├── bloc
│   └── screens
│
└── main.dart

 ## **Technologies Used**

* Flutter
* 
* BLoC State Management
* 
* SQLite (sqflite)
* 
* Dependency Injection (get_it)
* 
* Clean Architecture principles
* 
* Intl package for number formatting