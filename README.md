# 🚨 GasGuard – Flutter App for IoT-based Gas Leakage Monitoring

[![Flutter](https://img.shields.io/badge/Framework-Flutter-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Backend-Firebase-yellow.svg)](https://firebase.google.com/)
[![Platform](https://img.shields.io/badge/Platform-Android-green.svg)](https://developer.android.com/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)]()

This is the official Flutter-based mobile application for **GasGuard**, an IoT-driven gas leakage detection and monitoring system. It connects to the ESP8266 device via **Firebase Realtime Database** and displays **live gas values**, **controls exhaust fan and alarm**, and stores **leakage history** in **Firestore**.

---

## 📱 Key Features

- 🔴 **Live Sensor Monitoring** – Displays real-time gas value from Firebase
- 📊 **History Page** – Shows all threshold-exceeding events with timestamp
- 🚨 **Push Notifications** – Alerts user when gas level exceeds the set threshold
- 🔁 **Fan & Alarm Control** – Toggle fan and alarm status remotely (with safety checks)
- 📵 **Control Lock** – Fan button is disabled during gas leakage to ensure safety
- 📂 **About and Contact Pages** – Informational screens built-in
- 📡 Works in sync with the ESP8266 firmware to automate responses

---

## 🛠️ Tech Stack

| Layer        | Technology                     |
|--------------|--------------------------------|
| Frontend     | Flutter (Dart)                 |
| Backend      | Firebase Realtime Database     |
| Data Logs    | Firebase Firestore             |
| Notifications| Firebase Cloud Messaging (FCM) |
| IDE          | Android Studio                 |

---

## 🖼 Screenshots

> *(Replace placeholders if needed and store them in `/assets/screenshots/`)*

