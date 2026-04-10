# Full-Stack Notes App (Flutter + Laravel)

A complete, full-stack mobile application for managing notes. Built with a modern Flutter frontend and a secure Laravel API backend.

## ✨ Features

- **Authentication:** Secure login and registration using Laravel Sanctum and Flutter Secure Storage.
- **CRUD Operations:** Create, Read, Update, and Delete notes.
- **Modern State Management:** Uses Riverpod 3.0 and Code Generation for robust, predictable state.
- **Network Interceptors:** Automated Bearer token injection using Dio.
- **Local Database:** Pre-configured SQLite database for instant setup.

## 🛠️ Tech Stack

- **Frontend:** Flutter, Riverpod, Dio, Freezed/JsonSerializable
- **Backend:** Laravel 11, Sanctum, SQLite

---

## 🚀 Getting Started

### 1. Find Your Local IP Address (For Physical Devices)

If you are running the app on a physical Android/iOS device, your phone needs to know your computer's local Wi-Fi IP address to connect to the backend.

Open a terminal and run:

- **Linux:** `hostname -I`
- **Mac:** `ifconfig | grep "inet " | grep -Fv 127.0.0.1`
- **Windows:** `ipconfig` (Look for IPv4 Address)

_Take note of this IP address (e.g., `192.168.x.x`)._

### 2. Backend Setup (Laravel)

Navigate into the backend directory and set up the API:

```bash
cd notes-api
cp .env.example .env
composer install
php artisan key:generate
php artisan migrate --seed
```

Start the Server:
To allow your mobile device to connect, you must start the server on 0.0.0.0:

Bash
php artisan serve --host=0.0.0.0 --port=8000 3. Frontend Setup (Flutter)
Navigate into the Flutter directory:

Bash
cd flutter_code
Configure the Network:
Open lib/src/shared/network/dio_client.dart and update the baseUrl with the IP address you found in Step 1.

Dart
baseUrl: '[http://192.168.](http://192.168.)x.x:8000/api', // Replace with your actual IP
Install & Run:

Bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run

---
