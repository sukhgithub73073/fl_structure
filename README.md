# 🧱 fl_structure – Flutter Clean Architecture Boilerplate with BLoC

[![Flutter](https://img.shields.io/badge/Flutter-Framework-blue)](https://flutter.dev/)
[![BLoC](https://img.shields.io/badge/State-BLoC-52c41a)](https://bloclibrary.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> A starter template for Flutter apps using clean architecture, BLoC pattern, network layer abstraction, logging, and utility management.

---

## 🚀 What is `fl_structure`?

`fl_structure` is a **boilerplate Flutter project** that helps you kickstart your development using a **modular, scalable, and testable structure**. This template is designed using:
- 🧱 Clean architecture principles  
- ⚙️ Bloc state management  
- 🌐 Centralized API handling  
- 🔐 Built-in auth model & repository pattern  
- 🧪 Toast utilities, logging, and response handlers

---

## 📦 What's Included

### 🔑 Authentication Module

- Auth model with login/register structure
- Auth repository for handling login/logout using API
- BLoC/Cubit for managing auth state
- Easy-to-replace or extend with Firebase, Supabase, or custom APIs

---

### 🌐 Network Layer

- Centralized `ApiClient` using `Dio` or `http`
- Response handler: clean success/error separation
- Custom exceptions with logger support

---

### 🧰 Utilities

- Global `Logger` utility (for debug-friendly logs)
- `ToastUtil` – Global toast messages
- Connectivity checker
- Base error/response handler

---


## 🧪 Getting Started

```bash
git clone https://github.com/your-username/fl_structure.git
cd fl_structure
flutter pub get
flutter run

🔧 Setup Tips

    ✅ Replace base URLs and auth endpoints in api_constants.dart

    ✅ Extend existing Cubits or add more for other modules

    ✅ Customize the AppTheme, AppRoutes, and AppNavigator for your needs

💡 Why Use This?

    💼 Ideal for professional or enterprise apps

    📦 Scalable folder structure

    🚀 Faster project setup from scratch

    🔄 Easily extensible for any feature

👨‍💻 Author

Sukhmander Singh

📄 License

This project is licensed under the MIT License.
✨ Build powerful Flutter apps, faster and cleaner — with fl_structure!


---

### ✅ What to Do Next:

1. Create a new repo named **`fl_structure`**.
2. Paste the above content into your `README.md`.
3. Replace:
   - `your-username` with your actual GitHub username in the clone link.
   - Add real screenshots if available.
4. Commit and push.

---

Would you like:
- A **GIF walkthrough** of the structure?
- **Folder icons & structure image** for visual representation?
- `LICENSE`, `.gitignore`, or `pubspec.yaml` starter file?

Let me know and I’ll help you prep it!
