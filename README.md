# 🚨 GasGuard – Flutter App for IoT-based Gas Leakage Detection Monitoring

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

**Hardware Connection**
> ![IMG-20250403-WA0016](https://github.com/user-attachments/assets/7fbd05fa-2160-4931-ab81-2b4becc4f871)

__**Home Page**__
> ![IMG_20250227_09223253](https://github.com/user-attachments/assets/57f5107c-a870-4535-bd19-18e86419d853)

__**After Gas Leak**__
> ![IMG_20250227_14360840](https://github.com/user-attachments/assets/15f2616f-8cb2-413b-a1a3-a50afe6e1fc3)

__**History Data Page**__
>![IMG_20250227_09221010](https://github.com/user-attachments/assets/f9c13f16-e05e-4097-aa5c-0f9d19746832)

---
#Project Report
[sample_report.pdf](https://github.com/user-attachments/files/21453111/sample_report.pdf)
