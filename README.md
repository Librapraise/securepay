# SecurePay & Myafrimall Full-Stack Architecture

Complete, production-ready implementation of **Myafrimall** (Authentication & Dashboard flows) matching the Figma design specifications.

## Project Structure

```text
securepay/
├── backend/                  # Node.js + Express + Mongoose + JWT
│   ├── src/
│   │   ├── config/           # Database & environment configurations
│   │   ├── controllers/      # Auth request handlers
│   │   ├── middlewares/      # Auth guard, error handling & input validator
│   │   ├── models/           # Mongoose User schema with bcrypt password hashing
│   │   ├── routes/           # REST endpoints
│   │   ├── services/         # Business logic & JWT token issuance
│   │   ├── validations/      # Joi schemas for signup & login
│   │   └── app.js            # Express app configuration
│   ├── .env.example
│   ├── package.json
│   └── server.js
│
└── frontend/                 # Flutter Web Application
    ├── lib/
    │   ├── core/
    │   │   ├── constants/    # AppColors, ApiConstants
    │   │   ├── network/      # Dio ApiClient with auth interceptors
    │   │   ├── routes/       # GoRouter with authentication guards
    │   │   └── theme/        # Material 3 theme & GoogleFonts DM Sans
    │   ├── models/           # UserModel JSON serializer
    │   ├── providers/        # AuthProvider ChangeNotifier state machine
    │   ├── views/
    │   │   ├── screens/      # SignUpScreen, LoginScreen, DashboardScreen
    │   │   └── widgets/      # HeroBrandingPanel (responsive split screen)
    │   └── main.dart
    └── pubspec.yaml
```

## How to Run

### 1. Backend (Node.js & Express)

```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your MongoDB URI if needed
npm run dev # or npm start
```

Runs on `http://localhost:5000` with the following endpoints:
- `POST /api/auth/signup`
- `POST /api/auth/login`
- `GET /api/auth/me` (Protected)
- `GET /health`

### 2. Frontend (Flutter Web)

```bash
cd frontend
flutter pub get
flutter run -d chrome
```
