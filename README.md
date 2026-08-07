# 🛒 Ecommerce App Flutter

A modern Flutter E-Commerce mobile application built using **Fake Store API**, **Riverpod state management**, and **Clean Architecture principles**.

The application provides a complete shopping experience including authentication, product browsing, product details, shopping cart management, and user profile features.

---

## 📱 Screenshots

(Add screenshots here)

Example:

```
Coming soon...
```

---

# ✨ Features

## 🔐 Authentication
- User login using Fake Store API
- Secure session persistence
- Automatic login detection
- Logout functionality

## 🛍️ Products
- Fetch products from API
- Display products in modern grid layout
- Product details page
- Product rating display
- Category filtering
- Product search

## 🛒 Shopping Cart
- Add products to cart
- Increase/decrease quantity
- Remove products
- Persistent cart storage
- Automatic total calculation

## 👤 Profile
- User profile section
- Logout support

## 🎨 UI/UX
- Modern ecommerce design
- Responsive layouts
- Rounded cards
- Gradient banners
- Material 3 components
- Loading and error states

---

# 🏗️ Architecture

The project follows **Clean Architecture**:

```
lib/

├── core/
│   ├── network/
│   ├── storage/
│   └── theme/

├── features/

│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/

│   ├── products/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/

│   ├── cart/
│   │   ├── data/
│   │   └── presentation/

│   ├── profile/
│   │
│   └── navigation/

└── routes/
```

---

# 🛠️ Technologies Used

## Frontend
- Flutter
- Dart
- Material Design 3

## State Management
- Riverpod

## Networking
- Dio
- REST API

## Storage
- Shared Preferences

## Navigation
- Go Router

## Image Handling
- Cached Network Image

---

# 🌐 API

This application uses:

Fake Store API

```
https://fakestoreapi.com
```

Used endpoints:

```
POST   /auth/login

GET    /products

GET    /products/categories

GET    /products/category/{category}

GET    /products/{id}

GET    /users/{id}
```

---

# 📦 Dependencies

Main packages:

```yaml
flutter_riverpod
dio
shared_preferences
go_router
cached_network_image
equatable
json_annotation
```

---

# 🚀 Getting Started

## Requirements

- Flutter SDK
- Dart SDK
- Android Studio / VS Code

---

## Installation

Clone repository:

```bash
git clone https://github.com/Kumala-Adugna/Ecommerce_app.git
```

Navigate:

```bash
cd Ecommerce_app
```

Install dependencies:

```bash
flutter pub get
```

Run application:

```bash
flutter run
```

---

# 🧪 Testing

Run analyzer:

```bash
flutter analyze
```

Expected:

```
No issues found!
```

---

# 📌 Future Improvements

- Payment integration
- Order history
- Product favorites
- Push notifications
- Dark mode
- Advanced animations
- Backend integration

---

# 👨‍💻 Developer

**Kumala Adugna**

Computer Science and Engineering Student  
Flutter Developer

GitHub:

https://github.com/Kumala-Adugna

---

# 📄 License

This project is developed for educational and portfolio purposes.