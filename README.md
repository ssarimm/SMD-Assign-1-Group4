# Flutter Todo App

**Work done by:** 22k-4299, 22k-4561, 21k-4911, 21k-3379

A simple **Todo List application** built with Flutter that integrates with a REST API backend. This project demonstrates best practices for **fetching and sending data over the internet** using the `http` package, manual JSON serialization, and Material Design UI components.

---

## 🚀 Features

* **Lazy loading with pagination** (10 items per page)
* **Add new todo** with mandatory title and description
* **Mark todo as done / undo**
* **Pull-to-refresh** functionality
* **Responsive Material UI**
* **Manual JSON serialization** (no `build_runner`)
* **Error handling & validation**
* **Loaders** shown during network operations

---

## 📂 Project Structure

```text
lib/
├── main.dart             
├── models/
│    └── todo.dart         
├── services/
│    └── api_service.dart 
├── screens/
│    ├── todo_list.dart    
│    └── add_todo.dart     
└── widgets/
     └── todo_tile.dart
```

## 🔧 Requirements

* **Flutter SDK:** >= 3.0 recommended
* **Dart SDK:** >= 2.18
* **Dependencies:** Only one external dependency: `http`

---

## 🌐 API Reference

This app uses a mock REST API:

* **Base URL:** `https://apimocker.com/todos`
* **GET** `/todos?page={page}&limit=10` → Fetch paginated todos
* **POST** `/todos` → Create new todo
* **PATCH** `/todos/{id}` → Toggle completion status

---

## 📸 Screenshots

![App Screenshot](assets/screenshot1.png)

## 🎓 Learning Outcome

This project helps practice:

1.  **REST API integration** with Flutter.
2.  **Manual JSON serialization** logic.
3.  **Pagination & lazy loading** with `ScrollController`.
4.  **Material Design UI** principles.
5.  **Error handling & validation** for forms.

