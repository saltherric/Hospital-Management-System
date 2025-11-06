# 🏥 Hospital Management System 

## 📖 Project Overview
This project is a **Hospital Management System (HMS)** built using **Dart**.  
It demonstrates **Object-Oriented Programming (OOP)** principles and a **Layered Architecture** consisting of **Domain**, **Data**, and **UI** layers.

The main goal of this project is to design and implement a real-world problem using **good software engineering practices**, focusing on **clarity, modularity, and code reusability**.

---

## 🎯 Selected Feature: Managing Staff
This project focuses on **managing hospital staff**, including:
- 👩‍⚕️ Doctors  
- 👨‍⚕️ Nurses  
- 🧑‍💼 Administrative Personnel  

### ✳️ **Implemented Operations**
|       Operation              | Description |
|------------------------------|-------------|
| ➕ **Add Staff**            | Register new doctors, nurses, or admin staff into the system. |
| 📋 **View All Staff**       | Display details of all registered staff members by type. |
| 🔍 **Search Staff by ID**   | Quickly find a staff member using their unique system-generated ID. |
| ❌ **Remove Staff**         | Delete staff records permanently from the system. |
| ✏️ **Update Staff Info**    | Modify staff attributes like name, department, or salary. |
| ⚙️ **Perform Staff Action** | Simulate real-world staff behaviors (e.g., doctor checkup, nurse assisting, HR managing). |

Each operation demonstrates the use of **Encapsulation**, **Inheritance**, and **Polymorphism** in action.  

---

## 🧱 Architecture Overview
The project follows a **3-Layered Architecture** for clean separation of concerns:
```
Hospital-Management-System/
|── Data/
|   ├── admin.json
|   ├── doctor.json
|   ├── nurse.json
│   │
|── lib/
|   ├── domain/
|   │    ├── staff.dart
|   │    ├── doctor.dart
|   │    ├── nurse.dart
|   │    └── admin_staff.dart
|   ├── data/
|   │    └── staff_repository.dart
|   ├── ui/
│   |    └── main_console.dart
│   └── main.dart
│
└── test/
    └── staff_test.dart
```

---

## 🧰 Technologies & Tools
- **Language:** Dart  
- **Architecture:** Layered (Domain, Data, UI)  
- **Testing Framework:** `package:test/test.dart`  
- **Optional:** File persistence (JSON or text files)

---

## 🧠 System Features in Action  

### 👨‍⚕️ **Doctor**
- Performs patient checkups  
- Prescribes medication

### 👩‍⚕️ **Nurse**
- Assists doctors  
- Updates patient recovery status  

### 👩‍💼 **Admin Staff**
- Performs role-based operations:  
  - **HROfficer:** Manages appointments and staff reports  
  - **Accountant:** Generates financial reports  

---

## 👥 Contributors

- **Kong Visal**
- **Hong Layeang**

## 🎓 Lecturer

- Mr. **Ronan Ogor**

## 🏫 Institution
- **Cambodia Academy of Digital Technology (CADT)**
