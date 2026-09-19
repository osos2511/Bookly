# 📚 Bookly

A Flutter book-discovery app built on the **Google Books API**. Browse featured and newest books, view details, and search the catalogue live.

### 1. Project Overview
* **Bookly App:** A responsive book-discovery application powered by the **Google Books API**.
* **Key Screens:**
    * **Splash:** Animated entry screen.
    * **Home:** Featured carousel + newest books list.
    * **Book Details:** Comprehensive book information and preview actions.
    * **Search:** Real-time query execution.

---

### 2. Architecture
* **Clean Architecture (Feature-First):** Codebase is modularized by feature (`splash`, `home`, `search`) rather than technical type.
* **Presentation Layer:** Uses **Cubit (BLoC)** as the ViewModel to handle UI states (`Loading`, `Success`, `Failure`).
* **Data Layer:** Implements the **Repository Pattern** to decouple API fetching logic from presentation code.

---

### 3. Data & Error Handling
* **Networking:** Powered by **Dio** for robust HTTP requests and handling responses.
* **Functional Error Handling:** Utilizes **`dartz` (`Either<Failure, T>`)** to enforce compile-time error checking and prevent leaking `try/catch` blocks into the UI layer.

---

### 4. Responsive Design Strategy
* **Design Baseline:** Configured with **`flutter_screenutil`** using a `375 × 812` design size.
* **Scaling Conventions:**
    * `.sp` for typography & icon sizing.
    * `.w` and `.h` for horizontal and vertical layout dimensions.
    * `.r` for consistent `BorderRadius`.