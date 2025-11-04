# 🧠 MHS — Mental Health Score  
*A modern iOS app that helps users measure, track, and improve their mental well-being.*

<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/c5895338-25f2-47e9-9f7e-c24958c6ae43" />


---

## 📱 Overview

**MHS (Mental Health Score)** is an iOS application built using **SwiftUI** and **Firebase** that enables users to self-assess their mental health via a data-driven, weighted survey.  
It computes a personalized **Mental Health Score (MHS%)**, visualizes the result, and guides users to take action — either reassurance, reflection, or professional support.

---

## ✨ Features

- 🧭 **Onboarding & Splash Screen** – smooth entry animation with custom logo  
- 🔐 **Firebase Authentication** – secure user sessions  
- 📋 **Dynamic Survey System** – smart weighted questions about mood, sleep, stress, etc.  
- 🧮 **Scoring Algorithm** – calculates an MHS% using data-mining–style weighted averages  
- 📊 **Results Visualization** – animated score ring with color feedback  
- 🩺 **Specialist Recommendations** – fetches curated professionals from Firestore  
- 🕒 **History Tracking** – stores and displays past survey scores  
- 🔔 **Weekly Reminders** – gentle local notifications to check in  
- 🌙 **Light / Dark Mode Support** – fully adaptive SwiftUI design  
- ⚙️ **Settings Screen** – reminders, color themes, and sign-out  

---

## 🧩 Architecture

**Pattern:** MVVM (Model–View–ViewModel)

| Layer | Description |
|--------|-------------|
| `App/` | Root app setup and router |
| `Core/` | Models, Services, and reusable logic |
| `Features/` | UI modules (Auth, Survey, Results, Specialists, etc.) |
| `Data/` | DTOs and Firestore integration |
| `Assets/` | App icon, colors, gradients |

---

## 🧮 Algorithm — Weighted Scoring Engine

The **ScoreEngine** is the analytical heart of MHS.  
It uses a **weighted scoring model** inspired by data-mining and expert decision systems.

### Formula
Each survey question has a **rank weight**, and each answer has an **option weight**.  
The final MHS% is computed as:


### Example
| Question | Rank | Selected Option | Option Weight | Contribution |
|-----------|-------|------------------|----------------|---------------|
| Sleep Hours | 0.3 | 7–8 hours | 1.0 | 0.3 |
| Stress Level | 0.4 | Moderate | 0.7 | 0.28 |
| Energy | 0.3 | Low | 0.4 | 0.12 |

**Score:** `(0.3 + 0.28 + 0.12) / (0.3+0.4+0.3) × 100 = 70%`

- ✅ Above threshold → *Healthy mental state*  
- ⚠️ Below threshold → *Encourage self-care or professional help*  
- 🚨 Safety flags → *Immediate guidance to specialists*

---

## 🧱 Tech Stack

- **Language:** Swift 5.9  
- **Framework:** SwiftUI  
- **Backend:** Firebase (Auth, Firestore, App Check)  
- **Storage:** Firestore  
- **Notifications:** UserNotifications (local weekly reminders)  
- **Architecture:** MVVM + Router pattern  
- **Tools:** Firebase Emulator Suite, Xcode 15  

---

## 🔒 Security & Privacy

- Uses **Firebase App Check** for backend validation  
- **No personal data** shared externally  
- Local notifications only (no remote push)  
- User scores are stored per authenticated user ID  

---

## 🧠 Future Enhancements

- 🧾 Journal and Reflection Notes  
- 📈 Analytics dashboard for mood trends  
- 💬 Chatbot integration for mental wellness tips  
- 🪄 Machine Learning model for adaptive scoring  

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash 
   https://github.com/khondep/MHS.git
