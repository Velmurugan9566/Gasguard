# 🔌 GasGuard - ESP8266 for Gas Detection

[![Arduino](https://img.shields.io/badge/Platform-ESP8266-orange.svg)](https://www.espressif.com/en/products/socs/esp8266)
[![C++](https://img.shields.io/badge/Language-C++-blue.svg)]()
[![Firebase](https://img.shields.io/badge/Data-Firebase-lightgreen.svg)](https://firebase.google.com/)
[![SMS](https://img.shields.io/badge/Alert-Twilio-red.svg)](https://www.twilio.com/)

This is the Arduino-compatible firmware for the **ESP8266 NodeMCU** that detects gas leakage using an MQ-6 sensor and performs real-time actions like:

- Triggering alarms and exhaust fan
- Sending sensor data to Firebase
- Sending SMS alerts via Twilio API

---

## ⚙️ Features

- 🧪 Read real-time gas concentration from MQ-6 sensor
- 🔔 Activate buzzer and fan when threshold is exceeded
- 🌐 Send sensor values to Firebase Realtime Database
- 📄 Log threshold events into Firestore with timestamps
- 📩 Send **SMS alerts** to saved contacts via Twilio (no app required)

---

## 🔧 Tech Stack

| Component        | Tech              |
|------------------|-------------------|
| Microcontroller  | ESP8266 NodeMCU   |
| IDE              | Arduino IDE       |
| Programming      | C++               |
| Cloud Sync       | Firebase (RTDB + Firestore) |
| Alerting         | Twilio (HTTP API) |

---

## 🛠 Hardware Used

- MQ-6 Gas Sensor
- ESP8266 NodeMCU
- 5V DC Fan & Relay Module
- Active Buzzer
- 5V Step-down Converter
- Jumper Wires + Power Supply

---

## 📦 Library Dependencies

- `ESP8266WiFi.h`
- `FirebaseESP8266.h`
- `WiFiClientSecure.h` (for Twilio HTTPS)
- `ArduinoJson.h`

Install these via Arduino Library Manager.

---

## 🚀 Getting Started

1. Open `main.ino` in Arduino IDE  
2. Update WiFi, Firebase, and Twilio credentials  
3. Select **NodeMCU 1.0 (ESP-12E Module)** as board  
4. Connect via USB and click Upload

---

## 🔮 Future Enhancements

- [ ] EEPROM-based offline logging
- [ ] Auto-reconnect Wi-Fi fallback logic
- [ ] Multi-sensor support for different gases
- [ ] AI-based leak prediction
- [ ] Battery backup status indicator

---

## 📄 License

MIT License
