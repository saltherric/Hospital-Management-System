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

### ✳️ Key Operations:
- Add new staff members  
- View all staff information  
- Search staff by ID or department  
- Remove staff from the system  

This feature demonstrates OOP principles through **inheritance**, **polymorphism**, and **encapsulation** while keeping the implementation simple and focused.

---

## 🧱 Architecture Overview
The project follows a **3-Layered Architecture** for clean separation of concerns:
```
Hospital-Management-System/
|── Data/
|   ├── admin.json
|   ├── doctor.json
|   ├── nurse.json
|── lib/
|   ├── domain/
|   │    ├── staff.dart
|   │    ├── doctor.dart
|   │    ├── nurse.dart
|   │    └── admin_staff.dart
|   ├── data/
|   │    └── staff_repository.dart
|   └── ui/
|         └── main_console.dart
└── test/
    └── staff_test.dart

```

### 🔹 Layer Descriptions

| Layer       | Description |
|-------------|-------------|
| **Domain**  | Defines core classes like `Staff`, `Doctor`, `Nurse`, and `AdminStaff`. |
| **Data**    | Provides in-memory data management (add, remove, search, list). |
| **UI**      | Offers a console-based menu for interaction. |
| **Test**    | Contains automated tests for domain logic using `package:test/test.dart`. |


---

## 🧰 Technologies & Tools
- **Language:** Dart  
- **Architecture:** Layered (Domain, Data, UI)  
- **Testing Framework:** `package:test/test.dart`  
- **Optional:** File persistence (JSON or text files)

---

## ⚙️ How to Run the Project
1. Clone or download the project folder.  
2. Open the project in VS Code or any Dart-supported IDE.  
3. Run the following command to start the console program:
   ```bash
   dart run lib/ui/main_console.dart

## 👥 Contributors

- **Kong Visal**
- **Hong Layeang**

## 🎓 Lecturer

- Mr. **Ronan Ogor**

## 🏫 Institution
- **Cambodia Academy of Digital Technology (CADT)**
